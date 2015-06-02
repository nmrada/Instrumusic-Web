package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.Cuenta;
import edu.co.sena.instrumusic.model.entities.Pago;
import edu.co.sena.instrumusic.model.entities.Pedido;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-06-01T17:45:49")
@StaticMetamodel(Factura.class)
public class Factura_ { 

    public static volatile SingularAttribute<Factura, Float> total;
    public static volatile SingularAttribute<Factura, Pago> pago;
    public static volatile SingularAttribute<Factura, Date> fecha;
    public static volatile SingularAttribute<Factura, Pedido> pedido;
    public static volatile SingularAttribute<Factura, Cuenta> cuenta;
    public static volatile SingularAttribute<Factura, Integer> idFactura;

}