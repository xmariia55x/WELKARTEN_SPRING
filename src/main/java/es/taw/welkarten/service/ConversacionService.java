package es.taw.welkarten.service;

import es.taw.welkarten.dao.ConversacionRepository;
import es.taw.welkarten.entity.Conversacion;
import es.taw.welkarten.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConversacionService {
    private ConversacionRepository conversacionRepository;

    public ConversacionRepository getConversacionRepository() {
        return conversacionRepository;
    }

    @Autowired
    public void setConversacionRepository(ConversacionRepository conversacionRepository) {
        this.conversacionRepository = conversacionRepository;
    }

    public List<Conversacion> findConversaciones() {
        List<Conversacion> conversaciones = this.conversacionRepository.findAll();
        return conversaciones;
    }


    public List<Conversacion> findPeticiones(Usuario usuario) {
        List<Conversacion> peticiones = this.conversacionRepository.findPeticionesTeleoperador(usuario.getId());
        return peticiones;
    }
}
