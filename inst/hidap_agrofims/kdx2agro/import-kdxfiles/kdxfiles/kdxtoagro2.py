import zipfile
import os
import csv
from dateutil import parser
import pandas as pd
import numpy as np
import re

def kdx2agrofims(zip_name, excel_name):
    if not zip_name.endswith(".zip"):
        return "First argument is not a zip file"
    elif not(excel_name.endswith(".xls") or excel_name.endswith(".xlsx")):
         return "Second argument is not an excel file"
        
    path_to_zip_file = zip_name
    try:
        with zipfile.ZipFile(path_to_zip_file, 'r') as zip_ref:
            try:
                zip_ref.extractall('./')
            except:
                return 'Error - Cannot unzip '+ path_to_zip_file+ ". Check that "+zip_name+" is a valid zip file."
    except:
        return "Error - Cannot open "+ path_to_zip_file
    
    folder_unzip = os.path.basename(path_to_zip_file).replace(".zip","") #zip_name.replace(".zip","")

    nameWithSpace = re.search(',(.*),', folder_unzip)
    folder_unzip = folder_unzip.split(",")[0]+","+nameWithSpace.group(1).replace("_", " ")+","+folder_unzip.split(",")[2]
    if "[" in folder_unzip:
        folder_unzip = folder_unzip.split("[")[0]
    folder_unzip += "/"
    
    ## Read plot file and build a dictionary where key is excel plot ID is KDS plot id and value is excel plot ID
    ## unzipped folder

    plotsFile = folder_unzip +"plots.csv"
    tagsFile =  folder_unzip +"tags.csv"
    plots = {}
    tags = {} ## tags[plotID] = [tags]
    tagsDesc = {} ## tag description
    try:
        with open(tagsFile) as t:
            reader = csv.DictReader(t)
            try:
                for row in reader:
                    tagsDesc[row["Label"]]=row["Description"]
            except:
                return "Error - zip file is not a valid KDX zip file. Please download data from KDSMART again."

        with open(plotsFile) as f:
            reader = csv.DictReader(f)
            for row in reader:
                try:
                    plots[row['Link:PlotId']]=row['PlotId']
                    #print(row)
                    if row['Tags']:
                        tagValues= row['Tags'].split("|")
                        for t in tagValues:
                            tagDesc = ""
                            if (row['PlotId'] in tags):
                                tags[row['PlotId']].append([t, tagsDesc[t]])
                            else:
                                tags[row['PlotId']] = [[t, tagsDesc[t]]]
                except:
                    return "Error - zip file is not a valid KDX zip file. Please download data from KDSMART again."
    

        ## read data and build a dict where key is excel plot ID and value is dict plot[traitName] = [value, time]
        dataFile = folder_unzip + "samples.csv"
        data = {}
        with open(dataFile) as f:
            reader = csv.DictReader(f)
            try:
                for row in reader:
                    trait = row['TraitName']+"__"+row['TraitInstanceNumber']
                    plot = plots[row['Link:PlotId']]
                    value = ""
                    time = ""
                    if row['TraitValue']:
                        value = row['TraitValue']
                        time = parser.parse(row['MeasureDateTime'])
                        if trait in data:
                            data[trait].append({'plot': plot, 'value': value, 'time' : str(time.date())})
                        else:
                            data[trait]=[{'plot': plot, 'value': value, 'time' : str(time.date())}]
            except:
                return "Error - zip file is not a valid KDX zip file. Please download data from KDSMART again."
    except IOError as e:
        return "Error - Cannot open file in unzipped folder."+ str(e)
    
    ## defined to know which variables have been recorded and were unexpected
    variables = list(data.keys())

    ## variables that should have been recorded but without values
    variablesNoValues = set()
    
    ## open empty file
    try:
        xls = pd.ExcelFile(excel_name)
    except IOError as e:
        return "Error - Cannot open file empty AgroFIMS excel file."+ str(e)
    
    
    ## check that excel and KDX match
    expID = ""
    try:
        df = xls.parse("Metadata")
        for index, row in df.iterrows():
            if row['Parameter'] == "Experiment ID":
                expID = row['Value']
                if folder_unzip.startswith(expID):
                    break
                else:
                    return "Error - KDX and AgroFIMS files don't match. Experiment ID should be the same."

    except:
        "Error - No TraitList tab in excel file. Please use a valid AgroFIMS file."
     
    if expID:
        writer = pd.ExcelWriter(expID+'.xlsx', engine='xlsxwriter')
    else:
        return "Error - Something is wrong with the experiment ID. Check that Experiment ID is filled in in AgroFIMS."
    
    workbook = writer.book
    
    dfAll = pd.DataFrame()
    for sheet in xls.sheet_names:
        if sheet == 'Notes_Deviations':
            df = xls.parse(sheet)
            columns = list(df)
            ## add plot column information
            df["PLOT"] = np.nan
            #print(columns)
            for key in tags:
                plot = key
                for array in tags[key]: ## handle several tags per plot
                    label = array[0]
                    desc = array[1]

                    df.loc[-1] = [label, desc, plot]
                    df.index = df.index + 1 
                    df = df.sort_index()

            df.to_excel(writer, sheet_name=sheet, index=False)
        elif (sheet != "Metadata" and sheet != "TraitList" and sheet != "Protocol"):
            #and sheet != "Weather" and sheet != "Soil"):
            df = xls.parse(sheet)
            if dfAll.empty:
                dfAll = xls.parse(sheet)
            
            for index, row in df.iterrows():
                for col in list(df): ## header
                    try:
                        if  pd.isna(row[col]): ## if cell is empty
                            ## cell is empty mean that this is a measurement - , need a timestamp to be added
                            ## column should be TIMESTAMP_measurementname(==col)
                            if("TIMESTAMP_"+col not in list(df)):
                                ##need to create empty column
                                df["TIMESTAMP_"+col] = np.nan
                            
                            ##full df
                            if("TIMESTAMP_"+col not in list(dfAll)):
                                ##need to create empty column
                                dfAll["TIMESTAMP_"+col] = np.nan

                            ## remove all spaces in var name - replace by nothing as this is what kdsmart is doing
                            ## but keep the name with the space as they are in the excel file orginally
                            if (col.replace(" ","") in data): ## if header is a key in data. Need to do that for note and empty measurements ## handle the 1: and __1 missing
                                for measurement in data[col.replace(" ","")]: ## if data has value for this header
                                    ### will hope that people don't add an isntance. if yes, code that!
                                    if str(row['PLOT']) == str(measurement['plot']):
                                        ##copy value and time in df
                                            df.loc[index, col] = measurement['value']
                                            df.loc[index, "TIMESTAMP_"+col] = measurement['time']
                                            
                                            ### full df
                                            if (col not in list(dfAll)):
                                                dfAll[col] = np.nan
                                            
                                            dfAll.loc[index, col] = measurement['value']
                                            dfAll.loc[index, "TIMESTAMP_"+col] = measurement['time']

                                            ##if measurement in data - remove
                                            if(col.replace(" ","") in variables):
                                                variables.remove(col.replace(" ",""))
                            
                            ## some crop measurement have random spaces....
                            elif (col in data): ## if header is a key in data. Need to do that for note and empty measurements ## handle the 1: and __1 missing
                                for measurement in data[col]: ## if data has value for this header
                                    ### will hope that people don't add an isntance. if yes, code that!
                                    if str(row['PLOT']) == str(measurement['plot']):
                                        ##copy value and time in df
                                            df.loc[index, col] = measurement['value']
                                            df.loc[index, "TIMESTAMP_"+col] = measurement['time']
                                            
                                            ### full df
                                            if (col not in list(dfAll)):
                                                dfAll[col] = np.nan
                                            
                                            dfAll.loc[index, col] = measurement['value']
                                            dfAll.loc[index, "TIMESTAMP_"+col] = measurement['time']

                                            ##if measurement in data - remove
                                            if(col.replace(" ","") in variables):
                                                variables.remove(col.replace(" ",""))
                                                
                            elif any(col.replace(" ","") in s for s in data):
                                match = next((s for s in data if (col.replace(" ","") in s)), None)
                                for measurement in data[match]: ## if data has value for this header
                                    ### will hope that people don't add an isntance. if yes, code that!
                                    if str(row['PLOT']) == str(measurement['plot']):
                                        ##copy value and time in df
                                            df.loc[index, col] = measurement['value']
                                            df.loc[index, "TIMESTAMP_"+col] = measurement['time']
                                            
                                            ### full df
                                            if (col not in list(dfAll)):
                                                dfAll[col] = np.nan
                                            
                                            dfAll.loc[index, col] = measurement['value']
                                            dfAll.loc[index, "TIMESTAMP_"+col] = measurement['time']

                                            if(match in variables):
                                                variables.remove(match)

                            elif any(col in s for s in data):
                                match = next((s for s in data if (col in s)), None)
                                for measurement in data[match]: ## if data has value for this header
                                    ### will hope that people don't add an isntance. if yes, code that!
                                    if str(row['PLOT']) == str(measurement['plot']):
                                        ##copy value and time in df
                                            df.loc[index, col] = measurement['value']
                                            df.loc[index, "TIMESTAMP_"+col] = measurement['time']
                                            
                                            ### full df
                                            if (col not in list(dfAll)):
                                                dfAll[col] = np.nan
                                            
                                            dfAll.loc[index, col] = measurement['value']
                                            dfAll.loc[index, "TIMESTAMP_"+col] = measurement['time']

                                            if(match in variables):
                                                variables.remove(match)
                                                
                            else:
                                ## traits not recorded but planned
                                variablesNoValues.add(col)

                    except:
                        ## timestamps column
                        if not("TIMESTAMP" in col):
                            print("Error "+col) 
                        continue

            df.to_excel(writer, sheet_name=sheet, index=False)
        else:
            df = xls.parse(sheet)
            df.to_excel(writer, sheet_name=sheet, index=False)


    if variables:
        ###open trait list and parse
        try:
            df = xls.parse("TraitList")
        except:
            return "No TraitList tab in excel file. Please use a valid AgroFIMS file."
        
        traits = df['TraitName'].values
        for var in variables:
            traitName = var
            if ":" in traitName:
                traitName = traitName.split(':')[1]
            if "__" in traitName:
                traitName = traitName.split("__")[0]
            if traitName in traits: ##if in trait list
                index, = np.where(traits == traitName)
                if ("Biotic stress" or "Abiotic stress") in df['Group'][index].values:
                    ### create separate tab for stresses
                    try:
                        dfCM = xls.parse("Crop_measurements")
                    except:
                        try:
                            CM = [item for item in xls.sheet_names if item.startswith('Crop_measurements')][0]
                            dfCM = xls.parse(CM)
                        except:
                            return "No Crop Measurement tab in excel file. Please use a valid AgroFIMS file."
                   

                    dfStress = dfCM.loc[:, 'PLOT':'TREATMENT']
                    ## create columns for values and timestamp
                    dfStress[var] = np.nan
                    dfStress["TIMESTAMP_"+var] = np.nan
                    
                    ## full df
                    dfAll[var] = np.nan
                    dfAll["TIMESTAMP_"+var] = np.nan
                    
                    for index, row in dfStress.iterrows():
                            for measurement in data[var]:
                                        if str(row['PLOT']) == str(measurement['plot']):
                                                ##copy value and time in df
                                                dfStress.loc[index, var] = measurement['value']
                                                dfStress.loc[index, "TIMESTAMP_"+var] = measurement['time']
                                                
                                                ## full df
                                                dfAll.loc[index, var] = measurement['value']
                                                dfAll.loc[index, "TIMESTAMP_"+var] = measurement['time']

                    ###if sheet not exist - create - or just add if exists
                    if ("Stress_management" in writer.sheets):
                        stressSheet = writer.sheets["Stress_management"]
                        dfStress.iloc[:, dfStress.columns.get_loc('TREATMENT') + 1:].to_excel(writer, sheet_name="Stress_management", startcol=stressSheet.dim_colmax+1, index=False)

                    else:
                        dfStress.to_excel(writer, sheet_name="Stress_management", index=False)
                else:
                    sheetname = "Unexpected"
                    ### create separate tab for stresses
                    try:
                        dfCM = xls.parse("Crop_measurements")
                    except:
                        try:
                            CM = [item for item in xls.sheet_names if item.startswith('Crop_measurements')][0]
                            dfCM = xls.parse(CM)
                        except:
                            return "No Crop Measurement tab in excel file. Please use a valid AgroFIMS file."
                    
                    dfStress = dfCM.loc[:, 'PLOT':'TREATMENT']
                    ## create columns for values and timestamp
                    dfStress[var] = np.nan
                    dfStress["TIMESTAMP_"+var] = np.nan
                    
                    ## full df
                    dfAll[var] = np.nan
                    dfAll["TIMESTAMP_"+var] = np.nan
                    
                    for index, row in dfStress.iterrows():
                            for measurement in data[var]:
                                        if str(row['PLOT']) == str(measurement['plot']):
                                                ##copy value and time in df
                                                dfStress.loc[index, var] = measurement['value']
                                                dfStress.loc[index, "TIMESTAMP_"+var] = measurement['time']
                                                
                                                ## full df
                                                dfAll.loc[index, var] = measurement['value']
                                                dfAll.loc[index, "TIMESTAMP_"+var] = measurement['time']

                    ###if sheet not exist - create - or just add if exists
                    if (sheetname in writer.sheets):
                        stressSheet = writer.sheets[sheetname]
                        dfStress.iloc[:, dfStress.columns.get_loc('TREATMENT') + 1:].to_excel(writer, sheet_name=sheetname, startcol=stressSheet.dim_colmax+1, index=False)

                    else:
                        dfStress.to_excel(writer, sheet_name=sheetname, index=False)


                ## do open right tab and copy data over
            else: ##if not in trait list  
                ## create a new tab
                ## unexpected
                try:
                    dfCM = xls.parse("Crop_measurements")
                except:
                    try:
                        CM = [item for item in xls.sheet_names if item.startswith('Crop_measurements')][0]
                        dfCM = xls.parse(CM)
                    except:
                        return "No Crop Measurement tab in excel file. Please use a valid AgroFIMS file."
                
                dfUnexpected = dfCM.loc[:, 'PLOT':'TREATMENT']
                
                ## create columns for values and timestamp
                dfUnexpected[var] = np.nan
                dfUnexpected["TIMESTAMP_"+var] = np.nan
                
                ## full df
                dfAll[var] = np.nan
                dfAll["TIMESTAMP_"+var] = np.nan

                for index, row in dfUnexpected.iterrows():
                     for measurement in data[var]:
                            if str(row['PLOT']) == str(measurement['plot']):
                                    ##copy value and time in df
                                    dfUnexpected.loc[index, var] = measurement['value']
                                    dfUnexpected.loc[index, "TIMESTAMP_"+var] = measurement['time']
                                    
                                    ## full df
                                    dfAll.loc[index, var] = measurement['value']
                                    dfAll.loc[index, "TIMESTAMP_"+var] = measurement['time']
                if ("Unexpected" in writer.sheets):
                        stressSheet = writer.sheets["Unexpected"]
                        dfUnexpected.iloc[:, dfUnexpected.columns.get_loc('TREATMENT') + 1:].to_excel(writer, sheet_name="Stress_management", startcol=stressSheet.dim_colmax+1, index=False)

                else:
                        dfUnexpected.to_excel(writer, sheet_name="Unexpected", index=False)



    print("The following variable(s) did not get measured ", variablesNoValues)
    
    print("The following file has been created:"+ expID+".xlsx")
    
    ## create a sheet with all the information - ask celine if experimental condition should be there too
    ## add protocol info - same info to all plots
    df = xls.parse('Protocol')
    for index, row in df.iterrows():
        traitName = row['TraitName']
        value = row['Value']
        ## add to full df
        dfAll[traitName] = value
        
    ## add note deviations - if any
    for pt in tags:
        for tag in tags[pt]: ## if several tags per plot
            ## create the tag name as header?
            dfAll[str(tag[0])+"_Notes_Deviations"] = np.nan
            for index, row in dfAll.iterrows():                
                if str(row['PLOT']) == str(pt):
                    dfAll.loc[index, str(tag[0])+"_Notes_Deviations"] = tag[0]
                
    
    ##create tab with full df
    dfAll.to_excel(writer, sheet_name="for_analysis", index=False)
    
    writer.save()