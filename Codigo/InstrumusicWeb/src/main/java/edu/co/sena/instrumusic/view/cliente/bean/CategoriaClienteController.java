/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.view.cliente.bean;

import edu.co.sena.instrumusic.controller.administrador.beans.CategoriaFacade;
import edu.co.sena.instrumusic.model.entities.Categoria;
import java.io.Serializable;
import java.util.List;
import javax.ejb.EJB;
import javax.faces.view.ViewScoped;
import javax.inject.Named;

/**
 *
 * @author aprendiz
 */
@Named("categoriaClienteController")
@ViewScoped
public class CategoriaClienteController implements Serializable{
    
    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.CategoriaFacade ejbFacade;
    private Categoria categoriaPadre;
    private List<Categoria> categoriaHijos;
    private List<Categoria> categoriaHijos2;

    public CategoriaClienteController() {
    }
    
    public Categoria getcategoriaPadre() {
        categoriaPadre = getFacade().findByidPadreCli(1);
        return categoriaPadre;
    }

    public void setDarCategoriaPadre(Categoria categoriaPadre) {
        this.categoriaPadre = categoriaPadre;
    }
 
    private CategoriaFacade getFacade() {
        return ejbFacade;
    }
    
    public List<Categoria> getCategoriaHijos() {
        categoriaHijos = getcategoriaPadre().getCategoriaList();
        return categoriaHijos;
    }
    
}
