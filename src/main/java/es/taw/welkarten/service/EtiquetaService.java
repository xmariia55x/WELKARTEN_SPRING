package es.taw.welkarten.service;

import es.taw.welkarten.dao.EtiquetaRepository;
import es.taw.welkarten.dto.EtiquetaDTO;
import es.taw.welkarten.entity.Etiqueta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EtiquetaService {
    private EtiquetaRepository etiquetaRepository;

    @Autowired
    public void setEtiquetaRepository(EtiquetaRepository etiquetaRepository) {
        this.etiquetaRepository = etiquetaRepository;
    }

    public List<EtiquetaDTO> findEtiquetas(){
        List<EtiquetaDTO> etiquetaDTOS = new ArrayList<>();
        List<Etiqueta> etiquetas = this.etiquetaRepository.findAll();
        for(Etiqueta etq : etiquetas){
            etiquetaDTOS.add(etq.getDTO());
        }

        return etiquetaDTOS;
    }
}
