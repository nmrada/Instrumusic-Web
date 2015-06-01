package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.ItemCarrito;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-05-28T15:38:29")
@StaticMetamodel(CarritoDeCompras.class)
public class CarritoDeCompras_ { 

    public static volatile SingularAttribute<CarritoDeCompras, Float> precioTotal;
    public static volatile SingularAttribute<CarritoDeCompras, Float> impuestos;
    public static volatile SingularAttribute<CarritoDeCompras, Float> subtotal;
    public static volatile ListAttribute<CarritoDeCompras, ItemCarrito> itemCarritoList;
    public static volatile SingularAttribute<CarritoDeCompras, String> idCarritoDeCompras;

}