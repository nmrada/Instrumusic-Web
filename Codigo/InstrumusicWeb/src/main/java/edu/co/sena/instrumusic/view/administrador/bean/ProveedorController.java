package edu.co.sena.instrumusic.view.administrador.bean;

import edu.co.sena.instrumusic.model.entities.Proveedor;
import edu.co.sena.instrumusic.view.general.util.JsfUtil;
import edu.co.sena.instrumusic.view.general.util.JsfUtil.PersistAction;
import edu.co.sena.instrumusic.controller.administrador.beans.ProveedorFacade;
import edu.co.sena.instrumusic.model.entities.TipoDocumento;

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

@Named("proveedorController")
@SessionScoped
public class ProveedorController implements Serializable {

    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.ProveedorFacade ejbFacade;
    private List<Proveedor> items = null;
    private List<Proveedor> itemsBuscados = null;

    private Proveedor selected;
    private Proveedor selectedBuscar;
    private String tipoDocumentoBuscar;
    private String numeroDocumentoBuscar;
    private String nombreBuscar;
    private String emailBuscar;

    public ProveedorController() {
    }

    public List<Proveedor> buscarPorTipoDocumento() {
        itemsBuscados = getFacade().findByTipoDocumento(tipoDocumentoBuscar);
        numeroDocumentoBuscar = null;
        nombreBuscar = null;
        emailBuscar = null;
        return itemsBuscados;
    }

    public List<Proveedor> buscarPorNumeroDocumento() {
        itemsBuscados = getFacade().findByNumeroDocumento(numeroDocumentoBuscar);
        tipoDocumentoBuscar = null;
        nombreBuscar = null;
        emailBuscar = null;
        return itemsBuscados;
    }

    public List<Proveedor> buscarPorNombre() {
        itemsBuscados = getFacade().findByNombre(nombreBuscar);
        numeroDocumentoBuscar = null;
        tipoDocumentoBuscar = null;
        emailBuscar = null;
        return itemsBuscados;
    }

    public List<Proveedor> buscarPorEmail() {
        itemsBuscados = getFacade().findByEmail(emailBuscar);
        numeroDocumentoBuscar = null;
        nombreBuscar = null;
        tipoDocumentoBuscar = null;
        return itemsBuscados;
    }

    public Proveedor getSelected() {
        return selected;
    }

    public void setSelected(Proveedor selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
        selected.getProveedorPK().setTipoDocumentotipoDocumento(selected.getTipoDocumento().getTipoDocumento());
    }

    protected void initializeEmbeddableKey() {
        selected.setProveedorPK(new edu.co.sena.instrumusic.model.entities.ProveedorPK());
    }

    private ProveedorFacade getFacade() {
        return ejbFacade;
    }

    public Proveedor prepareCreate() {
        selected = new Proveedor();
        initializeEmbeddableKey();
        return selected;
    }

    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("ProveedorCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("ProveedorUpdated"));
        selectedBuscar= null;
        itemsBuscados= null;
    }
    
     public void updateBuscar() {
        persist(PersistAction.UPDATEBUSCAR, ResourceBundle.getBundle("/Bundle").getString("ProveedorUpdated"));
        selected= null;
        items= null;
    }

    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("ProveedorDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
        itemsBuscados = null;
        selectedBuscar = null;
    }
    
      public void eliminarBuscado() {
        persist(PersistAction.DELETEBUSCAR, ResourceBundle.getBundle("/Bundle").getString("ProveedorDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
        itemsBuscados = null;
        selectedBuscar = null;
    }
    
    

    public List<Proveedor> getItems() {
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
                    tipoDocumentoBuscar = null;
                    numeroDocumentoBuscar = null;
                    nombreBuscar = null;
                    emailBuscar = null;
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

    public Proveedor getProveedor(edu.co.sena.instrumusic.model.entities.ProveedorPK id) {
        return getFacade().find(id);
    }

    public List<Proveedor> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<Proveedor> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    public List<Proveedor> getItemsBuscados() {
        return itemsBuscados;
    }

    public void setItemsBuscados(List<Proveedor> itemsBuscados) {
        this.itemsBuscados = itemsBuscados;
    }

    public Proveedor getSelectedBuscar() {
        return selectedBuscar;
    }

    public void setSelectedBuscar(Proveedor selectedBuscar) {
        this.selectedBuscar = selectedBuscar;
    }

    public String getNumeroDocumentoBuscar() {
        return numeroDocumentoBuscar;
    }

    public void setNumeroDocumentoBuscar(String numeroDocumentoBuscar) {
        this.numeroDocumentoBuscar = numeroDocumentoBuscar;
    }

    public String getNombreBuscar() {
        return nombreBuscar;
    }

    public void setNombreBuscar(String nombreBuscar) {
        this.nombreBuscar = nombreBuscar;
    }

    public String getEmailBuscar() {
        return emailBuscar;
    }

    public void setEmailBuscar(String emailBuscar) {
        this.emailBuscar = emailBuscar;
    }

    public String getTipoDocumentoBuscar() {
        return tipoDocumentoBuscar;
    }

    public void setTipoDocumentoBuscar(String tipoDocumentoBuscar) {
        this.tipoDocumentoBuscar = tipoDocumentoBuscar;
    }

    @FacesConverter(forClass = Proveedor.class)
    public static class ProveedorControllerConverter implements Converter {

        private static final String SEPARATOR = "#";
        private static final String SEPARATOR_ESCAPED = "\\#";

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            ProveedorController controller = (ProveedorController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "proveedorController");
            return controller.getProveedor(getKey(value));
        }

        edu.co.sena.instrumusic.model.entities.ProveedorPK getKey(String value) {
            edu.co.sena.instrumusic.model.entities.ProveedorPK key;
            String values[] = value.split(SEPARATOR_ESCAPED);
            key = new edu.co.sena.instrumusic.model.entities.ProveedorPK();
            key.setTipoDocumentotipoDocumento(values[0]);
            key.setNumeroDocumento(values[1]);
            return key;
        }

        String getStringKey(edu.co.sena.instrumusic.model.entities.ProveedorPK value) {
            StringBuilder sb = new StringBuilder();
            sb.append(value.getTipoDocumentotipoDocumento());
            sb.append(SEPARATOR);
            sb.append(value.getNumeroDocumento());
            return sb.toString();
        }

        @Override
        public String getAsString(FacesContext facesContext, UIComponent component, Object object) {
            if (object == null) {
                return null;
            }
            if (object instanceof Proveedor) {
                Proveedor o = (Proveedor) object;
                return getStringKey(o.getProveedorPK());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), Proveedor.class.getName()});
                return null;
            }
        }

    }

}
