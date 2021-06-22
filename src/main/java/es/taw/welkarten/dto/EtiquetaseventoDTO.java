package es.taw.welkarten.dto;


public class EtiquetaseventoDTO {
    private Integer id;
    private EtiquetaDTO etiqueta;
    private EventoDTO evento;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public EtiquetaDTO getEtiqueta() {
        return etiqueta;
    }

    public void setEtiqueta(EtiquetaDTO etiqueta) {
        this.etiqueta = etiqueta;
    }

    public EventoDTO getEvento() {
        return evento;
    }

    public void setEvento(EventoDTO evento) {
        this.evento = evento;
    }
}
