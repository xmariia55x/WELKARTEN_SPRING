package es.taw.welkarten.service;

import es.taw.welkarten.dao.ConversacionRepository;
import es.taw.welkarten.dao.MensajeRepository;
import es.taw.welkarten.entity.Conversacion;
import es.taw.welkarten.entity.Mensaje;
import es.taw.welkarten.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class ConversacionService {
    private ConversacionRepository conversacionRepository;
    private MensajeRepository mensajeRepository;

    public MensajeRepository getMensajeRepository() {
        return mensajeRepository;
    }

    @Autowired
    public void setMensajeRepository(MensajeRepository mensajeRepository) {
        this.mensajeRepository = mensajeRepository;
    }

    public ConversacionRepository getConversacionRepository() {
        return conversacionRepository;
    }

    @Autowired
    public void setConversacionRepository(ConversacionRepository conversacionRepository) {
        this.conversacionRepository = conversacionRepository;
    }

    public List<Conversacion> findConversaciones(String filtroTeleoperador, String filtroUsuario) {
        List<Conversacion> conversaciones;
        if(filtroTeleoperador != null && filtroTeleoperador.length() > 0 && filtroUsuario != null && filtroUsuario.length() > 0) {
            conversaciones = this.conversacionRepository.findConversacionesByTeleoperadorAndUsuario(filtroTeleoperador, filtroUsuario);
        } else if(filtroTeleoperador != null && filtroTeleoperador.length() > 0) {
            conversaciones = this.conversacionRepository.findConversacionesByTeleoperador(filtroTeleoperador);
        } else if(filtroUsuario != null && filtroUsuario.length() > 0) {
            conversaciones = this.conversacionRepository.findConversacionesByUsuario(filtroUsuario);
        } else {
            conversaciones = this.conversacionRepository.findAll();
        }
        return conversaciones;
    }


    public List<Conversacion> findPeticionesTeleoperador(Usuario usuario) {
        List<Conversacion> peticiones = this.conversacionRepository.findPeticionesTeleoperador(usuario.getId());
        return peticiones;
    }

    public List<Conversacion> findPeticionesUsuario(Usuario usuario) {
        List<Conversacion> peticiones = this.conversacionRepository.findPeticionesUsuario(usuario.getId());
        return peticiones;
    }

    public Conversacion findConversacion(Integer id) {
        Optional<Conversacion> optConversacion = this.conversacionRepository.findById(id);
        return optConversacion.get();
    }

    public void eliminarConversacion(Integer id) {
        Optional<Conversacion> optConversacion = this.conversacionRepository.findById(id);
        if(optConversacion.isPresent()) {
            Conversacion c = optConversacion.get();
            this.conversacionRepository.delete(c);
        }
    }

    public void iniciarConversacion(Integer id, Usuario usuario) {
        Optional<Conversacion> optConversacion = this.conversacionRepository.findById(id);
        if(optConversacion.isPresent()) {
            Conversacion c = optConversacion.get();
            Mensaje m = new Mensaje();
            m.setConversacion(c);
            m.setCuerpo("Buenas, le atiene un teleoperador de Welkarten");
            m.setEmisor(usuario);
            m.setFecha(new Date());
            m.setHora(new Date());
            this.mensajeRepository.save(m);

            c.getMensajeList().add(m);
            this.conversacionRepository.save(c);
        }
    }
}
