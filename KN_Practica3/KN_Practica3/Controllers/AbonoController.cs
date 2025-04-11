using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using KN_Practica3.BaseDatos;

namespace KN_Practica3.Controllers
{
    public class AbonoController : Controller
    {
        private PracticaS12Entities db = new PracticaS12Entities();

        public ActionResult Registro()
        {
            ViewBag.ComprasPendientes = new SelectList(db.Principal
                .Where(p => p.Estado == "Pendiente").ToList(), "Id_Compra", "Descripcion");

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Registro(Abonos abono)
        {
            if (ModelState.IsValid)
            {
                abono.Fecha = DateTime.Now;
                var compra = db.Principal.Find(abono.Id_Compra);

                if (compra != null && compra.Saldo >= abono.Monto)
                {
                    compra.Saldo -= abono.Monto;

                    if (compra.Saldo <= 0)
                    {
                        compra.Estado = "Pagado";
                    }

                    db.Abonos.Add(abono);
                    db.SaveChanges();

                    return RedirectToAction("Registro");
                }
            }

            ViewBag.ComprasPendientes = new SelectList(db.Principal
                .Where(p => p.Estado == "Pendiente").ToList(), "Id_Compra", "Descripcion");

            return View(abono);
        }

        public JsonResult ObtenerSaldo(long id)
        {
            var saldo = db.Principal.Where(p => p.Id_Compra == id)
                .Select(p => p.Saldo).FirstOrDefault();

            return Json(saldo, JsonRequestBehavior.AllowGet);
        }
    }
}