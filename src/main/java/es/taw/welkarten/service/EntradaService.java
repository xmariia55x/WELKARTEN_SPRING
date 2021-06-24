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
}
