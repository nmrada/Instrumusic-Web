package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.Categoria;
import edu.co.sena.instrumusic.model.entities.Producto;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-05-28T15:38:29")
@StaticMetamodel(Categoria.class)
public class Categoria_ { 

    public static volatile SingularAttribute<Categoria, Integer> idCategoria;
    public static volatile SingularAttribute<Categoria, String> nombreCategoria;
    public static volatile ListAttribute<Categoria, Categoria> categoriaList;
    public static volatile ListAttribute<Categoria, Producto> productoList;
    public static volatile SingularAttribute<Categoria, Boolean> activa;
    public static volatile SingularAttribute<Categoria, Categoria> categoriaidCategoria;

}