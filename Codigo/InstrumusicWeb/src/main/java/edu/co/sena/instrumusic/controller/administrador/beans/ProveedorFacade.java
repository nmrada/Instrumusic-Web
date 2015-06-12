/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.controller.administrador.beans;

import edu.co.sena.instrumusic.model.entities.DomicilioProveedor;
import edu.co.sena.instrumusic.model.entities.Municipio;
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
        Query queryJPQL = getEntityManager().createNamedQuery("Proveedor.findByNombre");
        queryJPQL.setParameter("nombre", nombre);
        return queryJPQL.getResultList();
    }

    public List<Proveedor> findByEmail(String email) {
        Query queryJPQL = getEntityManager().createNamedQuery("Proveedor.findByEmail");
        queryJPQL.setParameter("email", email);
        return queryJPQL.getResultList();
    }

    public List<DomicilioProveedor> findByTelefono(String telefono) {
        Query queryJPQL = getEntityManager().createNamedQuery("DomicilioProveedor.findByTelefono");
        queryJPQL.setParameter("telefono", telefono);
        return queryJPQL.getResultList();
    }

    public List<DomicilioProveedor> findByDireccion(String direccion) {
        Query queryJPQL = getEntityManager().createNamedQuery("DomicilioProveedor.findByDireccion");
        queryJPQL.setParameter("direccion", direccion);
        return queryJPQL.getResultList();
    }

    public List<DomicilioProveedor> findByBarrio(String barrio) {
        Query queryJPQL = getEntityManager().createNamedQuery("DomicilioProveedor.findByBarrio");
        queryJPQL.setParameter("barrio", barrio);
        return queryJPQL.getResultList();
    }

    public List<DomicilioProveedor> findByLocalidad(String localidad) {
        Query queryJPQL = getEntityManager().createNamedQuery("DomicilioProveedor.findByLocalidad");
        queryJPQL.setParameter("barrio", localidad);
        return queryJPQL.getResultList();
    }

//         public List<DomicilioProveedor> findByIdMunicipio(String idMunicipio) {
//        String sqlQuery = "SELECT * FROM DomicilioProveedor po where po.Municipio_idMunicipio like '%" + idMunicipio + "%';";
//        Query queryJQL = getEntityManager().createNativeQuery(sqlQuery, DomicilioProveedor.class);
//        return queryJQL.getResultList();
//    }   
    public List<Municipio> findByIdMunicipio(String IdMun) {
        Query queryJPQL = getEntityManager().createNamedQuery("Municipio.findByIdMunicipio");
        queryJPQL.setParameter("idMunicipio", IdMun);
        return queryJPQL.getResultList();

    }
}
