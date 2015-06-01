package edu.co.sena.instrumusic.view.administrador.bean;

import edu.co.sena.instrumusic.model.entities.DomicilioCuenta;
import edu.co.sena.instrumusic.view.general.util.JsfUtil;
import edu.co.sena.instrumusic.view.general.util.JsfUtil.PersistAction;
import edu.co.sena.instrumusic.controller.administrador.beans.DomicilioCuentaFacade;

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

@Named("domicilioCuentaController")
@SessionScoped
public class DomicilioCuentaController implements Serializable {

    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.DomicilioCuentaFacade ejbFacade;
    private List<DomicilioCuenta> items = null;
    private DomicilioCuenta selected;

    public DomicilioCuentaController() {
    }

    public DomicilioCuenta getSelected() {
        return selected;
    }

    public void setSelected(DomicilioCuenta selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
        selected.getDomicilioCuentaPK().setCuentanumeroDocumento(selected.getCuenta().getCuentaPK().getNumeroDocumento());
        selected.getDomicilioCuentaPK().setCuentaTipoDocumentotipoDocumento(selected.getCuenta().getCuentaPK().getTipoDocumentotipoDocumento());
    }

    protected void initializeEmbeddableKey() {
        selected.setDomicilioCuentaPK(new edu.co.sena.instrumusic.model.entities.DomicilioCuentaPK());
    }

    private DomicilioCuentaFacade getFacade() {
        return ejbFacade;
    }

    public DomicilioCuenta prepareCreate() {
        selected = new DomicilioCuenta();
        initializeEmbeddableKey();
        return selected;
    }

    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("DomicilioCuentaCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("DomicilioCuentaUpdated"));
    }

    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("DomicilioCuentaDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public List<DomicilioCuenta> getItems() {
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

    public DomicilioCuenta getDomicilioCuenta(edu.co.sena.instrumusic.model.entities.DomicilioCuentaPK id) {
        return getFacade().find(id);
    }

    public List<DomicilioCuenta> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<DomicilioCuenta> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    @FacesConverter(forClass = DomicilioCuenta.class)
    public static class DomicilioCuentaControllerConverter implements Converter {

        private static final String SEPARATOR = "#";
        private static final String SEPARATOR_ESCAPED = "\\#";

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            DomicilioCuentaController controller = (DomicilioCuentaController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "domicilioCuentaController");
            return controller.getDomicilioCuenta(getKey(value));
        }

        edu.co.sena.instrumusic.model.entities.DomicilioCuentaPK getKey(String value) {
            edu.co.sena.instrumusic.model.entities.DomicilioCuentaPK key;
            String values[] = value.split(SEPARATOR_ESCAPED);
            key = new edu.co.sena.instrumusic.model.entities.DomicilioCuentaPK();
            key.setCuentaTipoDocumentotipoDocumento(values[0]);
            key.setCuentanumeroDocumento(values[1]);
            return key;
        }

        String getStringKey(edu.co.sena.instrumusic.model.entities.DomicilioCuentaPK value) {
            StringBuilder sb = new StringBuilder();
            sb.append(value.getCuentaTipoDocumentotipoDocumento());
            sb.append(SEPARATOR);
            sb.append(value.getCuentanumeroDocumento());
            return sb.toString();
        }

        @Override
        public String getAsString(FacesContext facesContext, UIComponent component, Object object) {
            if (object == null) {
                return null;
            }
            if (object instanceof DomicilioCuenta) {
                DomicilioCuenta o = (DomicilioCuenta) object;
                return getStringKey(o.getDomicilioCuentaPK());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), DomicilioCuenta.class.getName()});
                return null;
            }
        }

    }

}
