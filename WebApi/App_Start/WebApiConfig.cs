using Microsoft.AspNetCore.Cors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using EnableCorsAttribute = System.Web.Http.Cors.EnableCorsAttribute;
namespace WebApi.App_Start
{
    public static class WebApiConfig
    {
        public static void Resgistre(HttpConfiguration config) {
            var cors = new EnableCorsAttribute("*","*","*");
            config.EnableCors(cors);
            config.MapHttpAttributeRoutes();
            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate:"api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional}
                );
        }
    }
}