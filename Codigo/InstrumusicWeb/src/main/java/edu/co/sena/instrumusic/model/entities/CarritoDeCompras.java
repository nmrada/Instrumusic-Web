/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.model.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author aprendiz
 */
@Entity
@Table(name = "carrito_de_compras")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CarritoDeCompras.findAll", query = "SELECT c FROM CarritoDeCompras c"),
    @NamedQuery(name = "CarritoDeCompras.findByIdCarritoDeCompras", query = "SELECT c FROM CarritoDeCompras c WHERE c.idCarritoDeCompras = :idCarritoDeCompras"),
    @NamedQuery(name = "CarritoDeCompras.findBySubtotal", query = "SELECT c FROM CarritoDeCompras c WHERE c.subtotal = :subtotal"),
    @NamedQuery(name = "CarritoDeCompras.findByPrecioTotal", query = "SELECT c FROM CarritoDeCompras c WHERE c.precioTotal = :precioTotal"),
    @NamedQuery(name = "CarritoDeCompras.findByImpuestos", query = "SELECT c FROM CarritoDeCompras c WHERE c.impuestos = :impuestos")})
public class CarritoDeCompras implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "idCarritoDeCompras")
    private String idCarritoDeCompras;
    @Basic(optional = false)
    @NotNull
    @Column(name = "subtotal")
    private float subtotal;
    @Basic(optional = false)
    @NotNull
    @Column(name = "precioTotal")
    private float precioTotal;
    @Basic(optional = false)
    @NotNull
    @Column(name = "impuestos")
    private float impuestos;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "carritoDeCompras", fetch = FetchType.EAGER)
    private List<ItemCarrito> itemCarritoList;

    public CarritoDeCompras() {
    }

    public CarritoDeCompras(String idCarritoDeCompras) {
        this.idCarritoDeCompras = idCarritoDeCompras;
    }

    public CarritoDeCompras(String idCarritoDeCompras, float subtotal, float precioTotal, float impuestos) {
        this.idCarritoDeCompras = idCarritoDeCompras;
        this.subtotal = subtotal;
        this.precioTotal = precioTotal;
        this.impuestos = impuestos;
    }

    public String getIdCarritoDeCompras() {
        return idCarritoDeCompras;
    }

    public void setIdCarritoDeCompras(String idCarritoDeCompras) {
        this.idCarritoDeCompras = idCarritoDeCompras;
    }

    public float getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }

    public float getPrecioTotal() {
        return precioTotal;
    }

    public void setPrecioTotal(float precioTotal) {
        this.precioTotal = precioTotal;
    }

    public float getImpuestos() {
        return impuestos;
    }

    public void setImpuestos(float impuestos) {
        this.impuestos = impuestos;
    }

    @XmlTransient
    public List<ItemCarrito> getItemCarritoList() {
        return itemCarritoList;
    }

    public void setItemCarritoList(List<ItemCarrito> itemCarritoList) {
        this.itemCarritoList = itemCarritoList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idCarritoDeCompras != null ? idCarritoDeCompras.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CarritoDeCompras)) {
            return false;
        }
        CarritoDeCompras other = (CarritoDeCompras) object;
        if ((this.idCarritoDeCompras == null && other.idCarritoDeCompras != null) || (this.idCarritoDeCompras != null && !this.idCarritoDeCompras.equals(other.idCarritoDeCompras))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "edu.co.sena.instrumusic.modelo.entities.CarritoDeCompras[ idCarritoDeCompras=" + idCarritoDeCompras + " ]";
    }
    
}
