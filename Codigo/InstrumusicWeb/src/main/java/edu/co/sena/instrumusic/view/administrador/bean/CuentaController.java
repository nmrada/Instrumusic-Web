package edu.co.sena.instrumusic.view.administrador.bean;

import edu.co.sena.instrumusic.model.entities.Cuenta;
import edu.co.sena.instrumusic.view.general.util.JsfUtil;
import edu.co.sena.instrumusic.view.general.util.JsfUtil.PersistAction;
import edu.co.sena.instrumusic.controller.administrador.beans.CuentaFacade;
import edu.co.sena.instrumusic.controller.administrador.beans.DepartamentoFacade;
import edu.co.sena.instrumusic.controller.administrador.beans.MunicipioFacade;
import edu.co.sena.instrumusic.controller.administrador.dto.CuentaDTO;
import edu.co.sena.instrumusic.general.utils.ConversorDTO;
import edu.co.sena.instrumusic.model.entities.CuentaPK;
import edu.co.sena.instrumusic.model.entities.Departamento;
import edu.co.sena.instrumusic.model.entities.DomicilioCuenta;
import edu.co.sena.instrumusic.model.entities.DomicilioCuentaPK;
import edu.co.sena.instrumusic.model.entities.Municipio;

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

@Named("cuentaController")
@SessionScoped
public class CuentaController implements Serializable {

    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.CuentaFacade ejbFacade;
    
    @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.DepartamentoFacade ejbFacadeDepartamento;
    
     @EJB
    private edu.co.sena.instrumusic.controller.administrador.beans.MunicipioFacade ejbFacadeMunicipio;
    private List<Cuenta> items = null;
    private List<Departamento> itemsDepartamentos = null;
    private List<Municipio> itemsMunicipio = null;
    private Cuenta selected;
    private CuentaDTO selectedDTO;
    private String departamentoSeleccionado;
    private DomicilioCuenta domicilio;
    
    
    //Atributos creados para buscar cuenta.getDomicilio().setTipodocumentotipodocumento()
    private List<Cuenta> itemsBuscados = null;
    private Cuenta selectedBuscados;
    private String tipBuscar;
    private String numBuscar;
    private String nombreBuscar;
    
    private String municipioCrear;
    

    public CuentaController() {
        domicilio= new DomicilioCuenta();
        domicilio.setDomicilioCuentaPK(new DomicilioCuentaPK());
    }
    public void obtenedorDepartamentos() {
        if(itemsDepartamentos == null){
             itemsDepartamentos = getFacadeDepartamento().findAll();
        }   
    }
    
    public void obtenedorMunicipios() {
          Departamento dt = getFacadeDepartamento().findByNombreCompleto(departamentoSeleccionado);
          itemsMunicipio = dt.getMunicipioList();
    }
    
    public void obtenedorMunicipioCrear() {
          Municipio dt = getFacadeMunicipio().findByNombreCompleto(municipioCrear);
          selectedDTO.setMunicipio(dt);
    }

    public Cuenta getSelected() {
        return selected;
    }

    public void setSelected(Cuenta selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
        //selected.getCuentaPK().setTipoDocumentotipoDocumento(selected.getTipoDocumento().getTipoDocumento());
    }

    protected void initializeEmbeddableKey() {
        selected.setCuentaPK(new edu.co.sena.instrumusic.model.entities.CuentaPK());
    }

    private CuentaFacade getFacade() {
        return ejbFacade;
    }
    
    private DepartamentoFacade getFacadeDepartamento() {
        return ejbFacadeDepartamento;
    }
    
    private MunicipioFacade getFacadeMunicipio() {
        return ejbFacadeMunicipio;
    }

