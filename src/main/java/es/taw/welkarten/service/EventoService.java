package es.taw.welkarten.service;

import es.taw.welkarten.dao.EtiquetaRepository;
import es.taw.welkarten.dao.EtiquetaseventoRepository;
import es.taw.welkarten.dao.EventoRepository;
import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.*;
import es.taw.welkarten.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

@Service
public class EventoService {
    private EventoRepository eventoRepository;
    private EtiquetaseventoRepository etiquetaseventoRepository;
    private EtiquetaRepository etiquetaRepository;
    private UsuarioRepository usuarioRepository;

    @Autowired
    public void setEtiquetaRepository(EtiquetaRepository etiquetaRepository) {
        this.etiquetaRepository = etiquetaRepository;
    }

    @Autowired
    public void setEventoRepository(EventoRepository eventoRepository) {
        this.eventoRepository = eventoRepository;
    }

    @Autowired
    public void setEtiquetaseventoRepository(EtiquetaseventoRepository etiquetaseventoRepository) {
        this.etiquetaseventoRepository = etiquetaseventoRepository;
    }

    @Autowired
    public void setUsuarioRepository(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public List<EventoDTO> findEventos(){
        List<EventoDTO> eventosDTO = new ArrayList<>();
        List<Evento> eventos = this.eventoRepository.findAll();
        for (Evento event : eventos) {
            eventosDTO.add(event.getDTOfechaString());
        }
        return eventosDTO;
    }

    public EventoDTO findEvento(Integer id){
        Optional<Evento> evento = this.eventoRepository.findById(id);
        if (evento.isPresent()){
            return evento.get().getDTO();
        }
        return null;
    }

    public List<EventoDTO> findEventosNoCaducados(){
        List<Evento> listaEventos = this.eventoRepository.findByEventosNoCaducados(new Date(), new Time(Calendar.getInstance().getTime().getTime()));
        return convertirAListaDTO(listaEventos);
    }

    public List<EventoDTO> findEventosHoy(){
        List<Evento> listaEventos = this.eventoRepository.findByEventosHoy(new Date());
        return convertirAListaDTO(listaEventos);
    }

    public List<EventoDTO> findEventosEstaSemana(){
        Date fechaHoy = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(fechaHoy);
        c.add(Calendar.DATE, 7);
        Date fechaSemana = c.getTime();
        List<Evento> listaEventos = this.eventoRepository.findByEventosEstaSemana(fechaHoy, fechaSemana);
        return convertirAListaDTO(listaEventos);
    }


    public List<EventoDTO> findByCreador(Integer id){
        List<Evento> eventosDelCreador = this.eventoRepository.findByCreadorEventos(id);
        return convertirAListaDTO(eventosDelCreador);
    }

    private List<EventoDTO> convertirAListaDTO(List<Evento> lista){
        if(lista != null) {
            List<EventoDTO> listaDTO = new ArrayList<>();
            for(Evento e : lista) {
                listaDTO.add(e.getDTO());
            }
            return listaDTO;
        } else  {
            return null;
        }
    }




    public EventoDTO buscarEvento (Integer id) {
        Evento cliente = this.eventoRepository.findById(id).orElse(null);
        if (cliente != null) {
            return cliente.getDTO();
        } else {
            return null;
        }
    }


    public void guardarEvento (EventoDTO dto, UsuarioDTO creador) {
        Usuario usuario = this.usuarioRepository.findById(creador.getId()).get();
        Evento evento = new Evento();
        if (dto.getId() == null) {
            evento.setId(0);
        } else {
            evento = this.eventoRepository.findById(dto.getId()).orElse(new Evento());
        }

        evento.setAforo(dto.getAforo());
        if(dto.getSeleccionAsientos().equals("N")){
            evento.setAsientosFila(null);
            evento.setFilas(null);
        } else {
            evento.setAsientosFila(dto.getAsientosFila());
            evento.setFilas(dto.getFilas());
        }


        evento.setDescripcion(dto.getDescripcion());
        evento.setCosteEntrada(dto.getCosteEntrada());
        evento.setEntradaList(new ArrayList<>()); // no hay entradas compradas aun
        evento.setEntradasMax(dto.getEntradasMax());

        DateFormat formateo = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date fechaInicio = formateo.parse(dto.getFechaInicioString());
            evento.setFechaInicio(fechaInicio);

            Date fechaReserva = formateo.parse(dto.getFechaReservaString());
            evento.setFechaReserva(fechaReserva);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        evento.setTitulo(dto.getTitulo());

        SimpleDateFormat formatoHora = new SimpleDateFormat("HH:mm");
        try {
            evento.setHora(formatoHora.parse(dto.getHoraString()));
        } catch (ParseException e) {
            e.printStackTrace();
        }

        evento.setLugar(dto.getLugar());
        evento.setCreador(usuario);

        this.eventoRepository.save(evento);

        Evento eventoExtraido;
        if (dto.getId() == null) {
            Integer maxId = this.eventoRepository.findMaxId();
            eventoExtraido = this.eventoRepository.findById(maxId).get();
        } else {
            eventoExtraido = this.eventoRepository.findById(dto.getId()).get();
        }

        List<Etiquetasevento> etiquetaseventos = new ArrayList<>();
        for(String etq : dto.getEtiquetas()){
            Etiquetasevento etiqueta = new Etiquetasevento();
            etiqueta.setEtiqueta(etiquetaRepository.findByNombre(etq));
            etiqueta.setEvento(eventoExtraido);
            etiqueta.setId(0);
            this.etiquetaseventoRepository.save(etiqueta);
            etiquetaseventos.add(etiqueta);
        }
        evento.setEtiquetaseventoList(etiquetaseventos);

        this.eventoRepository.save(eventoExtraido);
    }


    public EventoDTO getEventoDTO(Integer id) {
        Evento evt = this.eventoRepository.findById(id).get();
        return evt.getDTOfechaString();
    }

    public void eliminarEvento(Integer id) {
        Evento evt = this.eventoRepository.findById(id).get();
        for(Etiquetasevento etiquetasevento : evt.getEtiquetaseventoList()){
            this.etiquetaseventoRepository.delete(etiquetasevento);
        }
        this.eventoRepository.delete(evt);
    }
}
