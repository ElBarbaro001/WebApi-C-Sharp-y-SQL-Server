using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApi.Conexion;
using WebApi.Models;
using System.Text.Json;


namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Edad : Controller
    {
        //GET api/<controller>
        [HttpGet]
        [Route("CalcularEdad")]
        public List<Cedad> Get(string fechainicial, string fechafinal)
        {
            return EjecutarSentencias.CalcularEdad(fechainicial, fechafinal);
        }
    }
}
