package edu.co.sena.instrumusic.view.administrador.bean;

import edu.co.sena.instrumusic.model.entities.CarritoDeCompras;
import edu.co.sena.instrumusic.view.general.util.JsfUtil;
import edu.co.sena.instrumusic.view.general.util.JsfUtil.PersistAction;
import edu.co.sena.instrumusic.controller.administrador.beans.CarritoDeComprasFacade;

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

@Named("carritoDeComprasController")
@SessionScoped
public class CarritoDeComprasController implements Serializable {

    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.CarritoDeComprasFacade ejbFacade;
    private List<CarritoDeCompras> items = null;
    private CarritoDeCompras selected;

    public CarritoDeComprasController() {
    }

    public CarritoDeCompras getSelected() {
        return selected;
    }

    public void setSelected(CarritoDeCompras selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
    }

    protected void initializeEmbeddableKey() {
    }

    private CarritoDeComprasFacade getFacade() {
        return ejbFacade;
    }

    public CarritoDeCompras prepareCreate() {
        selected = new CarritoDeCompras();
        initializeEmbeddableKey();
        return selected;
    }

    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("CarritoDeComprasCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("CarritoDeComprasUpdated"));
    }

    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("CarritoDeComprasDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public List<CarritoDeCompras> getItems() {
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

    public CarritoDeCompras getCarritoDeCompras(java.lang.String id) {
        return getFacade().find(id);
    }

    public List<CarritoDeCompras> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<CarritoDeCompras> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    @FacesConverter(forClass = CarritoDeCompras.class)
    public static class CarritoDeComprasControllerConverter implements Converter {

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            CarritoDeComprasController controller = (CarritoDeComprasController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "carritoDeComprasController");
            return controller.getCarritoDeCompras(getKey(value));
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
            if (object instanceof CarritoDeCompras) {
                CarritoDeCompras o = (CarritoDeCompras) object;
                return getStringKey(o.getIdCarritoDeCompras());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), CarritoDeCompras.class.getName()});
                return null;
            }
        }

    }

}
