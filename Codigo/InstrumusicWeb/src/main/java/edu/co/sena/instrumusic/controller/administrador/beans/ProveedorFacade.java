/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.controller.administrador.beans;

import edu.co.sena.instrumusic.model.entities.DomicilioProveedor;
import edu.co.sena.instrumusic.model.entities.Proveedor;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author aprendiz
 */
@Stateless
public class ProveedorFacade extends AbstractFacade<Proveedor> {

    @PersistenceContext(unitName = "edu.co.sena_InstrumusicWeb_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ProveedorFacade() {
        super(Proveedor.class);
    }

    public List<Proveedor> findByTipoDocumento(String tipoDocumento) {
        Query queryJPQL = getEntityManager().createNamedQuery("Proveedor.findByTipoDocumentotipoDocumento");
        queryJPQL.setParameter("tipoDocumentotipoDocumento", tipoDocumento);
        return queryJPQL.getResultList();
    }

    public List<Proveedor> findByNumeroDocumento(String numeroDocumento) {
        Query queryJPQL = getEntityManager().createNamedQuery("Proveedor.findByNumeroDocumento");
        queryJPQL.setParameter("numeroDocumento", numeroDocumento);
        return queryJPQL.getResultList();

    }

    public List<Proveedor> findByNombre(String nombre) {
        String sqlQuery = "SELECT * FROM proveedor pro where pro.nombre like '%" + nombre + "%';";
        Query queryJQL = getEntityManager().createNativeQuery(sqlQuery, Proveedor.class);
        return queryJQL.getResultList();
    }
    
       public List<Proveedor> findByEmail(String email) {
        String sqlQuery = "SELECT * FROM proveedor pro where pro.email like '%" + email + "%';";
        Query queryJQL = getEntityManager().createNativeQuery(sqlQuery, Proveedor.class);
        return queryJQL.getResultList();
    }
     
          public List<DomicilioProveedor> findByTelefono(String telefono) {
        String sqlQuery = "SELECT * FROM DomicilioProveedor po where po.telefono like '%" + telefono + "%';";
        Query queryJQL = getEntityManager().createNativeQuery(sqlQuery, DomicilioProveedor.class);
        return queryJQL.getResultList();
    }
          
        public List<DomicilioProveedor> findByDireccion(String direccion) {
        String sqlQuery = "SELECT * FROM DomicilioProveedor po where po.direcion like '%" + direccion + "%';";
        Query queryJQL = getEntityManager().createNativeQuery(sqlQuery, DomicilioProveedor.class);
        return queryJQL.getResultList();
    }
    
        public List<DomicilioProveedor> findByBarrio(String barrio) {
        String sqlQuery = "SELECT * FROM DomicilioProveedor po where po.barrio like '%" + barrio + "%';";
        Query queryJQL = getEntityManager().createNativeQuery(sqlQuery, DomicilioProveedor.class);
        return queryJQL.getResultList();
    }
        
          public List<DomicilioProveedor> findByLocalidad(String localidad) {
        String sqlQuery = "SELECT * FROM DomicilioProveedor po where po.localidad like '%" + localidad + "%';";
        Query queryJQL = getEntityManager().createNativeQuery(sqlQuery, DomicilioProveedor.class);
        return queryJQL.getResultList();
    }
          
         public List<DomicilioProveedor> findByIdMunicipio(String idMunicipio) {
        String sqlQuery = "SELECT * FROM DomicilioProveedor po where po.Municipio_idMunicipio like '%" + idMunicipio + "%';";
        Query queryJQL = getEntityManager().createNativeQuery(sqlQuery, DomicilioProveedor.class);
        return queryJQL.getResultList();
    }   
}
