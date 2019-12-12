# AGROFIMS

Repository for the main application (app) of AGROFIMS. 

## Overview

`The Agronomy Field Information Management System (AgroFIMS)` has been developed based on CGIAR’s `HIDAP` (Highly-interactive Data Analysis Platform created by CGIAR’s `International Potato Center`, CIP). AgroFIMS draws fully on ontologies, particularly the Agronomy Ontology and the `Crop Ontology`. It consists of modules that represent the typical cycle of operations in agronomic trial management, and enables the creation of data collection sheets using the same ontology-based set of variables, terminology, units and protocols. AgroFIMS therefore:

Standardizes data collection and description for easy aggregation and inter-linking across disparate datasets;
Allows easy integration with HIDAP breeding data, or any other ontology-based datasets;
Functions as a data staging repository, allowing data uploads with view/edit permissions;
Enables data quality checks, statistical analysis of the data collected, and the generation of sophisticated statistics reports;
Aligns a priori with CGIAR’s CG Core metadata schema;
Enables easy upload to the institutional repositories, and much more.
Funding for AgroFIMS was provided by the `Bill and Melinda Gates Foundation’s Open Access`, `Open Data Initiative`, and the `CGIAR Big Data Platform`.

## Link

- Version: HIDAP AgroFIMS `v0.2.0`

- Link: https://apps.cipotato.org/hidapagrofims

## Installation (under revision)

```
install.packages("devtools")
library(devtools)
#Library from GitHub
install_github("AGROFIMS/hagrofims",ref = "develop")
install_github('dkahle/ggmap')
install_github('ralev013/shinyStore')
install_github('trestletech/shinyTree')
install_github('AGROFIMS/agdesign')
install_github('reyzaguirre/st4gi')
install_github('reyzaguirre/pepa')
install_github('AGROFIMS/agsession')
install_github('AGROFIMS/agdesign')
install_github('CIP-RIU/shinysky')
install_github('CIP-RIU/openxlsx')
install_github('CIP-RIU/fbanalysis')
install_github('CIP-RIU/fbsites')
install_github('CIP-RIU/shinyFiles')
install_github('CIP-RIU/fbglobal')
```



## Acknowledgements

Thanks to:

- CGIAR Platform for Big Data in Agriculture
- CIAT
- IFPRI
- CIP
- Bioversity International

