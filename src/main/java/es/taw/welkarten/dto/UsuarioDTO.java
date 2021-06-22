package es.taw.welkarten.dto;

import es.taw.welkarten.entity.*;

import java.util.List;

public class UsuarioDTO {
    private Integer id;
    private String nombre;
    private String nif;
    private String correo;
    private String password;
    private int rol;
    private UsuarioeventosDTO usuarioeventos;
    private String contraseniaRepetida;
    public UsuarioDTO() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRol() {
        return rol;
    }

    public void setRol(int rol) {
        this.rol = rol;
    }

    public String getContraseniaRepetida() {
        return contraseniaRepetida;
    }

    public void setContraseniaRepetida(String contraseniaRepetida) {
        this.contraseniaRepetida = contraseniaRepetida;
    }

    public UsuarioeventosDTO getUsuarioeventos() {
        return usuarioeventos;
    }

    public void setUsuarioeventos(UsuarioeventosDTO usuarioeventos) {
        this.usuarioeventos = usuarioeventos;
    }
}
