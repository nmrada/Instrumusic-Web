/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.controller.administrador.beans;

import edu.co.sena.instrumusic.model.entities.Cuenta;
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
public class CuentaFacade extends AbstractFacade<Cuenta> {
    @PersistenceContext(unitName = "edu.co.sena_InstrumusicWeb_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CuentaFacade() {
        super(Cuenta.class);
    }
    
    public List<Cuenta> findByLlavePrimaria(String tip, String nom) {
        String sqlQuery = "SELECT * FROM instrumusic.cuenta c WHERE c.Tipo_Documento_tipoDocumento = '%" + tip +"%' AND c.numeroDocumento = '%" + nom +"%';";
        Query query2 = getEntityManager().createNativeQuery(sqlQuery, Cuenta.class);
        return query2.getResultList();
    }
    
    public List<Cuenta> findByTipoDoc(Object tip) {
        Query queryJPQL = getEntityManager().createNamedQuery("Cuenta.findByTipoDocumentotipoDocumento");
        queryJPQL.setParameter("Tipo_Documento_tipoDocumento", tip);
        return queryJPQL.getResultList();
    }
    
    public List<Cuenta> findByNumDoc(String num) {
        String sqlQuery = "SELECT * FROM instrumusic.cuenta c WHERE c.numeroDocumento = '%" + num +"%';";
        Query query2 = getEntityManager().createNativeQuery(sqlQuery, Cuenta.class);
        return query2.getResultList();
    }
    
    public List<Cuenta> findByPrimerNom(Object priNombre) {
        Query queryJPQL = getEntityManager().createNamedQuery("Cuenta.findByPrimerNombre");
        queryJPQL.setParameter("primerNombre", priNombre);
        return queryJPQL.getResultList();
    }
    
    public List<Cuenta> findBySegundoNom(Object segNombre) {
        Query queryJPQL = getEntityManager().createNamedQuery("Cuenta.findBySegundoNombre");
        queryJPQL.setParameter("segundoNombre", segNombre);
        return queryJPQL.getResultList();
    }
    
    public List<Cuenta> findByPrimerApe(Object priApellido) {
        Query queryJPQL = getEntityManager().createNamedQuery("Cuenta.findByPrimerApellido");
        queryJPQL.setParameter("primerApellido", priApellido);
        return queryJPQL.getResultList();
    }
    
    public List<Cuenta> findBySegundoApe(Object segApellido) {
        Query queryJPQL = getEntityManager().createNamedQuery("Cuenta.findBySegundoApellido");
        queryJPQL.setParameter("segundoApellido", segApellido);
        return queryJPQL.getResultList();
    }
    
    public List<Cuenta> findByIdUsuario(String usuario) {
        String sqlQuery = "SELECT * FROM instrumusic.cuenta c, instrumusic.usuario s WHERE "
                + "s.idUsuario = c.Usuario_idUsuario and s.idUsuario like '%"+usuario+"%';";
        Query query2 = getEntityManager().createNativeQuery(sqlQuery, Cuenta.class);
        return query2.getResultList();
    }
    
}
