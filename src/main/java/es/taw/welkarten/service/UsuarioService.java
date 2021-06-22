package es.taw.welkarten.service;

import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dao.UsuarioeventosRepository;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.entity.Usuarioeventos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class UsuarioService {
    private UsuarioRepository usuarioRepository;
    private UsuarioeventosRepository usuarioeventosRepository;

    public UsuarioRepository getUsuarioRepository() {
        return usuarioRepository;
    }

    @Autowired
    public void setUsuarioRepository(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Autowired
    public void setUsuarioeventosRepository(UsuarioeventosRepository usuarioeventosRepository) {
        this.usuarioeventosRepository = usuarioeventosRepository;
    }

    public UsuarioDTO comprobarCredenciales(String email, String password) {
        Usuario usuario = this.usuarioRepository.findByEmailAndPassword(email, password);
        if (usuario != null) {
            return usuario.getDTO();
        } else {
            return null;
        }
    }

    public List<UsuarioDTO> findUsuarios(){
        List<UsuarioDTO> listaUsuarios = new ArrayList<>();
        List<Usuario> lista = this.usuarioRepository.findAll();
        for(Usuario usuario : lista){
            listaUsuarios.add(usuario.getDTO());
        }

        return listaUsuarios;
    }

    public void eliminar(UsuarioDTO usuario) {
        Optional<Usuario> usuarioOptional = this.usuarioRepository.findById(usuario.getId());
        if(usuarioOptional.isPresent()){
            Usuario usuarioEliminar = usuarioOptional.get();
            this.usuarioRepository.delete(usuarioEliminar);
        }
    }

    public UsuarioDTO guardarUsuario(UsuarioDTO usuarioDTO) {
        Usuario usuario;

        if (usuarioDTO.getId() == null) {
            usuario = new Usuario();
        } else {
            usuario = this.usuarioRepository.findById(usuarioDTO.getId()).orElse(new Usuario());
        }
        // Crear el usuario

        usuario.setId(0);
        usuario.setCorreo(usuarioDTO.getCorreo());
        usuario.setNif(usuarioDTO.getNif());
        usuario.setNombre(usuarioDTO.getNombre());
        usuario.setPassword(usuarioDTO.getPassword());
        usuario.setRol(usuarioDTO.getRol());

        //Se guarda el usuario nuevo
        this.usuarioRepository.save(usuario);

        //Se extrae el usuario que hemos guardado
        Usuario usuarioExtraido = this.usuarioRepository.findByCorreo(usuarioDTO.getCorreo());
        UsuarioDTO usuarioDTOdevuelto = usuarioExtraido.getDTO();
        if(usuarioExtraido.getUsuarioeventos() != null){
            Usuarioeventos usuarioEventos = usuarioExtraido.getUsuarioeventos();
            usuarioEventos.setApellidos(usuarioDTO.getUsuarioeventos().getApellidos());
            usuarioEventos.setDomicilio(usuarioDTO.getUsuarioeventos().getDomicilio());
            usuarioEventos.setCiudad(usuarioDTO.getUsuarioeventos().getCiudad());

            //usuario.setId(usuarioNormal.getId());
            usuarioEventos.setId(usuarioExtraido.getId());

            Date fechaNacimiento = usuarioDTO.getUsuarioeventos().getFechaNacimiento();
            usuarioEventos.setFechaNacimiento(fechaNacimiento);
            usuarioEventos.setSexo(usuarioDTO.getUsuarioeventos().getSexo());
            usuarioEventos.setUsuario(usuarioExtraido);
            usuarioExtraido.setUsuarioeventos(usuarioEventos);

            this.usuarioRepository.save(usuarioExtraido);
            this.usuarioeventosRepository.save(usuarioEventos);

            usuarioDTOdevuelto = usuarioExtraido.getDTO();
        }

        return usuarioDTOdevuelto;
    }
}
