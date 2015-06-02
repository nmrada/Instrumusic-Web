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
public class DomicilioCuentaPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 40)
    @Column(name = "Cuenta_Tipo_Documento_tipoDocumento")
    private String cuentaTipoDocumentotipoDocumento;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "Cuenta_numeroDocumento")
    private String cuentanumeroDocumento;

    public DomicilioCuentaPK() {
    }

    public DomicilioCuentaPK(String cuentaTipoDocumentotipoDocumento, String cuentanumeroDocumento) {
        this.cuentaTipoDocumentotipoDocumento = cuentaTipoDocumentotipoDocumento;
        this.cuentanumeroDocumento = cuentanumeroDocumento;
    }

    public String getCuentaTipoDocumentotipoDocumento() {
        return cuentaTipoDocumentotipoDocumento;
    }

    public void setCuentaTipoDocumentotipoDocumento(String cuentaTipoDocumentotipoDocumento) {
        this.cuentaTipoDocumentotipoDocumento = cuentaTipoDocumentotipoDocumento;
    }

    public String getCuentanumeroDocumento() {
        return cuentanumeroDocumento;
    }

    public void setCuentanumeroDocumento(String cuentanumeroDocumento) {
        this.cuentanumeroDocumento = cuentanumeroDocumento;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (cuentaTipoDocumentotipoDocumento != null ? cuentaTipoDocumentotipoDocumento.hashCode() : 0);
        hash += (cuentanumeroDocumento != null ? cuentanumeroDocumento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DomicilioCuentaPK)) {
            return false;
        }
        DomicilioCuentaPK other = (DomicilioCuentaPK) object;
        if ((this.cuentaTipoDocumentotipoDocumento == null && other.cuentaTipoDocumentotipoDocumento != null) || (this.cuentaTipoDocumentotipoDocumento != null && !this.cuentaTipoDocumentotipoDocumento.equals(other.cuentaTipoDocumentotipoDocumento))) {
            return false;
        }
        if ((this.cuentanumeroDocumento == null && other.cuentanumeroDocumento != null) || (this.cuentanumeroDocumento != null && !this.cuentanumeroDocumento.equals(other.cuentanumeroDocumento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "edu.co.sena.instrumusic.model.entities.DomicilioCuentaPK[ cuentaTipoDocumentotipoDocumento=" + cuentaTipoDocumentotipoDocumento + ", cuentanumeroDocumento=" + cuentanumeroDocumento + " ]";
    }
    
}
