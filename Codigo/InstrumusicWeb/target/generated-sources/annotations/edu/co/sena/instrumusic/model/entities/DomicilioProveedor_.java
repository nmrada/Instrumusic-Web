package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.DomicilioProveedorPK;
import edu.co.sena.instrumusic.model.entities.Municipio;
import edu.co.sena.instrumusic.model.entities.Proveedor;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-05-28T15:38:29")
@StaticMetamodel(DomicilioProveedor.class)
public class DomicilioProveedor_ { 

    public static volatile SingularAttribute<DomicilioProveedor, String> direccion;
    public static volatile SingularAttribute<DomicilioProveedor, String> localidad;
    public static volatile SingularAttribute<DomicilioProveedor, DomicilioProveedorPK> domicilioProveedorPK;
    public static volatile SingularAttribute<DomicilioProveedor, String> telefono;
    public static volatile SingularAttribute<DomicilioProveedor, String> barrio;
    public static volatile SingularAttribute<DomicilioProveedor, Proveedor> proveedor;
    public static volatile SingularAttribute<DomicilioProveedor, Municipio> municipioidMunicipio;

}