    public Cuenta prepareCreate() {
        selected = new Cuenta();
        selectedDTO = new CuentaDTO();
        selected.setDomicilioCuenta(new DomicilioCuenta(new DomicilioCuentaPK()));
        initializeEmbeddableKey();
        obtenedorDepartamentos();
        return selected;
    }

    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("CuentaCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("CuentaUpdated"));
        selectedBuscados = null;
        itemsBuscados = null;
    }
    public void updateBuscar() {
        persist(PersistAction.UPDATEBUSCAR, ResourceBundle.getBundle("/Bundle").getString("CuentaUpdated"));
        selected = null;
        items = null;
    }

    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("CuentaDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
        itemsBuscados = null;
        selectedBuscados = null;
    }
    public void eliminarBuscados() {
        persist(PersistAction.DELETEBUSCAR, ResourceBundle.getBundle("/Bundle").getString("CuentaDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
        itemsBuscados = null;
        selectedBuscados = null;
    }

    public List<Cuenta> getItems() {
        if (items == null) {
            items = getFacade().findAll();
        }
        return items;
    }
    
    public List<Cuenta> buscarPorLlavePrim() {
        itemsBuscados = getFacade().findByLlavePrimaria(tipBuscar, numBuscar);
        nombreBuscar = null;        
        return items;
    }

    private void persist(PersistAction persistAction, String successMessage) {
        
        if (selectedDTO != null) {
            setEmbeddableKeys();
            obtenedorMunicipioCrear();
            try {
                if (persistAction != PersistAction.DELETE) {
                    getFacade().edit(ConversorDTO.conversorCuentaDTOaCuenta(selectedDTO));
                } else {
                    getFacade().remove(ConversorDTO.conversorCuentaDTOaCuenta(selectedDTO));
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

    public Cuenta getCuenta(edu.co.sena.instrumusic.model.entities.CuentaPK id) {
        return getFacade().find(id);
    }

    public List<Cuenta> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<Cuenta> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    public List<Departamento> getItemsDepartamentos() {
        return itemsDepartamentos;
    }

    public void setItemsDepartamentos(List<Departamento> itemsDepartamentos) {
        this.itemsDepartamentos = itemsDepartamentos;
    }

    public List<Municipio> getItemsMunicipio() {
        return itemsMunicipio;
    }

    public void setItemsMunicipio(List<Municipio> itemsMunicipio) {
        this.itemsMunicipio = itemsMunicipio;
    }

    public String getDepartamentoSeleccionado() {
        return departamentoSeleccionado;
    }

    public void setDepartamentoSeleccionado(String departamentoSeleccionado) {
        this.departamentoSeleccionado = departamentoSeleccionado;
    }

    public DomicilioCuenta getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(DomicilioCuenta domicilio) {
        this.domicilio = domicilio;
    }

    public CuentaDTO getSelectedDTO() {
        return selectedDTO;
    }

    public void setSelectedDTO(CuentaDTO selectedDTO) {
        this.selectedDTO = selectedDTO;
    }

    public String getMunicipioCrear() {
        return municipioCrear;
    }

    public void setMunicipioCrear(String municipioCrear) {
        this.municipioCrear = municipioCrear;
    }

    @FacesConverter(forClass = Cuenta.class)
    public static class CuentaControllerConverter implements Converter {

        private static final String SEPARATOR = "#";
        private static final String SEPARATOR_ESCAPED = "\\#";

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            CuentaController controller = (CuentaController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "cuentaController");
            return controller.getCuenta(getKey(value));
        }

        edu.co.sena.instrumusic.model.entities.CuentaPK getKey(String value) {
            edu.co.sena.instrumusic.model.entities.CuentaPK key;
            String values[] = value.split(SEPARATOR_ESCAPED);
            key = new edu.co.sena.instrumusic.model.entities.CuentaPK();
            key.setTipoDocumentotipoDocumento(values[0]);
            key.setNumeroDocumento(values[1]);
            return key;
        }

        String getStringKey(edu.co.sena.instrumusic.model.entities.CuentaPK value) {
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
            if (object instanceof Cuenta) {
                Cuenta o = (Cuenta) object;
                return getStringKey(o.getCuentaPK());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), Cuenta.class.getName()});
                return null;
            }
        }

    }

}
