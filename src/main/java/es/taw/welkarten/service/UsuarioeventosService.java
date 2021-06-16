package es.taw.welkarten.service;

import es.taw.welkarten.dao.UsuarioeventosRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsuarioeventosService {
    UsuarioeventosRepository usuarioeventosRepository;

    public UsuarioeventosRepository getUsuarioeventosRepository() {
        return usuarioeventosRepository;
    }

    @Autowired
    public void setUsuarioeventosRepository(UsuarioeventosRepository usuarioeventosRepository) {
        this.usuarioeventosRepository = usuarioeventosRepository;
    }
}
