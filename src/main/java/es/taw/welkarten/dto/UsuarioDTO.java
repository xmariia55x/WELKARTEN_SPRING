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
    private List<Conversacion> conversacionList;
    private List<Conversacion> conversacionList1;
    private Usuarioeventos usuarioeventos;
    private List<Entrada> entradaList;
    private List<Estudio> estudioList;
    private List<Evento> eventoList;
    private List<Mensaje> mensajeList;
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

    public List<Conversacion> getConversacionList() {
        return conversacionList;
    }

    public void setConversacionList(List<Conversacion> conversacionList) {
        this.conversacionList = conversacionList;
    }

    public List<Conversacion> getConversacionList1() {
        return conversacionList1;
    }

    public void setConversacionList1(List<Conversacion> conversacionList1) {
        this.conversacionList1 = conversacionList1;
    }

    public Usuarioeventos getUsuarioeventos() {
        return usuarioeventos;
    }

    public void setUsuarioeventos(Usuarioeventos usuarioeventos) {
        this.usuarioeventos = usuarioeventos;
    }

    public List<Entrada> getEntradaList() {
        return entradaList;
    }

    public void setEntradaList(List<Entrada> entradaList) {
        this.entradaList = entradaList;
    }

    public List<Estudio> getEstudioList() {
        return estudioList;
    }

    public void setEstudioList(List<Estudio> estudioList) {
        this.estudioList = estudioList;
    }

    public List<Evento> getEventoList() {
        return eventoList;
    }

    public void setEventoList(List<Evento> eventoList) {
        this.eventoList = eventoList;
    }

    public List<Mensaje> getMensajeList() {
        return mensajeList;
    }

    public void setMensajeList(List<Mensaje> mensajeList) {
        this.mensajeList = mensajeList;
    }

    public String getContraseniaRepetida() {
        return contraseniaRepetida;
    }

    public void setContraseniaRepetida(String contraseniaRepetida) {
        this.contraseniaRepetida = contraseniaRepetida;
    }
}
