﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace KN_Practica3.BaseDatos
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class PracticaS12Entities : DbContext
    {
        public PracticaS12Entities()
            : base("name=PracticaS12Entities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Abonos> Abonos { get; set; }
        public virtual DbSet<Principal> Principal { get; set; }
    
        public virtual int SP_Abonar_Saldo(Nullable<long> id_Compra, Nullable<decimal> abono)
        {
            var id_CompraParameter = id_Compra.HasValue ?
                new ObjectParameter("Id_Compra", id_Compra) :
                new ObjectParameter("Id_Compra", typeof(long));
    
            var abonoParameter = abono.HasValue ?
                new ObjectParameter("abono", abono) :
                new ObjectParameter("abono", typeof(decimal));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SP_Abonar_Saldo", id_CompraParameter, abonoParameter);
        }
    
        public virtual ObjectResult<Nullable<decimal>> SP_Buscar_Producto(Nullable<long> id_Compra)
        {
            var id_CompraParameter = id_Compra.HasValue ?
                new ObjectParameter("Id_Compra", id_Compra) :
                new ObjectParameter("Id_Compra", typeof(long));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<decimal>>("SP_Buscar_Producto", id_CompraParameter);
        }
    
        public virtual ObjectResult<SP_Consultar_Producto_Result> SP_Consultar_Producto()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SP_Consultar_Producto_Result>("SP_Consultar_Producto");
        }
    
        public virtual ObjectResult<SP_Listar_Compras_Result> SP_Listar_Compras()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SP_Listar_Compras_Result>("SP_Listar_Compras");
        }
    }
}
