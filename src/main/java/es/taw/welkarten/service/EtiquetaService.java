package es.taw.welkarten.service;

import es.taw.welkarten.dao.EtiquetaRepository;
import es.taw.welkarten.entity.Etiqueta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EtiquetaService {
    private EtiquetaRepository etiquetaRepository;

    @Autowired
    public void setEtiquetaRepository(EtiquetaRepository etiquetaRepository) {
        this.etiquetaRepository = etiquetaRepository;
    }

    public List<Etiqueta> findEtiquetas(){
        return this.etiquetaRepository.findAll();
    }
}
