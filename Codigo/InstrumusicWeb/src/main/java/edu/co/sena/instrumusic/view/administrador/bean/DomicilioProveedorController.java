package edu.co.sena.instrumusic.view.administrador.bean;

import edu.co.sena.instrumusic.model.entities.DomicilioProveedor;
import edu.co.sena.instrumusic.view.general.util.JsfUtil;
import edu.co.sena.instrumusic.view.general.util.JsfUtil.PersistAction;
import edu.co.sena.instrumusic.controller.administrador.beans.DomicilioProveedorFacade;

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

@Named("domicilioProveedorController")
@SessionScoped
public class DomicilioProveedorController implements Serializable {

    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.DomicilioProveedorFacade ejbFacade;
    private List<DomicilioProveedor> items = null;
    private DomicilioProveedor selected;

    public DomicilioProveedorController() {
    }

    public DomicilioProveedor getSelected() {
        return selected;
    }

    public void setSelected(DomicilioProveedor selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
        selected.getDomicilioProveedorPK().setProveedorTipoDocumentotipoDocumento(selected.getProveedor().getProveedorPK().getTipoDocumentotipoDocumento());
        selected.getDomicilioProveedorPK().setProveedornumeroDocumento(selected.getProveedor().getProveedorPK().getNumeroDocumento());
    }

    protected void initializeEmbeddableKey() {
        selected.setDomicilioProveedorPK(new edu.co.sena.instrumusic.model.entities.DomicilioProveedorPK());
    }

    private DomicilioProveedorFacade getFacade() {
        return ejbFacade;
    }

    public DomicilioProveedor prepareCreate() {
        selected = new DomicilioProveedor();
        initializeEmbeddableKey();
        return selected;
    }

    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("DomicilioProveedorCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("DomicilioProveedorUpdated"));
    }

    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("DomicilioProveedorDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public List<DomicilioProveedor> getItems() {
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
    }

    public DomicilioProveedor getDomicilioProveedor(edu.co.sena.instrumusic.model.entities.DomicilioProveedorPK id) {
        return getFacade().find(id);
    }

    public List<DomicilioProveedor> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<DomicilioProveedor> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    @FacesConverter(forClass = DomicilioProveedor.class)
    public static class DomicilioProveedorControllerConverter implements Converter {

        private static final String SEPARATOR = "#";
        private static final String SEPARATOR_ESCAPED = "\\#";

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            DomicilioProveedorController controller = (DomicilioProveedorController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "domicilioProveedorController");
            return controller.getDomicilioProveedor(getKey(value));
        }

        edu.co.sena.instrumusic.model.entities.DomicilioProveedorPK getKey(String value) {
            edu.co.sena.instrumusic.model.entities.DomicilioProveedorPK key;
            String values[] = value.split(SEPARATOR_ESCAPED);
            key = new edu.co.sena.instrumusic.model.entities.DomicilioProveedorPK();
            key.setProveedorTipoDocumentotipoDocumento(values[0]);
            key.setProveedornumeroDocumento(values[1]);
            return key;
        }

        String getStringKey(edu.co.sena.instrumusic.model.entities.DomicilioProveedorPK value) {
            StringBuilder sb = new StringBuilder();
            sb.append(value.getProveedorTipoDocumentotipoDocumento());
            sb.append(SEPARATOR);
            sb.append(value.getProveedornumeroDocumento());
            return sb.toString();
        }

        @Override
        public String getAsString(FacesContext facesContext, UIComponent component, Object object) {
            if (object == null) {
                return null;
            }
            if (object instanceof DomicilioProveedor) {
                DomicilioProveedor o = (DomicilioProveedor) object;
                return getStringKey(o.getDomicilioProveedorPK());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), DomicilioProveedor.class.getName()});
                return null;
            }
        }

    }

}
