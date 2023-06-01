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
        public List<Cliente> Listar() { 
            return EjecutarSentencias.Listar();
        }
        // POST api/<controller>
        [HttpPost]
        [Route("IngresarClientes")]
        public bool Insertar([FromBody] Cliente regCliente)
        {
            return EjecutarSentencias.RegistarCliente(regCliente);
        }
        // DELETE api/<controller>/5
        [HttpDelete]
        [Route("EliminarClientes")]
        public void Eliminar(int doc)
        {
            EjecutarSentencias.EliminarCliente(doc);
        }
        // PUT api/<controller>/5
        [HttpPut]
        [Route("ModificarClientes")]
        public bool Modificar([FromBody] Cliente modCliente)
        {
            return EjecutarSentencias.ModificarCliente(modCliente);
        }
        //GET api/<controller>/5
        [HttpGet]
        [Route("BuscarClientes")]
        public List<Cliente> Buscar(string nombre)
        {
            return EjecutarSentencias.BuscarCliente(nombre);
        }
        //GET api/<controller>/5
        [HttpGet]
        [Route("BuscarClientesDoc")]
        public List<Cliente> BuscarDoc(int documento)
        {
            return EjecutarSentencias.BuscarClientexDocumento(documento);
        }
        //GET api/<controller>/5
        [HttpGet]
        [Route("BuscarClientesFechancto")]
        public List<Cliente> BuscarFec(DateTime fechainicial, DateTime fechafinal)
        {
            return EjecutarSentencias.BuscarClienteFecNto(fechainicial,fechafinal);
        }
        //GET api/<controller>/5
        [HttpGet]
        [Route("CalcularEdad")]
        public List<Cliente> CalcularEdad(string fechanacimiento)
        {
            return EjecutarSentencias.CalcularEdad(fechanacimiento);
        }
        //GET api/<controller>/5
        [HttpGet]
        [Route("ListarTelefonos")]
        public List<Telefonos> ListarTelefonos()
        {
            return EjecutarSentencias.ListarTelefonos();
        }
    }
}
