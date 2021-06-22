package es.taw.welkarten.service;

import es.taw.welkarten.dao.EventoRepository;
import es.taw.welkarten.dto.EventoDTO;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class EventoService {
    private EventoRepository eventoRepository;

    @Autowired
    public void setEventoRepository(EventoRepository eventoRepository) {
        this.eventoRepository = eventoRepository;
    }

    public List<EventoDTO> findEventos(){
        List<EventoDTO> eventosDTO = new ArrayList<>();
        List<Evento> eventos = this.eventoRepository.findAll();
        for(Evento event : eventos){
            eventosDTO.add(event.getDTO());
        }
        return eventosDTO;
    }

    public List<Evento> findEventosNoCaducados(){
        return this.eventoRepository.findByEventosNoCaducados(new Date(), new Time(Calendar.getInstance().getTime().getTime()));
    }

    public List<Evento> findEventosHoy(){
        return this.eventoRepository.findByEventosHoy(new Date());
    }

    public List<Evento> findEventosCreadorEventos(Integer idcreador){ return this.eventoRepository.findByCreadorEventos(idcreador); }


    public List<Evento> findEventosEstaSemana(){
        Date fechaHoy = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(fechaHoy);
        c.add(Calendar.DATE, 7);
        Date fechaSemana = c.getTime();
        return this.eventoRepository.findByEventosEstaSemana(fechaHoy, fechaSemana);
    }
}
