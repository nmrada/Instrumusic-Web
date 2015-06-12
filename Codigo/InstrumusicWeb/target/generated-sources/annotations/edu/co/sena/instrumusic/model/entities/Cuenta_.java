package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.CuentaPK;
import edu.co.sena.instrumusic.model.entities.DomicilioCuenta;
import edu.co.sena.instrumusic.model.entities.Factura;
import edu.co.sena.instrumusic.model.entities.TipoDocumento;
import edu.co.sena.instrumusic.model.entities.Usuario;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-06-10T20:59:10")
@StaticMetamodel(Cuenta.class)
public class Cuenta_ { 

    public static volatile SingularAttribute<Cuenta, TipoDocumento> tipoDocumento;
    public static volatile SingularAttribute<Cuenta, String> segundoNombre;
    public static volatile SingularAttribute<Cuenta, String> primerNombre;
    public static volatile SingularAttribute<Cuenta, String> primerApellido;
    public static volatile SingularAttribute<Cuenta, DomicilioCuenta> domicilioCuenta;
    public static volatile SingularAttribute<Cuenta, Usuario> usuarioidUsuario;
    public static volatile SingularAttribute<Cuenta, CuentaPK> cuentaPK;
    public static volatile ListAttribute<Cuenta, Factura> facturaList;
    public static volatile SingularAttribute<Cuenta, String> segundoApellido;

}