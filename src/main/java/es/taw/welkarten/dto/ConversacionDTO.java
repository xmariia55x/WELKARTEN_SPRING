package es.taw.welkarten.dto;

import java.util.List;

public class ConversacionDTO {
    Integer id;
    UsuarioDTO teleoperador;
    UsuarioDTO usuario;
    List<MensajeDTO> mensaje;

    public ConversacionDTO() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public UsuarioDTO getTeleoperador() {
        return teleoperador;
    }

    public void setTeleoperador(UsuarioDTO teleoperador) {
        this.teleoperador = teleoperador;
    }

    public UsuarioDTO getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioDTO usuario) {
        this.usuario = usuario;
    }

    public List<MensajeDTO> getMensaje() {
        return mensaje;
    }

    public void setMensaje(List<MensajeDTO> mensaje) {
        this.mensaje = mensaje;
    }
}
