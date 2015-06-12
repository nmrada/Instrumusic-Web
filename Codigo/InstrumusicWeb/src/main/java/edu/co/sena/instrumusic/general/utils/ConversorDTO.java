/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.general.utils;

import edu.co.sena.instrumusic.controller.administrador.beans.MunicipioFacade;
import edu.co.sena.instrumusic.controller.administrador.dto.CuentaDTO;
import edu.co.sena.instrumusic.model.entities.Producto;
import edu.co.sena.instrumusic.controller.administrador.dto.ProductoDTO;
import edu.co.sena.instrumusic.model.entities.Cuenta;
import edu.co.sena.instrumusic.model.entities.CuentaPK;
import edu.co.sena.instrumusic.model.entities.DomicilioCuenta;
import edu.co.sena.instrumusic.model.entities.DomicilioCuentaPK;
import edu.co.sena.instrumusic.model.entities.Municipio;
import edu.co.sena.instrumusic.model.entities.TipoDocumento;
import edu.co.sena.instrumusic.model.entities.Usuario;
import edu.co.sena.instrumusic.view.administrador.bean.ProductoController;
import javax.ejb.EJB;

/**
 *
 * @author aprendiz
 */
public class ConversorDTO {

    public static Producto conversorProductoDTOaProducto(ProductoDTO recibida) {
        Producto pt = new Producto();
        pt.setColor(recibida.getColor());
        pt.setActivo(recibida.getActivo());
        pt.setCantidad(recibida.getCantidad());
        pt.setCategoriaidCategoria(recibida.getCategoriaidCategoria());
        pt.setDescripcion(recibida.getDescripcion());
        pt.setDescuento(recibida.getDescuento());
        pt.setIdProducto(recibida.getIdProducto());
        pt.setMarca(recibida.getMarca());
        pt.setMaterial(recibida.getMaterial());
        pt.setNombre(recibida.getNombre());
        pt.setPrecioUnitario(recibida.getPrecioUnitario());
        pt.setReferencia(recibida.getReferencia());
        ProductoController con = new ProductoController();
        con.getFile();
        if (recibida.getFoto() != null) {
            pt.setFoto(con.getFile().getContents());
        }
        return pt;
    }

    public static ProductoDTO conversorProductoaProductoDTO(Producto recibida) {
        ProductoDTO pt = new ProductoDTO();
        pt.setColor(recibida.getColor());
        pt.setActivo(recibida.getActivo());
        pt.setCantidad(recibida.getCantidad());
        pt.setCategoriaidCategoria(recibida.getCategoriaidCategoria());
        pt.setDescripcion(recibida.getDescripcion());
        pt.setDescuento(recibida.getDescuento());
        pt.setIdProducto(recibida.getIdProducto());
        pt.setMarca(recibida.getMarca());
        pt.setMaterial(recibida.getMaterial());
        pt.setNombre(recibida.getNombre());
        pt.setPrecioUnitario(recibida.getPrecioUnitario());
        pt.setReferencia(recibida.getReferencia());
        return pt;
    }

    public static Cuenta conversorCuentaDTOaCuenta(CuentaDTO recibida) {
        Cuenta ct = new Cuenta();
        ct.setCuentaPK(new CuentaPK(recibida.getTipoDocumento(), recibida.getNumeroDocumento()));
        ct.setPrimerNombre(recibida.getPrimerNombre());
        ct.setSegundoNombre(recibida.getSegundoNombre());
        ct.setPrimerApellido(recibida.getPrimerApellido());
        ct.setSegundoApellido(recibida.getSegundoApellido());

        DomicilioCuenta dct = new DomicilioCuenta();
        dct.setDomicilioCuentaPK(new DomicilioCuentaPK(recibida.getTipoDocumento(), recibida.getNumeroDocumento()));
        dct.setBarrio(recibida.getBarrio());
        dct.setDireccion(recibida.getDireccion());
        dct.setLocalidad(recibida.getLocalidad());
        dct.setTelefono(recibida.getTelefono());

        dct.setMunicipioidMunicipio(recibida.getMunicipio());
        ct.setDomicilioCuenta(dct);

        Usuario ut = new Usuario();
        ut.setIdUsuario(recibida.getIdUsuario());
        ut.setEmail(recibida.getEmail());
        ut.setEstado(recibida.getEstadoUsuario());
        ut.setRol(recibida.getRolUsuario());
        ut.setContrasena(recibida.getContrasena());
        ct.setUsuarioidUsuario(ut);
        ct.setTipoDocumento(new TipoDocumento(recibida.getTipoDocumento()));
        return ct;
    }

}
