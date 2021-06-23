package es.taw.welkarten.service;

import es.taw.welkarten.dao.ConversacionRepository;
import es.taw.welkarten.dao.MensajeRepository;
import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.ConversacionDTO;
import es.taw.welkarten.dto.MensajeDTO;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.Conversacion;
import es.taw.welkarten.entity.Mensaje;
import es.taw.welkarten.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class ConversacionService {
    private ConversacionRepository conversacionRepository;
    private MensajeRepository mensajeRepository;
    private UsuarioRepository usuarioRepository;

    public UsuarioRepository getUsuarioRepository() {
        return usuarioRepository;
    }

    @Autowired
    public void setUsuarioRepository(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

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

    public List<ConversacionDTO> findConversaciones(String filtroTeleoperador, String filtroUsuario) {
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
        return this.convertirAListaDTO(conversaciones);
    }


    public List<ConversacionDTO> findPeticionesTeleoperador(UsuarioDTO usuario) {
        List<Conversacion> peticiones = this.conversacionRepository.findPeticionesTeleoperador(usuario.getId());
        return this.convertirAListaDTO(peticiones);
    }

    public List<ConversacionDTO> findPeticionesUsuario(UsuarioDTO usuario) {
        List<Conversacion> peticiones = this.conversacionRepository.findPeticionesUsuario(usuario.getId());
        return this.convertirAListaDTO(peticiones);
    }

    public ConversacionDTO findConversacion(Integer id) {
        Optional<Conversacion> optConversacion = this.conversacionRepository.findById(id);
        return optConversacion.get().getDTO();
    }

    public void eliminarConversacion(Integer id) {
        Optional<Conversacion> optConversacion = this.conversacionRepository.findById(id);
        if(optConversacion.isPresent()) {
            Conversacion c = optConversacion.get();
            this.conversacionRepository.delete(c);
        }
    }

    public void iniciarConversacion(Integer id, UsuarioDTO usuario) {
        Optional<Conversacion> optConversacion = this.conversacionRepository.findById(id);
        Optional<Usuario> optUsuario = this.usuarioRepository.findById(usuario.getId());
        if(optConversacion.isPresent() && optUsuario.isPresent()) {
            Conversacion c = optConversacion.get();
            Mensaje m = new Mensaje();
            m.setConversacion(c);
            m.setCuerpo("Buenas, le atiene un teleoperador de Welkarten");
            m.setEmisor(optUsuario.get());
            m.setFecha(new Date());
            m.setHora(new Date());
            this.mensajeRepository.save(m);

            c.getMensajeList().add(m);
            this.conversacionRepository.save(c);
        }
    }

    public void guardarMensaje(Integer idConversacion, Integer idUsuario, String cuerpo) {
        Mensaje m = new Mensaje();
        Conversacion conversacion = this.conversacionRepository.findById(idConversacion).get();
        Usuario usuario = this.usuarioRepository.findById(idUsuario).get();

        m.setConversacion(conversacion);
        m.setCuerpo(cuerpo);
        m.setEmisor(usuario);
        m.setFecha(new Date());
        m.setHora(new Date());

        this.mensajeRepository.save(m);

        conversacion.getMensajeList().add(m);
        this.conversacionRepository.save(conversacion);
    }

    public List<ConversacionDTO> convertirAListaDTO(List<Conversacion> lista) {
        if(lista != null) {
            List<ConversacionDTO> listaDTO = new ArrayList<>();
            for(Conversacion c : lista) {
                listaDTO.add(c.getDTO());
            }
            return listaDTO;
        } else  {
            return null;
        }

    }
}
