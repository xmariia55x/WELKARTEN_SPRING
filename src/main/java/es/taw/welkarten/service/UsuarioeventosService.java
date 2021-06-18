package es.taw.welkarten.service;

import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dao.UsuarioeventosRepository;
import es.taw.welkarten.dto.UsuarioeventosDTO;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.entity.Usuarioeventos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class UsuarioeventosService {
    private UsuarioeventosRepository usuarioeventosRepository;
    private UsuarioRepository usuarioRepository;

    @Autowired
    public void setUsuarioRepository(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Autowired
    public void setUsuarioeventosRepository(UsuarioeventosRepository usuarioeventosRepository) {
        this.usuarioeventosRepository = usuarioeventosRepository;
    }

    public Usuario guardarUsuarioeventos(Model model, UsuarioeventosDTO usuarioEDTO) {
        Usuarioeventos usuario;

        if (usuarioEDTO.getId() == null) {
            usuario = new Usuarioeventos();
        } else {
            usuario = this.usuarioeventosRepository.findById(usuarioEDTO.getId()).orElse(new Usuarioeventos());
        }
            // Crear el usuario
            Usuario usuarioNormal = new Usuario();
            usuarioNormal.setId(0);
            usuarioNormal.setCorreo(usuarioEDTO.getUsuario().getCorreo());
            usuarioNormal.setNif(usuarioEDTO.getUsuario().getNif());
            usuarioNormal.setNombre(usuarioEDTO.getUsuario().getNombre());
            usuarioNormal.setPassword(usuarioEDTO.getUsuario().getPassword());
            usuarioNormal.setRol(4);

            //Se guarda el usuario nuevo
            this.usuarioRepository.save(usuarioNormal);

            //Se extrae el usuario que hemos guardado
            Usuario usuarioExtraido = this.usuarioRepository.findByCorreo(usuarioEDTO.getUsuario().getCorreo());

            usuario.setApellidos(usuarioEDTO.getApellidos());
            usuario.setDomicilio(usuarioEDTO.getDomicilio());
            usuario.setCiudad(usuarioEDTO.getCiudad());

            //usuario.setId(usuarioNormal.getId());
            usuario.setId(usuarioExtraido.getId());
            String fechaNacimiento = usuarioEDTO.getFechaNacimiento();
            try {
                Date fecha = new SimpleDateFormat("yyyy-MM-dd").parse(fechaNacimiento);
                //2000-04-17
                usuario.setFechaNacimiento(fecha);
            } catch (ParseException e) {
                e.printStackTrace();
            }

            usuario.setSexo(usuarioEDTO.getSexo());
            usuario.setUsuario(usuarioExtraido);
            usuarioExtraido.setUsuarioeventos(usuario);

            this.usuarioRepository.save(usuarioExtraido);
            this.usuarioeventosRepository.save(usuario);

        return usuarioExtraido;
    }

    public void eliminar(Usuarioeventos usuarioEventos) {
        this.usuarioeventosRepository.delete(usuarioEventos);
    }
}
