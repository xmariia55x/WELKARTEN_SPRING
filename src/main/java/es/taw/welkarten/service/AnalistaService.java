package es.taw.welkarten.service;

import es.taw.welkarten.dao.EstudioRepository;
import es.taw.welkarten.dao.EventoRepository;
import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.EstudioDTO;
import es.taw.welkarten.entity.Estudio;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.entity.Usuarioeventos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
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

    public List<Estudio> findAllEstudios(){return this.estudioRepository.findAll();}

    public List<Evento> findAllEventos(){return this.eventoRepository.findAll();}
    public Estudio findById(Integer id){return this.estudioRepository.findById(id).get();}

    public void guardarEstudio(Estudio estudio){
        this.estudioRepository.save(estudio);
    }

    public void eliminarEstudio (Estudio estudio){ this.estudioRepository.delete(estudio);}

    public void doGuardarEstudio(Model model, EstudioDTO estudioDTO, HttpSession session){
        Estudio estudio;
        if(estudioDTO.getId() == null){
             estudio = new Estudio();
             estudio.setAnalista((Usuario) session.getAttribute("usuario"));
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
