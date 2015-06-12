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
public class ProveedorPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 40)
    @Column(name = "Tipo_Documento_tipoDocumento")
    private String tipoDocumentotipoDocumento;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "numeroDocumento")
    private String numeroDocumento;

    public ProveedorPK() {
    }

    public ProveedorPK(String tipoDocumentotipoDocumento, String numeroDocumento) {
        this.tipoDocumentotipoDocumento = tipoDocumentotipoDocumento;
        this.numeroDocumento = numeroDocumento;
    }

    public String getTipoDocumentotipoDocumento() {
        return tipoDocumentotipoDocumento;
    }

    public void setTipoDocumentotipoDocumento(String tipoDocumentotipoDocumento) {
        this.tipoDocumentotipoDocumento = tipoDocumentotipoDocumento;
    }

    public String getNumeroDocumento() {
        return numeroDocumento;
    }

    public void setNumeroDocumento(String numeroDocumento) {
        this.numeroDocumento = numeroDocumento;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (tipoDocumentotipoDocumento != null ? tipoDocumentotipoDocumento.hashCode() : 0);
        hash += (numeroDocumento != null ? numeroDocumento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProveedorPK)) {
            return false;
        }
        ProveedorPK other = (ProveedorPK) object;
        if ((this.tipoDocumentotipoDocumento == null && other.tipoDocumentotipoDocumento != null) || (this.tipoDocumentotipoDocumento != null && !this.tipoDocumentotipoDocumento.equals(other.tipoDocumentotipoDocumento))) {
            return false;
        }
        if ((this.numeroDocumento == null && other.numeroDocumento != null) || (this.numeroDocumento != null && !this.numeroDocumento.equals(other.numeroDocumento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "edu.co.sena.instrumusic.model.entities.ProveedorPK[ tipoDocumentotipoDocumento=" + tipoDocumentotipoDocumento + ", numeroDocumento=" + numeroDocumento + " ]";
    }
    
}
