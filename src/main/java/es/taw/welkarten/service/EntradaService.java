package es.taw.welkarten.service;

import es.taw.welkarten.dao.EntradaRepository;
import es.taw.welkarten.dao.EventoRepository;
import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.EntradaDTO;
import es.taw.welkarten.dto.EventoDTO;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.Entrada;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class EntradaService {
    private EntradaRepository entradaRepository;
    private UsuarioRepository usuarioRepository;
    private EventoRepository eventoRepository;

    @Autowired
    public void setUsuarioRepository(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Autowired
    public void setEventoRepository(EventoRepository eventoRepository) {
        this.eventoRepository = eventoRepository;
    }

    @Autowired
    public void setEntradaRepository(EntradaRepository entradaRepository) {
        this.entradaRepository = entradaRepository;
    }

    public List<Integer> findListaEntradaGetNumeroDeUnEvento(Integer eventoId){
        return this.entradaRepository.findByListaDeEntradaNumeroDeUnEvento(eventoId);
    }

    public Integer findByMaxNumeroDeUnEvento(Integer eventoId){
        return this.entradaRepository.maxNumeroDeUnEvento(eventoId);
    }

    public void guardarEntradasNuevas(List<EntradaDTO> listaEntradasDTO, UsuarioDTO usuarioDTO, EventoDTO eventoDTO){
        List<Entrada> listaEntradas = new ArrayList<>();
        Entrada entrada;
        Evento evento = this.eventoRepository.findById(eventoDTO.getId()).get();
        Usuario usuario = this.usuarioRepository.findById(usuarioDTO.getId()).get();
        List<Entrada> listaEntradasEvento = evento.getEntradaList();
        List<Entrada> listaEntradasUsuario = usuario.getEntradaList();

        for (EntradaDTO entradaDTO : listaEntradasDTO){
            entrada = new Entrada();
            entrada.setUsuario(usuario);
            entrada.setEvento(evento);
            entrada.setNumero(entradaDTO.getNumero());
            entrada.setFila(entradaDTO.getFila());
            entrada.setAsiento(entradaDTO.getAsiento());

            listaEntradas.add(entrada);
            listaEntradasEvento.add(entrada);
            listaEntradasUsuario.add(entrada);
        }
        this.entradaRepository.saveAll(listaEntradas);
        this.usuarioRepository.save(usuario);
        this.eventoRepository.save(evento);

        usuario.setEntradaList(listaEntradasUsuario);
        evento.setEntradaList(listaEntradasEvento);
    }

    public List<EventoDTO> listaEventosDeUnUsuarioRecientes(UsuarioDTO usuarioDTO){
        List<EventoDTO> listaRes = new ArrayList<>();
        List<Evento> listaEventos = this.entradaRepository.findByEventosDeUnUsuarioRecientes(usuarioDTO.getId(), new Date());
        for (Evento e : listaEventos){
            listaRes.add(e.getDTO());
        }
        return listaRes;
    }

    public List<EventoDTO> listaEventosDeUnUsuarioFinalizados(UsuarioDTO usuarioDTO){
        List<EventoDTO> listaRes = new ArrayList<>();
        List<Evento> listaEventos = this.entradaRepository.findByEventosDeUnUsuarioFinalizados(usuarioDTO.getId(), new Date());
        for (Evento e : listaEventos){
            listaRes.add(e.getDTO());
        }
        return listaRes;
    }

    public List<EntradaDTO> listaEntradaDeUnUsuarioYEvento(UsuarioDTO usuarioDTO, EventoDTO eventoDTO){
        List<EntradaDTO> listaRes = new ArrayList<>();
        List<Entrada> listaEntradas = this.entradaRepository.findByEntradasDeUnUsuarioyEvento(usuarioDTO.getId(), eventoDTO.getId());
        for (Entrada e : listaEntradas){
            listaRes.add(e.getDTOSinEventoyUsuario());
        }
        return listaRes;
    }

    public void eliminarEntradas(List<Integer> listaEntradasId, UsuarioDTO usuarioDTO, EventoDTO eventoDTO){
        List<Entrada> listaEntradas = new ArrayList<>();
        Usuario usuario = this.usuarioRepository.findById(usuarioDTO.getId()).get();
        Evento evento = this.eventoRepository.findById(eventoDTO.getId()).get();
        List<Entrada> listaEntradasUsuario = usuario.getEntradaList();
        List<Entrada> listaEntradasEvento = evento.getEntradaList();
        Entrada entrada;
        for (Integer entradaId : listaEntradasId){
            entrada = this.entradaRepository.findById(entradaId).get();
            listaEntradas.add(entrada);
        }
        listaEntradasUsuario.removeAll(listaEntradas);
        listaEntradasEvento.removeAll(listaEntradas);

        usuario.setEntradaList(listaEntradasUsuario);
        evento.setEntradaList(listaEntradasEvento);

        this.usuarioRepository.save(usuario);
        this.eventoRepository.save(evento);
        this.entradaRepository.deleteAll(listaEntradas);
    }

    public void modificarEntradas(List<Integer> entradasAntiguas, List<Integer> nuevas){
        Entrada e;
        Integer numero;

        for (int i=0; i < entradasAntiguas.size(); i++){
            e = this.entradaRepository.findById(entradasAntiguas.get(i)).get();

            numero = nuevas.get(i);
            e.setNumero(numero);
            e.setFila((numero - 1) / e.getEvento().getAsientosFila() + 1);
            e.setAsiento(numero);

            this.entradaRepository.save(e);
        }
    }
}
