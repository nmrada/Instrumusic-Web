package edu.co.sena.instrumusic.view.administrador.bean;

import edu.co.sena.instrumusic.model.entities.TipoDocumento;
import edu.co.sena.instrumusic.view.general.util.JsfUtil;
import edu.co.sena.instrumusic.view.general.util.JsfUtil.PersistAction;
import edu.co.sena.instrumusic.controller.administrador.beans.TipoDocumentoFacade;

import java.io.Serializable;
import java.util.List;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

@Named("tipoDocumentoController")
@SessionScoped
public class TipoDocumentoController implements Serializable {

    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.TipoDocumentoFacade ejbFacade;
    private List<TipoDocumento> items = null;
    private List<TipoDocumento> itemBuscados = null;
    private TipoDocumento selected;
    private TipoDocumento selectedBuscar;

    private String tipoDocumentoBuscar;
    private String descripcionBuscar;
    private Boolean activoBuscar;

    public TipoDocumentoController() {
    }

    public List<TipoDocumento> buscarPorTipoDocumento() {
        itemBuscados = getFacade().findById(tipoDocumentoBuscar);
        activoBuscar = null;
        descripcionBuscar = null;
        items = null;
        return itemBuscados;
    }

    public List<TipoDocumento> buscarPorDescripcion() {
        itemBuscados = getFacade().findByDescripcion(descripcionBuscar);
        activoBuscar = null;
        tipoDocumentoBuscar = null;
        items = null;
        return itemBuscados;
    }
    
    public List<TipoDocumento> buscarPorActivo() {
        itemBuscados = getFacade().findByActivo(activoBuscar);
        descripcionBuscar = null;
        tipoDocumentoBuscar = null;
        items = null;
        return itemBuscados;
    }

    public TipoDocumento getSelected() {
        return selected;
    }

    public void setSelected(TipoDocumento selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
    }

    protected void initializeEmbeddableKey() {
    }

    private TipoDocumentoFacade getFacade() {
        return ejbFacade;
    }

    public TipoDocumento prepareCreate() {
        selected = new TipoDocumento();
        initializeEmbeddableKey();
        return selected;
    }

    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("TipoDocumentoCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("TipoDocumentoUpdated"));
        selectedBuscar = null;
        itemBuscados = null;
    }
    
    public void updateBuscar() {
        persist(PersistAction.UPDATEBUSCAR, ResourceBundle.getBundle("/Bundle").getString("TipoDocumentoUpdated"));
        selected = null;
        items = null;
    }

    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("TipoDocumentoDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }
    
    public void eliminarBuscado() {
        persist(PersistAction.DELETEBUSCAR, ResourceBundle.getBundle("/Bundle").getString("TipoDocumentoDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
        itemBuscados = null;
        selectedBuscar = null;
    }

    public List<TipoDocumento> getItems() {
        if (items == null) {
            items = getFacade().findAll();
        }
        return items;
    }

    private void persist(PersistAction persistAction, String successMessage) {
        if (selected != null) {
            setEmbeddableKeys();
            try {
                if (persistAction != PersistAction.DELETE) {
                    getFacade().edit(selected);
                } else {
                    getFacade().remove(selected);
                }
                JsfUtil.addSuccessMessage(successMessage);
            } catch (EJBException ex) {
                String msg = "";
                Throwable cause = ex.getCause();
                if (cause != null) {
                    msg = cause.getLocalizedMessage();
                }
                if (msg.length() > 0) {
                    JsfUtil.addErrorMessage(msg);
                } else {
                    JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/Bundle").getString("PersistenceErrorOccured"));
                }
            } catch (Exception ex) {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, null, ex);
                JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/Bundle").getString("PersistenceErrorOccured"));
            }
        }
        if (selectedBuscar != null) {
            setEmbeddableKeys();
            try {
                if (persistAction != PersistAction.DELETEBUSCAR) {
                    getFacade().edit(selectedBuscar);
                } else {
                    getFacade().remove(selectedBuscar);
                }
                JsfUtil.addSuccessMessage(successMessage);
            } catch (EJBException ex) {
                String msg = "";
                Throwable cause = ex.getCause();
                if (cause != null) {
                    msg = cause.getLocalizedMessage();
                }
                if (msg.length() > 0) {
                    JsfUtil.addErrorMessage(msg);
                } else {
                    JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/Bundle").getString("PersistenceErrorOccured"));
                }
            } catch (Exception ex) {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, null, ex);
                JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/Bundle").getString("PersistenceErrorOccured"));
            }
        }
    }

    public TipoDocumento getTipoDocumento(java.lang.String id) {
        return getFacade().find(id);
    }

    public List<TipoDocumento> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<TipoDocumento> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    public String getTipoDocumentoBuscar() {
        return tipoDocumentoBuscar;
    }

    public void setTipoDocumentoBuscar(String tipoDocumentoBuscar) {
        this.tipoDocumentoBuscar = tipoDocumentoBuscar;
    }

    public List<TipoDocumento> getItemBuscados() {
        return itemBuscados;
    }

    public void setItemBuscados(List<TipoDocumento> itemBuscados) {
        this.itemBuscados = itemBuscados;
    }

    public TipoDocumento getSelectedBuscar() {
        return selectedBuscar;
    }

    public void setSelectedBuscar(TipoDocumento selectedBuscar) {
        this.selectedBuscar = selectedBuscar;
    }

    public String getDescripcionBuscar() {
        return descripcionBuscar;
    }

    public void setDescripcionBuscar(String descripcionBuscar) {
        this.descripcionBuscar = descripcionBuscar;
    }

    public Boolean getActivoBuscar() {
        return activoBuscar;
    }

    public void setActivoBuscar(Boolean activoBuscar) {
        this.activoBuscar = activoBuscar;
    }

    @FacesConverter(forClass = TipoDocumento.class)
    public static class TipoDocumentoControllerConverter implements Converter {

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            TipoDocumentoController controller = (TipoDocumentoController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "tipoDocumentoController");
            return controller.getTipoDocumento(getKey(value));
        }

        java.lang.String getKey(String value) {
            java.lang.String key;
            key = value;
            return key;
        }

        String getStringKey(java.lang.String value) {
            StringBuilder sb = new StringBuilder();
            sb.append(value);
            return sb.toString();
        }

        @Override
        public String getAsString(FacesContext facesContext, UIComponent component, Object object) {
            if (object == null) {
                return null;
            }
            if (object instanceof TipoDocumento) {
                TipoDocumento o = (TipoDocumento) object;
                return getStringKey(o.getTipoDocumento());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), TipoDocumento.class.getName()});
                return null;
            }
        }

    }

}
