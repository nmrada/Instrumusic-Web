/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.co.sena.instrumusic.model.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author aprendiz
 */
@Embeddable
public class DomicilioProveedorPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 40)
    @Column(name = "Proveedor_Tipo_Documento_tipoDocumento")
    private String proveedorTipoDocumentotipoDocumento;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Proveedor_numeroDocumento")
    private String proveedornumeroDocumento;

    public DomicilioProveedorPK() {
    }

    public DomicilioProveedorPK(String proveedorTipoDocumentotipoDocumento, String proveedornumeroDocumento) {
        this.proveedorTipoDocumentotipoDocumento = proveedorTipoDocumentotipoDocumento;
        this.proveedornumeroDocumento = proveedornumeroDocumento;
    }

    public String getProveedorTipoDocumentotipoDocumento() {
        return proveedorTipoDocumentotipoDocumento;
    }

    public void setProveedorTipoDocumentotipoDocumento(String proveedorTipoDocumentotipoDocumento) {
        this.proveedorTipoDocumentotipoDocumento = proveedorTipoDocumentotipoDocumento;
    }

    public String getProveedornumeroDocumento() {
        return proveedornumeroDocumento;
    }

    public void setProveedornumeroDocumento(String proveedornumeroDocumento) {
        this.proveedornumeroDocumento = proveedornumeroDocumento;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (proveedorTipoDocumentotipoDocumento != null ? proveedorTipoDocumentotipoDocumento.hashCode() : 0);
        hash += (proveedornumeroDocumento != null ? proveedornumeroDocumento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DomicilioProveedorPK)) {
            return false;
        }
        DomicilioProveedorPK other = (DomicilioProveedorPK) object;
        if ((this.proveedorTipoDocumentotipoDocumento == null && other.proveedorTipoDocumentotipoDocumento != null) || (this.proveedorTipoDocumentotipoDocumento != null && !this.proveedorTipoDocumentotipoDocumento.equals(other.proveedorTipoDocumentotipoDocumento))) {
            return false;
        }
        if ((this.proveedornumeroDocumento == null && other.proveedornumeroDocumento != null) || (this.proveedornumeroDocumento != null && !this.proveedornumeroDocumento.equals(other.proveedornumeroDocumento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "edu.co.sena.instrumusic.model.entities.DomicilioProveedorPK[ proveedorTipoDocumentotipoDocumento=" + proveedorTipoDocumentotipoDocumento + ", proveedornumeroDocumento=" + proveedornumeroDocumento + " ]";
    }
    
}
