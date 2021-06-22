package es.taw.welkarten.dto;

public class BusquedaAvanzadaEvento {

        private Integer aforo;
        private Double precio;
        private String nombre;
        private Integer creador;

        public BusquedaAvanzadaEvento() {
            this.aforo = null;
            this.precio=null;
            this.nombre=null;
            this.creador =null;
        }



    public Integer getAforo() {
        return aforo;
    }

    public void setAforo(Integer aforo) {
        this.aforo = aforo;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getCreador() {
        return creador;
    }

    public void setCreador(Integer creador) {
        this.creador = creador;
    }
}

