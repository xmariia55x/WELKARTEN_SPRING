package es.taw.welkarten.service;

import es.taw.welkarten.dao.ConversacionRepository;
import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dao.UsuarioeventosRepository;
import es.taw.welkarten.dto.EventoDTO;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.text.DateFormat;
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
    private ConversacionRepository conversacionRepository;

    public ConversacionRepository getConversacionRepository() {
        return conversacionRepository;
    }

    @Autowired
    public void setConversacionRepository(ConversacionRepository conversacionRepository) {
        this.conversacionRepository = conversacionRepository;
    }

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

    public List<UsuarioDTO> findTeleoperadores() {
        List<UsuarioDTO> listaTeleoperadores = new ArrayList<>();
        List<Usuario> lista = this.usuarioRepository.findByRol(5);
        for(Usuario u : lista) {
            listaTeleoperadores.add(u.getDTO());
        }

        return listaTeleoperadores;
    }

    public List<UsuarioDTO> findCreadores(){
        List<Usuario> creadores = this.usuarioRepository.findByRol(2);
        return convertirAListaDTO(creadores);
    }


    public UsuarioDTO guardarUsuario(UsuarioDTO usuarioDTO) {
        Usuario usuario;

        if (usuarioDTO.getId() == null) {
            usuario = new Usuario();
            usuario.setId(0);
            usuario.setRol(usuarioDTO.getRol());
        } else {
            usuario = this.usuarioRepository.findById(usuarioDTO.getId()).orElse(new Usuario());
        }
        // Crear el usuario


        usuario.setCorreo(usuarioDTO.getCorreo());
        usuario.setNif(usuarioDTO.getNif());
        usuario.setNombre(usuarioDTO.getNombre());
        usuario.setPassword(usuarioDTO.getPassword());


        //Se guarda el usuario nuevo
        this.usuarioRepository.save(usuario);

        //Se extrae el usuario que hemos guardado
        Usuario usuarioExtraido = this.usuarioRepository.findByCorreo(usuarioDTO.getCorreo());
        UsuarioDTO usuarioDTOdevuelto = usuarioExtraido.getDTO();
        if(usuarioExtraido.getUsuarioeventos() != null && usuarioExtraido.getRol() == 4){
            Usuarioeventos usuarioEventos = usuarioExtraido.getUsuarioeventos();

            usuarioEventos.setApellidos(usuarioDTO.getUsuarioeventos().getApellidos());
            usuarioEventos.setDomicilio(usuarioDTO.getUsuarioeventos().getDomicilio());
            usuarioEventos.setCiudad(usuarioDTO.getUsuarioeventos().getCiudad());

            //usuario.setId(usuarioNormal.getId());
            usuarioEventos.setId(usuarioExtraido.getId());

            DateFormat formateo = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date fechaNacimiento = formateo.parse(usuarioDTO.getUsuarioeventos().getFechaNacimientoFake());
                usuarioEventos.setFechaNacimiento(fechaNacimiento);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            usuarioEventos.setSexo(usuarioDTO.getUsuarioeventos().getSexo());
            usuarioEventos.setUsuario(usuarioExtraido);
            usuarioExtraido.setUsuarioeventos(usuarioEventos);

            this.usuarioRepository.save(usuarioExtraido);
            this.usuarioeventosRepository.save(usuarioEventos);

            usuarioDTOdevuelto = usuarioExtraido.getDTO();
        }

        return usuarioDTOdevuelto;
    }

    public String crearConversacion(Integer idTele, Integer idUser) {
        Usuario teleoperador = this.usuarioRepository.findById(idTele).get();
        Usuario usuario = this.usuarioRepository.findById(idUser).get();

        //Creo la conversacion sin lista de mensajes
        Conversacion conversacion = new Conversacion();

        conversacion.setTeleoperador(teleoperador);
        conversacion.setUsuario(usuario);
        this.conversacionRepository.save(conversacion);

        usuario.getConversacionList1().add(conversacion);
        teleoperador.getConversacionList().add(conversacion);

        this.usuarioRepository.save(usuario);
        this.usuarioRepository.save(usuario);

        String done = "Conversación creada con éxito";
        return done;
    }


    private List<UsuarioDTO> convertirAListaDTO(List<Usuario> lista){
        if(lista != null) {
            List<UsuarioDTO> listaDTO = new ArrayList<>();
            for(Usuario e : lista) {
                listaDTO.add(e.getDTO());
            }
            return listaDTO;
        } else  {
            return null;
        }
    }

    public void eliminarUsuario(Integer id) {
        Usuario usuario = this.usuarioRepository.findById(id).get();
        if(usuario.getUsuarioeventos() != null){
            this.usuarioeventosRepository.delete(usuario.getUsuarioeventos());
        }
        this.usuarioRepository.delete(usuario);
    }
}
