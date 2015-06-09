package edu.co.sena.instrumusic.view.administrador.bean;

import edu.co.sena.instrumusic.controller.administrador.dto.ProductoDTO;
import edu.co.sena.instrumusic.model.entities.Producto;
import edu.co.sena.instrumusic.view.general.util.JsfUtil;
import edu.co.sena.instrumusic.view.general.util.JsfUtil.PersistAction;
import edu.co.sena.instrumusic.controller.administrador.beans.ProductoFacade;
import edu.co.sena.instrumusic.general.utils.ConversorDTO;
import java.io.Serializable;
import java.util.ArrayList;
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
import javax.faces.view.ViewScoped;
import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.UploadedFile;

@Named("productoController")
@ViewScoped
public class ProductoController implements Serializable {
    
    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.ProductoFacade ejbFacade;
    private List<ProductoDTO> items = null;
    private ProductoDTO selected;
    
    private UploadedFile file;
 
    public ProductoController() {
    }
    
    public ProductoDTO getSelected() {
        return selected;
    }
    
    public void setSelected(ProductoDTO selected) {
        this.selected = selected;
    }
    
    protected void setEmbeddableKeys() {
    }
    
    protected void initializeEmbeddableKey() {
    }
    
    private ProductoFacade getFacade() {
        return ejbFacade;
    }
    
    public ProductoDTO prepareCreate() {
        selected = new ProductoDTO();
        initializeEmbeddableKey();
        return selected;
    }
    
    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("ProductoCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }
    
    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("ProductoUpdated"));
    }
    
    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("ProductoDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }
    
    public List<ProductoDTO> getItems() {
        if (items == null) {
            List<Producto> listaP = getFacade().findAll();
            items= new ArrayList<>();
            if (!listaP.isEmpty()) {
                for (Producto listaP1 : listaP) {
                    ProductoDTO pt = ConversorDTO.conversorProductoaProductoDTO(listaP1);
                    items.add(pt);
                }
            } else {
                items = null;
            }
        }
        return items;
    }
    
    private void persist(PersistAction persistAction, String successMessage) {
        if (selected != null) {
            setEmbeddableKeys();
            try {
                if (persistAction != PersistAction.DELETE) {
                    getFacade().edit(ConversorDTO.conversorProductoDTOaProducto(selected));
                } else {
                    getFacade().remove(ConversorDTO.conversorProductoDTOaProducto(selected));
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
    
    public Producto getProducto(java.lang.String id) {
        return getFacade().find(id);
    }
    
    public List<Producto> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }
    
    public List<Producto> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    public UploadedFile getFile() {
        return file;
    }

    public void setFile(UploadedFile file) {
        this.file = file;
    }
    
    public void handleFileUpload(FileUploadEvent event) {
        setFile(event.getFile());
    }
    
    @FacesConverter(forClass = ProductoDTO.class)
    public static class ProductoControllerConverter implements Converter {
        
        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            ProductoController controller = (ProductoController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "productoController");
            return controller.getProducto(getKey(value));
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
            if (object instanceof ProductoDTO) {
                ProductoDTO o = (ProductoDTO) object;
                return getStringKey(o.getIdProducto());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), ProductoDTO.class.getName()});
                return null;
            }
        }
        
    }
    
}
