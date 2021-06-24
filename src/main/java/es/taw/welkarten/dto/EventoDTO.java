package es.taw.welkarten.dto;

import es.taw.welkarten.entity.*;

import javax.persistence.Basic;
import es.taw.welkarten.entity.Etiquetasevento;
import es.taw.welkarten.entity.Usuario;

import java.util.Date;
import java.util.List;

public class EventoDTO {

    private Integer id;
    private String titulo;
    private String descripcion;
    private String fechaInicioString;
    private String fechaReservaString;
    private Date fechaInicio;
    private Date fechaReserva;
    private double costeEntrada;
    private int aforo;
    private int entradasMax;
    private Integer filas;
    private Integer asientosFila;
    private String horaString;
    private Date hora;
    private String lugar;
    private List<EtiquetaseventoDTO> etiquetaseventoList;
    private List<String> etiquetas;
    private Usuario creador;
    private String seleccionAsientos;

    //private String seleccionAsientos;
    private List<EntradaDTO> entradaList;

    public EventoDTO(){

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }


    public double getCosteEntrada() {
        return costeEntrada;
    }

    public void setCosteEntrada(double costeEntrada) {
        this.costeEntrada = costeEntrada;
    }

    public int getAforo() {
        return aforo;
    }

    public void setAforo(int aforo) {
        this.aforo = aforo;
    }

    public int getEntradasMax() {
        return entradasMax;
    }

    public void setEntradasMax(int entradasMax) {
        this.entradasMax = entradasMax;
    }

    public Integer getFilas() {
        return filas;
    }

    public void setFilas(Integer filas) {
        this.filas = filas;
    }

    public Integer getAsientosFila() {
        return asientosFila;
    }

    public void setAsientosFila(Integer asientosFila) {
        this.asientosFila = asientosFila;
    }


    public String getLugar() {
        return lugar;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
    }

    public Usuario getCreador() {
        return creador;
    }

    public void setCreador(Usuario creador) {
        this.creador = creador;
    }

    /* COMENTADO POR YERAY: ESTO PARA QUE? NO ESTA EN LA ENTIDAD */
    public String getSeleccionAsientos() {
        return seleccionAsientos;
    }

    public void setSeleccionAsientos(String seleccionAsientos) {
        this.seleccionAsientos = seleccionAsientos;
    }


    public List<EtiquetaseventoDTO> getEtiquetaseventoList() {
        return etiquetaseventoList;
    }

    public void setEtiquetaseventoList(List<EtiquetaseventoDTO> etiquetaseventoList) {
        this.etiquetaseventoList = etiquetaseventoList;
    }

    public List<EntradaDTO> getEntradaList() {
        return entradaList;
    }

    public void setEntradaList(List<EntradaDTO> entradaList) {
        this.entradaList = entradaList;
    }

    public String getFechaInicioString() {
        return fechaInicioString;
    }

    public void setFechaInicioString(String fechaInicioString) {
        this.fechaInicioString = fechaInicioString;
    }

    public String getFechaReservaString() {
        return fechaReservaString;
    }

    public void setFechaReservaString(String fechaReservaString) {
        this.fechaReservaString = fechaReservaString;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaReserva() {
        return fechaReserva;
    }

    public void setFechaReserva(Date fechaReserva) {
        this.fechaReserva = fechaReserva;
    }

    public String getHoraString() {
        return horaString;
    }

    public void setHoraString(String horaString) {
        this.horaString = horaString;
    }

    public Date getHora() {
        return hora;
    }

    public void setHora(Date hora) {
        this.hora = hora;
    }

    public List<String> getEtiquetas() {
        return etiquetas;
    }

    public void setEtiquetas(List<String> etiquetas) {
        this.etiquetas = etiquetas;
    }
}
