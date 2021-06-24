package es.taw.welkarten.service;

import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dao.UsuarioeventosRepository;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.dto.UsuarioeventosDTO;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.entity.Usuarioeventos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

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

    public UsuarioDTO guardarUsuarioeventos(UsuarioeventosDTO usuarioEDTO) {
        Usuarioeventos usuario;
        UsuarioDTO dtoDevuelto;
        // Crear el usuario
        Usuario usuarioNormal;
        if (usuarioEDTO.getId() == null) {
            usuario = new Usuarioeventos();
            usuarioNormal = new Usuario();
            usuarioNormal.setId(0);
            usuarioNormal.setRol(4);
        } else {
            usuario = this.usuarioeventosRepository.findById(usuarioEDTO.getId()).orElse(new Usuarioeventos());
            usuarioNormal = usuario.getUsuario();
        }


            usuarioNormal.setCorreo(usuarioEDTO.getUsuario().getCorreo());
            usuarioNormal.setNif(usuarioEDTO.getUsuario().getNif());
            usuarioNormal.setNombre(usuarioEDTO.getUsuario().getNombre());
            usuarioNormal.setPassword(usuarioEDTO.getUsuario().getPassword());


            //Se guarda el usuario nuevo
            this.usuarioRepository.save(usuarioNormal);

            //Se extrae el usuario que hemos guardado
            Usuario usuarioExtraido = this.usuarioRepository.findByCorreo(usuarioEDTO.getUsuario().getCorreo());

            usuario.setApellidos(usuarioEDTO.getApellidos());
            usuario.setDomicilio(usuarioEDTO.getDomicilio());
            usuario.setCiudad(usuarioEDTO.getCiudad());

            //usuario.setId(usuarioNormal.getId());
            usuario.setId(usuarioExtraido.getId());

            DateFormat formateo = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date fechaNacimiento = formateo.parse(usuarioEDTO.getFechaNacimientoFake());
            usuario.setFechaNacimiento(fechaNacimiento);
        } catch (ParseException e) {
            e.printStackTrace();
        }


            usuario.setSexo(usuarioEDTO.getSexo());
            usuario.setUsuario(usuarioExtraido);
            usuarioExtraido.setUsuarioeventos(usuario);

            this.usuarioRepository.save(usuarioExtraido);
            this.usuarioeventosRepository.save(usuario);
            dtoDevuelto = usuarioExtraido.getDTO();

            return dtoDevuelto;
    }

    public void eliminar(UsuarioeventosDTO usuarioEventos) {
        Optional<Usuarioeventos> usuarioeventosOptional = this.usuarioeventosRepository.findById(usuarioEventos.getId());
        if(usuarioeventosOptional.isPresent()){
            Usuarioeventos usuarioEliminar = usuarioeventosOptional.get();
            this.usuarioeventosRepository.delete(usuarioEliminar);
        }
    }
}
