using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using KN_Practica3.BaseDatos;

namespace KN_Practica3.Controllers
{
    public class PrincipalController : Controller
    {
        private PracticaS12Entities db = new PracticaS12Entities();
        // GET: Principal
        public ActionResult Consulta()
        {
            var productos = db.SP_Consultar_Producto().ToList();


            return View(productos);
        }
    }
}