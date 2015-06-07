package edu.co.sena.instrumusic.view.administrador.bean;

import edu.co.sena.instrumusic.model.entities.Usuario;
import edu.co.sena.instrumusic.view.general.util.JsfUtil;
import edu.co.sena.instrumusic.view.general.util.JsfUtil.PersistAction;
import edu.co.sena.instrumusic.controller.administrador.beans.UsuarioFacade;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.inject.Named;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;
import javax.faces.view.ViewScoped;

@Named("usuarioController")
@ViewScoped
public class UsuarioController implements Serializable {

    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.UsuarioFacade ejbFacade;
    private List<Usuario> items = null;
    private List<Usuario> itemsBuscados = null;
   private Usuario selectedBuscar;    
    private Usuario selected;
    private String idBuscar;
    private String rolBuscar;
    private String estadoBuscar;
    private String emailBuscar;
    private final List<String> listroles;
    private final List<String> listEstados;
    
    public UsuarioController() {
         this.listroles = Arrays.asList(ResourceBundle.getBundle("/Bundle").getString("SelectRolCliente"),
                ResourceBundle.getBundle("/Bundle").getString("SelectRolEmpleado"),
                ResourceBundle.getBundle("/Bundle").getString("SelectRolAdministrador"));
        this.listEstados = Arrays.asList(ResourceBundle.getBundle("/Bundle").getString("SelectEstadoActivo"),
                ResourceBundle.getBundle("/Bundle").getString("SelectEstadoInactivo"));
    }

    public Usuario getSelected() {
        return selected;
    }

    public void setSelected(Usuario selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
    }

    protected void initializeEmbeddableKey() {
    }

    private UsuarioFacade getFacade() {
        return ejbFacade;
    }

    public Usuario prepareCreate() {
        selected = new Usuario();
        initializeEmbeddableKey();
        return selected;
    }

    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("UsuarioCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("UsuarioUpdated"));
    }

     public void updateBuscar() {
        persist(PersistAction.UPDATEBUSCAR, ResourceBundle.getBundle("/Bundle").getString("UsuarioUpdated"));
        items = null;
        selected = null;

    }
     
    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("UsuarioDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }
    
   public void eliminarBuscado() {
        persist(PersistAction.DELETEBUSCAR, ResourceBundle.getBundle("/Bundle").getString("UsuarioDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
        itemsBuscados = null;
        selectedBuscar = null;

    }

    public List<Usuario> getItems() {
        if (items == null) {
            items = getFacade().findAll();
        }
        return items;
    }
      public List<Usuario> buscarPorId() {
        itemsBuscados = getFacade().finById(idBuscar);
        rolBuscar = null;
        items = null;
        return itemsBuscados;
    }

    public List<Usuario> buscarPorRol() {
        itemsBuscados = getFacade().findByPartRol(rolBuscar);
        items = null;
        idBuscar = null;
        return itemsBuscados;
    }

    public List<Usuario> buscarPorEstado() {
        itemsBuscados = getFacade().findByPartEstado(estadoBuscar);
        items = null;
        idBuscar = null;
        return itemsBuscados;
    }
    
    public List<Usuario> buscarPorEmail() {
        itemsBuscados = getFacade().finByEmail(emailBuscar);
        items = null;
        idBuscar = null;
        return itemsBuscados;
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
                    idBuscar=null;
                    emailBuscar=null;
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

    public Usuario getUsuario(java.lang.String id) {
        return getFacade().find(id);
    }

    public List<Usuario> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<Usuario> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    public Usuario getSelectedBuscar() {
        return selectedBuscar;
    }

    public void setSelectedBuscar(Usuario selectedBuscar) {
        this.selectedBuscar = selectedBuscar;
    }

    public String getIdBuscar() {
        return idBuscar;
    }

    public void setIdBuscar(String idBuscar) {
        this.idBuscar = idBuscar;
    }

    public String getRolBuscar() {
        return rolBuscar;
    }

    public void setRolBuscar(String rolBuscar) {
        this.rolBuscar = rolBuscar;
    }

    public List<Usuario> getItemsBuscados() {
        return itemsBuscados;
    }

    public void setItemsBuscados(List<Usuario> itemsBuscados) {
        this.itemsBuscados = itemsBuscados;
    }

    public List<String> getListroles() {
        return listroles;
    }

    public List<String> getListEstados() {
        return listEstados;
    }

    public String getEstadoBuscar() {
        return estadoBuscar;
    }

    public void setEstadoBuscar(String estadoBuscar) {
        this.estadoBuscar = estadoBuscar;
    }

    public String getEmailBuscar() {
        return emailBuscar;
    }

    public void setEmailBuscar(String emailBuscar) {
        this.emailBuscar = emailBuscar;
    }

    @FacesConverter(forClass = Usuario.class)
    public static class UsuarioControllerConverter implements Converter {

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            UsuarioController controller = (UsuarioController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "usuarioController");
            return controller.getUsuario(getKey(value));
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
            if (object instanceof Usuario) {
                Usuario o = (Usuario) object;
                return getStringKey(o.getIdUsuario());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), Usuario.class.getName()});
                return null;
            }
        }

    }

}
