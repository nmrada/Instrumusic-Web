package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.CarritoDeCompras;
import edu.co.sena.instrumusic.model.entities.ItemCarritoPK;
import edu.co.sena.instrumusic.model.entities.Producto;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-05-28T15:38:29")
@StaticMetamodel(ItemCarrito.class)
public class ItemCarrito_ { 

    public static volatile SingularAttribute<ItemCarrito, Float> costoTotal;
    public static volatile SingularAttribute<ItemCarrito, Integer> cantidad;
    public static volatile SingularAttribute<ItemCarrito, ItemCarritoPK> itemCarritoPK;
    public static volatile SingularAttribute<ItemCarrito, CarritoDeCompras> carritoDeCompras;
    public static volatile SingularAttribute<ItemCarrito, Producto> producto;
    public static volatile SingularAttribute<ItemCarrito, Float> costoUnitario;

}