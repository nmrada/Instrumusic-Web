package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.Cuenta;
import edu.co.sena.instrumusic.model.entities.Proveedor;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-06-10T20:59:10")
@StaticMetamodel(TipoDocumento.class)
public class TipoDocumento_ { 

    public static volatile SingularAttribute<TipoDocumento, String> descripcion;
    public static volatile ListAttribute<TipoDocumento, Proveedor> proveedorList;
    public static volatile SingularAttribute<TipoDocumento, String> tipoDocumento;
    public static volatile ListAttribute<TipoDocumento, Cuenta> cuentaList;
    public static volatile SingularAttribute<TipoDocumento, Boolean> activo;

}