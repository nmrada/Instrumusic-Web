/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.view.cliente;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;

/**
 *
 * @author My PC
 */
@ManagedBean
public class PaginaInicio {
    
    private List<String> images;
     
    @PostConstruct
    public void init() {
        images = new ArrayList<>();
        for (int i = 1; i <= 2; i++) {
            images.add("instrumento" + i + ".jpg");
        }
    }
 
    public List<String> getImages() {
        return images;
    }
    
    
}
