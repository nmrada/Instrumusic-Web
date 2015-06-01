package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.DomicilioProveedor;
import edu.co.sena.instrumusic.model.entities.Inventario;
import edu.co.sena.instrumusic.model.entities.ProveedorPK;
import edu.co.sena.instrumusic.model.entities.TipoDocumento;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-05-28T15:38:29")
@StaticMetamodel(Proveedor.class)
public class Proveedor_ { 

    public static volatile SingularAttribute<Proveedor, String> nombre;
    public static volatile ListAttribute<Proveedor, Inventario> inventarioList;
    public static volatile SingularAttribute<Proveedor, String> email;
    public static volatile SingularAttribute<Proveedor, DomicilioProveedor> domicilioProveedor;
    public static volatile SingularAttribute<Proveedor, TipoDocumento> tipoDocumento;
    public static volatile SingularAttribute<Proveedor, ProveedorPK> proveedorPK;

}