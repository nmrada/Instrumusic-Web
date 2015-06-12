/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.controller.administrador.beans;

import edu.co.sena.instrumusic.model.entities.Municipio;
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
public class MunicipioFacade extends AbstractFacade<Municipio> {
    @PersistenceContext(unitName = "edu.co.sena_InstrumusicWeb_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MunicipioFacade() {
        super(Municipio.class);
    }
    
    public List<Municipio> findById(Object idMun){
        Query queryBuscar = getEntityManager().createNamedQuery("Municipio.findByIdMunicipio");
        queryBuscar.setParameter("idMunicipio", idMun);
        return queryBuscar.getResultList();
    }
    
    public List<Municipio> findByNombre(String nomMun){
        String querySql = "SELECT * FROM Municipio m where m.nombre like '%"+nomMun+"%';";
        Query queryBuscarNom = getEntityManager().createNativeQuery(querySql, Municipio.class);
        return queryBuscarNom.getResultList();
    }
    
    public List<Municipio> findByDepartamento(String nomDepart){
        String querySql = "select * from instrumusic.departamento d, instrumusic.municipio m WHERE "
                + "d.idDepartamento = m.Departamento_idDepartamento " 
                + "and d.nombre like '%"+ nomDepart +"%';";
        Query queryBuscarNom = getEntityManager().createNativeQuery(querySql, Municipio.class);
        return queryBuscarNom.getResultList();
    }
    
    public Municipio findByNombreCompleto(String nombreMunBuscar) {
        Query query2 = getEntityManager().createNamedQuery("Municipio.findByNombre");
        query2.setParameter("nombre", nombreMunBuscar);
        return (Municipio)query2.getSingleResult();
    }
    
}
