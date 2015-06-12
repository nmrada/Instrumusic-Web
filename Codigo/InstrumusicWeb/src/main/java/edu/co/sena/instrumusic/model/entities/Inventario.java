/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.model.entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author aprendiz
 */
@Entity
@Table(name = "inventario")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Inventario.findAll", query = "SELECT i FROM Inventario i"),
    @NamedQuery(name = "Inventario.findByIdInventario", query = "SELECT i FROM Inventario i WHERE i.inventarioPK.idInventario = :idInventario"),
    @NamedQuery(name = "Inventario.findByFecha", query = "SELECT i FROM Inventario i WHERE i.fecha = :fecha"),
    @NamedQuery(name = "Inventario.findByCantidad", query = "SELECT i FROM Inventario i WHERE i.cantidad = :cantidad"),
    @NamedQuery(name = "Inventario.findByProductoidProducto", query = "SELECT i FROM Inventario i WHERE i.inventarioPK.productoidProducto = :productoidProducto"),
    @NamedQuery(name = "Inventario.findByProveedorTipoDocumentotipoDocumento", query = "SELECT i FROM Inventario i WHERE i.inventarioPK.proveedorTipoDocumentotipoDocumento = :proveedorTipoDocumentotipoDocumento"),
    @NamedQuery(name = "Inventario.findByProveedornumeroDocumento", query = "SELECT i FROM Inventario i WHERE i.inventarioPK.proveedornumeroDocumento = :proveedornumeroDocumento")})
public class Inventario implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected InventarioPK inventarioPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha")
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @Basic(optional = false)
    @NotNull
    @Column(name = "cantidad")
    private int cantidad;
    @JoinColumns({
        @JoinColumn(name = "Proveedor_Tipo_Documento_tipoDocumento", referencedColumnName = "Tipo_Documento_tipoDocumento", insertable = false, updatable = false),
        @JoinColumn(name = "Proveedor_numeroDocumento", referencedColumnName = "numeroDocumento", insertable = false, updatable = false)})
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private Proveedor proveedor;
    @JoinColumn(name = "Producto_idProducto", referencedColumnName = "idProducto", insertable = false, updatable = false)
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private Producto producto;

    public Inventario() {
    }

    public Inventario(InventarioPK inventarioPK) {
        this.inventarioPK = inventarioPK;
    }

    public Inventario(InventarioPK inventarioPK, Date fecha, int cantidad) {
        this.inventarioPK = inventarioPK;
        this.fecha = fecha;
        this.cantidad = cantidad;
    }

    public Inventario(int idInventario, String productoidProducto, String proveedorTipoDocumentotipoDocumento, String proveedornumeroDocumento) {
        this.inventarioPK = new InventarioPK(idInventario, productoidProducto, proveedorTipoDocumentotipoDocumento, proveedornumeroDocumento);
    }

    public InventarioPK getInventarioPK() {
        return inventarioPK;
    }

    public void setInventarioPK(InventarioPK inventarioPK) {
        this.inventarioPK = inventarioPK;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Proveedor getProveedor() {
        return proveedor;
    }

    public void setProveedor(Proveedor proveedor) {
        this.proveedor = proveedor;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (inventarioPK != null ? inventarioPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Inventario)) {
            return false;
        }
        Inventario other = (Inventario) object;
        if ((this.inventarioPK == null && other.inventarioPK != null) || (this.inventarioPK != null && !this.inventarioPK.equals(other.inventarioPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "edu.co.sena.instrumusic.model.entities.Inventario[ inventarioPK=" + inventarioPK + " ]";
    }
    
}
