package es.taw.welkarten.dto;

import java.util.ArrayList;
import java.util.List;

public class FiltroUsuariosDTO {
    private String nombreUsuario;
    private List<String> roles;
    private List<String> rolesSeleccionados;
    private List<UsuarioDTO> usuariosFiltrados;

    public FiltroUsuariosDTO(){
        nombreUsuario = "";
        rolesSeleccionados = new ArrayList<>();
        usuariosFiltrados = new ArrayList<>();
    }
    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public List<String> getRoles() {
        return roles;
    }

    public void setRoles(List<String> roles) {
        this.roles = roles;
    }

    public List<String> getRolesSeleccionados() {
        return rolesSeleccionados;
    }

    public void setRolesSeleccionados(List<String> rolesSeleccionados) {
        this.rolesSeleccionados = rolesSeleccionados;
    }

    public List<UsuarioDTO> getUsuariosFiltrados() {
        return usuariosFiltrados;
    }

    public void setUsuariosFiltrados(List<UsuarioDTO> usuariosFiltrados) {
        this.usuariosFiltrados = usuariosFiltrados;
    }

    public boolean isEmpty(){
       return usuariosFiltrados == null || usuariosFiltrados.isEmpty() ;
    }
}
