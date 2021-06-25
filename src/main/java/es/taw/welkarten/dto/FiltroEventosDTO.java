package es.taw.welkarten.dto;

import java.util.ArrayList;
import java.util.List;

public class FiltroEventosDTO {
    private String nombreEvento;
    private List<String> etiquetas;
    private List<String> etiquetasSeleccionadas;
    private List<EventoDTO> eventosFiltrados;
    public FiltroEventosDTO(){
        nombreEvento = "";
        etiquetasSeleccionadas = new ArrayList<>();
        eventosFiltrados = new ArrayList<>();
    }
    public String getNombreEvento() {
        return nombreEvento;
    }

    public void setNombreEvento(String nombreEvento) {
        this.nombreEvento = nombreEvento;
    }

    public List<String> getEtiquetas() {
        return etiquetas;
    }

    public void setEtiquetas(List<String> etiquetas) {
        this.etiquetas = etiquetas;
    }

    public List<EventoDTO> getEventosFiltrados() {
        return eventosFiltrados;
    }

    public void setEventosFiltrados(List<EventoDTO> eventosFiltrados) {
        this.eventosFiltrados = eventosFiltrados;
    }

    public List<String> getEtiquetasSeleccionadas() {
        return etiquetasSeleccionadas;
    }

    public void setEtiquetasSeleccionadas(List<String> etiquetasSeleccionadas) {
        this.etiquetasSeleccionadas = etiquetasSeleccionadas;
    }

    public boolean isEmpty(){
        return eventosFiltrados == null || eventosFiltrados.isEmpty() ;
    }
}
