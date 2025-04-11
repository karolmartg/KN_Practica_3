using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KN_Practica3.Models
{
    public class Abono
    {
        public long Id_Abono { get; set; }
        public long  Id_Compra { get; set; }
        public decimal Monto { get; set; }
        public DateTime Fecha { get; set; }
    }
}