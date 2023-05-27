using Microsoft.AspNetCore.Mvc;
using WebApi.Conexion;
using WebApi.Models;
using System.Text.Json;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace WebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClienteController : ControllerBase
    {
        //GET api/<controller>
        [HttpGet]
        [Route("MostrarClientes")]
        public List<Cliente> Get() { 
            return EjecutarSentencias.Listar();
        }
        // POST api/<controller>
        [HttpPost]
        [Route("IngresarClientes")]
        public bool Post([FromBody] Cliente regCliente)
        {
            return EjecutarSentencias.RegistarCliente(regCliente);
        }
        // DELETE api/<controller>/5
        [HttpDelete]
        [Route("EliminarClientes")]
        public bool Delete(int doc)
        {
            return EjecutarSentencias.EliminarCliente(doc);
        }
        // PUT api/<controller>/5
        [HttpPut]
        [Route("ModificarClientes")]
        public bool Put([FromBody] Cliente modCliente)
        {
            return EjecutarSentencias.ModificarCliente(modCliente);
        }
        //GET api/<controller>/5
        [HttpGet]
        [Route("BuscarClientes")]
        public List<Cliente> Get(string nombre)
        {
            return EjecutarSentencias.BuscarCliente(nombre);
        }
        //GET api/<controller>/5
        [HttpGet]
        [Route("BuscarClientesDoc")]
        public List<Cliente> Get(int documento)
        {
            return EjecutarSentencias.BuscarClientexDocumento(documento);
        }
        //GET api/<controller>/5
        [HttpGet]
        [Route("BuscarClientesFechancto")]
        public List<Cliente> Get(DateTime fechainicial, DateTime fechafinal)
        {
            return EjecutarSentencias.BuscarClienteFecNto(fechainicial,fechafinal);
        }
        //GET api/<controller>/5
        [HttpGet]
        [Route("CalcularEdad")]
        public List<Cliente> get(string fechanacimiento)
        {
            return EjecutarSentencias.CalcularEdad(fechanacimiento);
        }
    }
}
