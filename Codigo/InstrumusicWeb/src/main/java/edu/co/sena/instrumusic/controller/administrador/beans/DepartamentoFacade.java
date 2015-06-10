/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.controller.administrador.beans;

import edu.co.sena.instrumusic.model.entities.Departamento;
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
public class DepartamentoFacade extends AbstractFacade<Departamento> {

    @PersistenceContext(unitName = "edu.co.sena_InstrumusicWeb_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DepartamentoFacade() {
        super(Departamento.class);
    }

    public List<Departamento> findById(Object id) {
        Query queryJPQL = getEntityManager().createNamedQuery("Departamento.findByIdDepartamento");
        queryJPQL.setParameter("idDepartamento", id);
        return queryJPQL.getResultList();
    }

    public List<Departamento> findByNombre(String nombreDepBuscar) {
        String sqlQuery = "SELECT * FROM departamento dep where dep.nombre like '%" + nombreDepBuscar + "%';";
        Query query2 = getEntityManager().createNativeQuery(sqlQuery, Departamento.class);
        return query2.getResultList();
    }
    
    public Departamento findByNombreCompleto(String nombreDepBuscar) {
        Query query2 = getEntityManager().createNamedQuery("Departamento.findByNombre");
        query2.setParameter("nombre", nombreDepBuscar);
        return (Departamento)query2.getSingleResult();
    }

}
