package es.taw.welkarten.dto;


import java.util.List;

public class EtiquetaDTO {
    private Integer id;
    private String nombre;
    private List<EtiquetaseventoDTO> etiquetaseventoList;

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


    public List<EtiquetaseventoDTO> getEtiquetaseventoList() {
        return etiquetaseventoList;
    }

    public void setEtiquetaseventoList(List<EtiquetaseventoDTO> etiquetaseventoList) {
        this.etiquetaseventoList = etiquetaseventoList;
    }
}
