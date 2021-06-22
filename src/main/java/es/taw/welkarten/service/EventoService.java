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



    public List<Evento> findEventos(){
        return this.eventoRepository.findAll();
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

    public EventoDTO buscarEvento (Integer id) {
        Evento evento = this.eventoRepository.findById(id).orElse(null);
        if (evento != null) {
            return evento.getDTO();
        } else {
            return null;
        }
    }


    public void guardarEvento (EventoDTO dto) {

        Evento cliente;
        if (dto.getId() == null) {
            cliente = new Evento();
        } else {
            cliente = this.eventoRepository.findById(dto.getId()).orElse(new Evento());
        }

        cliente.setCustomerId(dto.getCustomerId());
        cliente.setName(dto.getName());
        cliente.setEmail(dto.getEmail());
        cliente.setAddressline1(dto.getAddressline1());
        cliente.setAddressline2(dto.getAddressline2());

        MicroMarket mm = this.microMarketRepository.findById(dto.getZipCodeMicroMarket()).orElse(null);
        cliente.setMicroMarketByZip(mm);

        DiscountCode dc = this.discountCodeRepository.findById(dto.getDiscountCode()).orElse(null);
        cliente.setDiscountCodeByDiscountCode(dc);

        this.customerRepository.save(cliente);
    }
}
