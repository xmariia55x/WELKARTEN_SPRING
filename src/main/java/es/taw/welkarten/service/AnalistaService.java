package es.taw.welkarten.service;

import es.taw.welkarten.dao.EstudioRepository;
import es.taw.welkarten.entity.Estudio;
import es.taw.welkarten.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnalistaService {
    private EstudioRepository estudioRepository;

    public EstudioRepository getAnalistaRepository() {
        return estudioRepository;
    }
    @Autowired
    public void setAnalistaRepository(EstudioRepository estudioRepository) {
        this.estudioRepository = estudioRepository;
    }

    public List<Estudio> findAllEstudios(){return this.estudioRepository.findAll();}

    public Estudio findById(Integer id){return this.estudioRepository.findById(id).get();}

    public void guardarEstudio(Estudio estudio){
        this.estudioRepository.save(estudio);
    }

    public void eliminarEstudio (Estudio estudio){ this.estudioRepository.delete(estudio);}
}
