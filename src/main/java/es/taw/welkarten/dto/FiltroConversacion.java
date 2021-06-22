package es.taw.welkarten.dto;

public class FiltroConversacion {
    private String teleoperador;
    private String usuario;

    public FiltroConversacion() {
        this.teleoperador = "";
        this.usuario = "";
    }

    public String getTeleoperador() {
        return teleoperador;
    }

    public void setTeleoperador(String teleoperador) {
        this.teleoperador = teleoperador;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }
}
