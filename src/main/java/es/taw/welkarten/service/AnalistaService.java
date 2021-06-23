package es.taw.welkarten.service;

import es.taw.welkarten.dao.EstudioRepository;
import es.taw.welkarten.dao.EventoRepository;
import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.EstudioDTO;
import es.taw.welkarten.dto.EventoDTO;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.Estudio;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.entity.Usuarioeventos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class AnalistaService {
    private EstudioRepository estudioRepository;
    private EventoRepository eventoRepository;
    private UsuarioRepository usuarioRepository;

    public EstudioRepository getEstudioRepository() {
        return estudioRepository;
    }
    @Autowired
    public void setAnalistaRepository(EstudioRepository estudioRepository) {
        this.estudioRepository = estudioRepository;
    }

    public EventoRepository getEventoRepository() {
        return eventoRepository;
    }
    @Autowired
    public void setEventoRepository(EventoRepository eventoRepository) {
        this.eventoRepository = eventoRepository;
    }

    @Autowired
    public void setUsuarioRepository(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public List<EstudioDTO> findAllEstudios(){
        EstudioDTO ed;
        List<EstudioDTO> res = new ArrayList<>();
        for(Estudio e: this.estudioRepository.findAll()){
            ed = new EstudioDTO();
            ed.setId(e.getId());
            ed.setCorreo(e.getAnalista().getCorreo());
            ed.setDescripcion(e.getDescripcion());
            ed.setResultado(e.getResultado());
            res.add(ed);
        }
        return res;
    }

    public List<Evento> findAllEventos(){return this.eventoRepository.findAll();}
    public List<EventoDTO> findAllEventosDTO(){
        List<EventoDTO> res = new ArrayList<>();
        for(Evento e : findAllEventos()){
            res.add(e.getDTO());
        }
        return res;

    }
    public EstudioDTO findByIdDTO(Integer id){return this.estudioRepository.findById(id).get().getDTO();}
    public Estudio findById(Integer id){return this.estudioRepository.findById(id).get();}

    public void guardarEstudio(Estudio estudio){
        this.estudioRepository.save(estudio);
    }

    public void eliminarEstudio (Integer id){
        Estudio estudio = findById(id);
        estudio.getAnalista().getEstudioList().remove(estudio);
        this.estudioRepository.delete(estudio);}

    public void copiarEstudio(Integer id){
        Estudio estudio = findById(id);
        Estudio nuevo = new Estudio();
        nuevo.setAnalista(estudio.getAnalista());
        nuevo.setDescripcion(estudio.getDescripcion() + "(Copia)");
        nuevo.setResultado(estudio.getResultado());

        Usuario analista = estudio.getAnalista();
        analista.getEstudioList().add(nuevo);
        guardarEstudio(nuevo);
    }


    public UsuarioDTO findByCorreoUsuarioDTO(String correo){return this.usuarioRepository.findByCorreo(correo).getDTO();}

    public void doGuardarEstudio(Model model, EstudioDTO estudioDTO, HttpSession session){
        Estudio estudio;
        if(estudioDTO.getId() == null){
             estudio = new Estudio();
             UsuarioDTO u =(UsuarioDTO) session.getAttribute("usuario");
             estudio.setAnalista(this.usuarioRepository.findById(u.getId()).get());
             estudio.setResultado(doConsulta(estudioDTO));
        }
        else{
             estudio = this.estudioRepository.findById(estudioDTO.getId()).get();
             estudio.setAnalista(this.usuarioRepository.findByCorreo(estudioDTO.getCorreo()));
             this.usuarioRepository.save(estudio.getAnalista());

        }

        estudio.setDescripcion(estudioDTO.getDescripcion());
        this.estudioRepository.save(estudio);

    }

    private String doConsulta(EstudioDTO estudioDTO){
        Evento e = this.eventoRepository.findByTitulo(estudioDTO.getNombreEvento());
        List<Usuarioeventos> users = this.estudioRepository.doResultado(e);
        Date d = new Date();
        long l = d.getTime();
        for(Usuarioeventos u : users){
            if(estudioDTO.getSigno().equals("<")){
                if(!((u.getFechaNacimiento().getTime()- l) < estudioDTO.getEdad())){
                    users.remove(u);
                }
            }else if(estudioDTO.getSigno().equals("=")){
                if(!((u.getFechaNacimiento().getTime()- l) == estudioDTO.getEdad())){
                    users.remove(u);
                } else if(estudioDTO.getSigno().equals(">")){
                    if(!((u.getFechaNacimiento().getTime()- l) > estudioDTO.getEdad())){
                        users.remove(u);
                    }

                }
            }
        }
        return String.valueOf(users.size());
    }
}
