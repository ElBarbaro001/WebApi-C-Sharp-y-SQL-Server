namespace WebApi.Models
{
    public class Tarjeta
    {
        public int? codigo { get; set; }
        public int? saldo { get; set; } = 0;
        public string? estado { get; set; }
    }
}
