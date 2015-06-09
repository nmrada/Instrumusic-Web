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
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
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
@Table(name = "proveedor")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Proveedor.findAll", query = "SELECT p FROM Proveedor p"),
    @NamedQuery(name = "Proveedor.findByTipoDocumentotipoDocumento", query = "SELECT p FROM Proveedor p WHERE p.proveedorPK.tipoDocumentotipoDocumento = :tipoDocumentotipoDocumento"),
    @NamedQuery(name = "Proveedor.findByNumeroDocumento", query = "SELECT p FROM Proveedor p WHERE p.proveedorPK.numeroDocumento = :numeroDocumento"),
    @NamedQuery(name = "Proveedor.findByNombre", query = "SELECT p FROM Proveedor p WHERE p.nombre = :nombre"),
    @NamedQuery(name = "Proveedor.findByEmail", query = "SELECT p FROM Proveedor p WHERE p.email = :email")})
public class Proveedor implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ProveedorPK proveedorPK;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "nombre")
    private String nombre;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "email")
    private String email;
    @OneToOne(cascade ={CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH }, mappedBy = "proveedor", fetch = FetchType.LAZY)
    private DomicilioProveedor domicilioProveedor;
    @OneToMany(cascade ={CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH }, mappedBy = "proveedor", fetch = FetchType.EAGER)
    private List<Inventario> inventarioList;
    @JoinColumn(name = "Tipo_Documento_tipoDocumento", referencedColumnName = "tipoDocumento", insertable = false, updatable = false)
    @ManyToOne(optional = false, fetch = FetchType.EAGER )
    private TipoDocumento tipoDocumento;

    public Proveedor() {
    }

    public Proveedor(ProveedorPK proveedorPK) {
        this.proveedorPK = proveedorPK;
    }

    public Proveedor(ProveedorPK proveedorPK, String nombre, String email) {
        this.proveedorPK = proveedorPK;
        this.nombre = nombre;
        this.email = email;
    }

    public Proveedor(String tipoDocumentotipoDocumento, String numeroDocumento) {
        this.proveedorPK = new ProveedorPK(tipoDocumentotipoDocumento, numeroDocumento);
    }

    public ProveedorPK getProveedorPK() {
        return proveedorPK;
    }

    public void setProveedorPK(ProveedorPK proveedorPK) {
        this.proveedorPK = proveedorPK;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public DomicilioProveedor getDomicilioProveedor() {
        return domicilioProveedor;
    }

    public void setDomicilioProveedor(DomicilioProveedor domicilioProveedor) {
        this.domicilioProveedor = domicilioProveedor;
    }

    @XmlTransient
    public List<Inventario> getInventarioList() {
        return inventarioList;
    }

    public void setInventarioList(List<Inventario> inventarioList) {
        this.inventarioList = inventarioList;
    }

    public TipoDocumento getTipoDocumento() {
        return tipoDocumento;
    }

    public void setTipoDocumento(TipoDocumento tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (proveedorPK != null ? proveedorPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Proveedor)) {
            return false;
        }
        Proveedor other = (Proveedor) object;
        if ((this.proveedorPK == null && other.proveedorPK != null) || (this.proveedorPK != null && !this.proveedorPK.equals(other.proveedorPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "edu.co.sena.instrumusic.model.entities.Proveedor[ proveedorPK=" + proveedorPK + " ]";
    }
    
}
