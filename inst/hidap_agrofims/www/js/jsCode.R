jscode <- '
// Codigo para expandir Boxes
shinyjs.collapse = function(boxid) {
$("#" + boxid).closest(".box").find("[data-widget=collapse]").click();
}
//

// Codigo para manejar las cookies, para continuar logeado cuando se refresca la pagina
shinyjs.getcookie = function(params) {
  var user = Cookies.get("user_af");
  var pass = Cookies.get("pass_af");
  if (typeof pass !== "undefined") {

    Shiny.onInputChange("jscookie_user", user);
    Shiny.onInputChange("jscookie_pass", pass);
    //Shiny.onInputChange("jscookie", user + pass);
  } else {
    var cookie = "";
    //Shiny.onInputChange("jscookie", cookie);
    Shiny.onInputChange("jscookie_user", cookie);
    Shiny.onInputChange("jscookie_pass", cookie);
  }
}
shinyjs.setcookie = function(params) {
  Cookies.set("user_af", escape(params[0]), { expires: 0.5 });
  Cookies.set("pass_af", escape(params[1]), { expires: 0.5 });
   Shiny.onInputChange("jscookie_user", escape(params[0]));
}
shinyjs.rmcookie = function(params) {
  Cookies.remove("user_af");
  Cookies.remove("pass_af");
  Shiny.onInputChange("jscookie_user", "");
}
//

'
