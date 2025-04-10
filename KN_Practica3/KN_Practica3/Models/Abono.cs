using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KN_Practica3.Models
{
    public class Abono
    {
        public long  Id_Compra { get; set; }
        public decimal Monto { get; set; }
        // Fecha lo genera automáticamente el Procedimiento Almacenado.
    }
}