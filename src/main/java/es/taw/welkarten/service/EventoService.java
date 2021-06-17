package es.taw.welkarten.service;

import es.taw.welkarten.dao.EventoRepository;
import es.taw.welkarten.entity.Evento;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventoService {
    private EventoRepository eventoRepository;

    @Autowired
    public void setEventoRepository(EventoRepository eventoRepository) {
        this.eventoRepository = eventoRepository;
    }

    public List<Evento> findEventos(){
        return this.eventoRepository.findAll();
    }
}
