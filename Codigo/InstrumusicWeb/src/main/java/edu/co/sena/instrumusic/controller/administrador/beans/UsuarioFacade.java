/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.controller.administrador.beans;

import edu.co.sena.instrumusic.model.entities.Usuario;
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
public class UsuarioFacade extends AbstractFacade<Usuario> {
    @PersistenceContext(unitName = "edu.co.sena_InstrumusicWeb_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsuarioFacade() {
        super(Usuario.class);
    }
    public List<Usuario> finById(String id) {
        Query queryJPQL = getEntityManager().createNamedQuery("Usuario.findByIdUsuario");
        queryJPQL.setParameter("idUsuario", id);
        return queryJPQL.getResultList();
    }
    
    public List<Usuario> findByPartRol(String rolUsuBuscar) {
        Query queryJPQL = getEntityManager().createNamedQuery("Usuario.findByRol");
        queryJPQL.setParameter("rol", rolUsuBuscar);
        return queryJPQL.getResultList();
    }
    
     public List<Usuario> findByPartEstado(String estadoUsuBuscar) {
        Query queryJPQL = getEntityManager().createNamedQuery("Usuario.findByEstado");
        queryJPQL.setParameter("estado", estadoUsuBuscar);
        return queryJPQL.getResultList();
    }
    
    public List<Usuario> finByEmail(Object Email) {
         String sqlQuery = "SELECT * FROM usuario usu where usu.EMAIL like '%" + Email + "%';";
        Query query2 = getEntityManager().createNativeQuery(sqlQuery, Usuario.class);
        return query2.getResultList();
    }
    
}
