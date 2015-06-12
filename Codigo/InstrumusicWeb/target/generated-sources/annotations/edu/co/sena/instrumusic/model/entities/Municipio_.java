package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.Departamento;
import edu.co.sena.instrumusic.model.entities.DomicilioCuenta;
import edu.co.sena.instrumusic.model.entities.DomicilioProveedor;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-06-01T17:45:49")
@StaticMetamodel(Municipio.class)
public class Municipio_ { 

    public static volatile SingularAttribute<Municipio, String> nombre;
    public static volatile SingularAttribute<Municipio, Integer> idMunicipio;
    public static volatile SingularAttribute<Municipio, Departamento> departamentoidDepartamento;
    public static volatile ListAttribute<Municipio, DomicilioCuenta> domicilioCuentaList;
    public static volatile ListAttribute<Municipio, DomicilioProveedor> domicilioProveedorList;

}