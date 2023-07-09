using Microsoft.VisualBasic;

namespace WebApi.Models
{
    public class Cliente
    {
        public int? codigo { get; set; }
        public string? tp_documento { get; set; }
        public int? documento { get; set; }
        public string? nombres { get; set; }
        public string? primer_apellido { get; set; }
        public string? segundo_apellido { get; set; }
        public string? genero { get; set; }
        public DateTime? fecha_nacimiento { get; set; }
        public string? dir_casa { get; set; }
        public string? dir_trabajo { get; set; }
        public string? tfno_casa { get; set; }
        public string? tfno_trabajo { get; set; }
        public string? email { get; set; }
        public string? edad { get; set; }

    }
}
