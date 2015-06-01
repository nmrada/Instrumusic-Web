package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.Municipio;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-05-28T15:38:30")
@StaticMetamodel(Departamento.class)
public class Departamento_ { 

    public static volatile SingularAttribute<Departamento, String> nombre;
    public static volatile SingularAttribute<Departamento, String> idDepartamento;
    public static volatile ListAttribute<Departamento, Municipio> municipioList;

}