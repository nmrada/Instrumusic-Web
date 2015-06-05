/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.controller.administrador.beans;

import edu.co.sena.instrumusic.model.entities.Categoria;
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
public class CategoriaFacade extends AbstractFacade<Categoria> {
    @PersistenceContext(unitName = "edu.co.sena_InstrumusicWeb_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CategoriaFacade() {
        super(Categoria.class);
    }
        public List<Categoria> finByid(Object id) {
        Query queryJPQL = getEntityManager().createNamedQuery("Categoria.findByIdCategoria");
        queryJPQL.setParameter("idCategoria", id);
        return queryJPQL.getResultList();
    }

    public List<Categoria> findByNombre(String nombreCatBuscar) {
        String sqlQuery = "SELECT * FROM categoria cat where cat.nombreCategoria like '%" + nombreCatBuscar + "%';";
        Query query2 = getEntityManager().createNativeQuery(sqlQuery, Categoria.class);
        return query2.getResultList();
    }

        public List<Categoria> findByActivo(Boolean activo) {
        Query queryJPQL = getEntityManager().createNamedQuery("Categoria.findByActiva");
        queryJPQL.setParameter("activo", activo);
        return queryJPQL.getResultList();
    }
    
        public List<Categoria> findByidPadre(Categoria idCategoriaPadreBuscar) {
        String sqlQuery = "SELECT * FROM categoria cat where cat.categoriaidCategoria like '%" + idCategoriaPadreBuscar + "%';";
        Query queryJPQL = getEntityManager().createNativeQuery(sqlQuery, Categoria.class);
        return queryJPQL.getResultList();
    }
 
    
}
