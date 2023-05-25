# WebApi
Se construye esta API bajo los siguientes requerimientos:
1 . Crear un CRUD para la gestionar la informacion de Clientes, almacenada en una tabla en SQL Server.
  - Consultar todos los datos de la tabla.
  - Validar que en el campo Documento al momento de guardar el Dato se valide que el dato no exista.
  - Registrar Clientes.
  - Modificar Clientes.
  - Eliminar Clientes.
  - Consultar Clientes por Nombres o Apellidos.
  - Consultar Clientes por su Documento de Identidad.
  - Consultar Clientes por rango de fechas, tomando las fechas de nacimiento.
                
                DateTime dateTime = DateTime.Now;
                SqlCommand calcular_edad = new SqlCommand("sp_calcular_edad", conectar);
                calcular_edad.CommandType = System.Data.CommandType.StoredProcedure;
                calcular_edad.Parameters.AddWithValue(regCliente.fecha_nacimiento.ToString(), dateTime.ToString());
