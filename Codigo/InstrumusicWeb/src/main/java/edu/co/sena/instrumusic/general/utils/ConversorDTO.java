/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.general.utils;

import edu.co.sena.instrumusic.model.entities.Producto;
import edu.co.sena.instrumusic.controller.administrador.dto.ProductoDTO;
import edu.co.sena.instrumusic.view.administrador.bean.ProductoController;

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
}
