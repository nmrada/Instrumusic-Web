/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.controller.administrador.beans;

import edu.co.sena.instrumusic.model.entities.TipoDocumento;
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
public class TipoDocumentoFacade extends AbstractFacade<TipoDocumento> {
    @PersistenceContext(unitName = "edu.co.sena_InstrumusicWeb_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public TipoDocumentoFacade() {
        super(TipoDocumento.class);
    }
    
    public List<TipoDocumento> findById(Object id) {
        Query queryJPQL = getEntityManager().createNamedQuery("TipoDocumento.findByTipoDocumento");
        queryJPQL.setParameter("tipoDocumento", id);
        return queryJPQL.getResultList();
    }
    
    public List<TipoDocumento> findByDescripcion(String descripcion) {
        String sqlQuery = "SELECT * FROM tipo_documento tipo where tipo.descripcion like '%" + descripcion + "%';";
        Query query2 = getEntityManager().createNativeQuery(sqlQuery, TipoDocumento.class);
        return query2.getResultList();
    }
    
    public List<TipoDocumento> findByActivo(Boolean activo) {
        Query queryJPQL = getEntityManager().createNamedQuery("TipoDocumento.findByActivo");
        queryJPQL.setParameter("activo", activo);
        return queryJPQL.getResultList();
    }
    
}
