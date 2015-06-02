package edu.co.sena.instrumusic.model.entities;

import edu.co.sena.instrumusic.model.entities.Cuenta;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2015-06-01T17:45:49")
@StaticMetamodel(Usuario.class)
public class Usuario_ { 

    public static volatile SingularAttribute<Usuario, String> idUsuario;
    public static volatile SingularAttribute<Usuario, String> estado;
    public static volatile SingularAttribute<Usuario, String> email;
    public static volatile SingularAttribute<Usuario, String> rol;
    public static volatile ListAttribute<Usuario, Cuenta> cuentaList;
    public static volatile SingularAttribute<Usuario, String> contrasena;

}