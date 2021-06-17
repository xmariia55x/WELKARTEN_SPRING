package es.taw.welkarten.service;

import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {
    private UsuarioRepository usuarioRepository;

    public UsuarioRepository getUsuarioRepository() {
        return usuarioRepository;
    }

    @Autowired
    public void setUsuarioRepository(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public Usuario comprobarCredenciales(String email, String password) {
        Usuario usuario = this.usuarioRepository.findByEmailAndPassword(email, password);
        if (usuario != null) {
            return usuario;
        } else {
            return null;
        }
    }

    public List<Usuario> findUsuarios(){
        return this.usuarioRepository.findAll();
    }
}
