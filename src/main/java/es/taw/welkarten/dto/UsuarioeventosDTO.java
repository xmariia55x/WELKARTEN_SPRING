package es.taw.welkarten.dto;

import es.taw.welkarten.entity.Usuario;

import java.util.Date;

public class UsuarioeventosDTO {
    private Integer id;
    private String apellidos;
    private String domicilio;
    private String ciudad;
    private Date fechaNacimiento;
    private String sexo;
    private UsuarioDTO usuario;
    private String contraseniaRepetida;

    public UsuarioeventosDTO() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }


    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getContraseniaRepetida() {
        return contraseniaRepetida;
    }

    public void setContraseniaRepetida(String contraseniaRepetida) {
        this.contraseniaRepetida = contraseniaRepetida;
    }

    public UsuarioDTO getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioDTO usuario) {
        this.usuario = usuario;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public Date getFechaNacimiento(){
        return fechaNacimiento;
    }
}
