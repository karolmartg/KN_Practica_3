using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace KN_Practica3.Controllers
{
    public class PrincipalController : Controller
    {
        // GET: Principal
        public ActionResult Consulta()
        {
            return View();
        }
    }
}