package es.taw.welkarten.service;


import es.taw.welkarten.dao.EventoRepository;
import es.taw.welkarten.dto.EventoDTO;
import es.taw.welkarten.entity.Evento;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;



@Service
public class BusquedaAvanzadaService {



    private EventoRepository eventoRepository;

    @Autowired
    public void setEventoRepository(EventoRepository eventoRepository) {
        this.eventoRepository = eventoRepository;
    }

    public List<EventoDTO> findByBusquedaAvanzada(String nombre, Integer aforo, Double precio, Integer creador) {

        List<Evento> eventosFiltrados = this.eventoRepository.findAll();
        List<Evento> eliminados = new ArrayList();


        if(nombre != null){ // filtro de nombre
            for(Evento e : eventosFiltrados){
                if(!e.getTitulo().contains(nombre)){
                   eliminados.add(e);
                }
            }
        }

        for(Evento e : eliminados){
            eventosFiltrados.remove(e);
            }
        eliminados = new ArrayList();

        if(aforo != null){ // filtro aforo
            for(Evento e : eventosFiltrados){
                if(e.getAforo() > aforo){
                    eliminados.add(e);
                }
            }
        }

        for(Evento e : eliminados){
            eventosFiltrados.remove(e);
        }
        eliminados = new ArrayList();

        if(precio != null){ // filtro precio
            for(Evento e : eventosFiltrados){
                if(e.getCosteEntrada() > precio){
                    eliminados.add(e);
                }
            }
        }

        for(Evento e : eliminados){
            eventosFiltrados.remove(e);
        }
        eliminados = new ArrayList();

        if(creador != null){ // filtro creador
            for(Evento e : eventosFiltrados){
                if(e.getCreador().getId() != creador){
                    eliminados.add(e);
                }
            }
        }

        for(Evento e : eliminados){
            eventosFiltrados.remove(e);
        }
        eliminados = new ArrayList();

        return convertirAListaDTO(eventosFiltrados);

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

}
