package es.taw.welkarten.controller;

import es.taw.welkarten.dto.*;
import es.taw.welkarten.entity.Etiqueta;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.service.EtiquetaService;
import es.taw.welkarten.service.EventoService;
import es.taw.welkarten.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/administrador")
public class AdministradorController {
    private UsuarioService usuarioService;
    private EtiquetaService etiquetaService;
    private EventoService eventoService;

    @Autowired
    public void setUsuarioService(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @Autowired
    public void setEtiquetaService(EtiquetaService etiquetaService) {
        this.etiquetaService = etiquetaService;
    }

    @Autowired
    public void setEventoService(EventoService eventoService) {
        this.eventoService = eventoService;
    }

    @GetMapping("/")
    public String doInicializarAdmin(Model model, FiltroUsuariosDTO filtro, FiltroEventosDTO filtroEventosDTO){
        if(filtro == null || filtro.isEmpty()){
            List<UsuarioDTO> listaUsuarios = this.usuarioService.findUsuarios();
            model.addAttribute("listaUsuarios", listaUsuarios);
            filtro = new FiltroUsuariosDTO();
        } else {
            if(filtro.getUsuariosFiltrados() != null && !filtro.getUsuariosFiltrados().isEmpty()){
                model.addAttribute("listaUsuarios", filtro.getUsuariosFiltrados());
            }

        }

        if(filtroEventosDTO == null || filtroEventosDTO.isEmpty()){
            List<EventoDTO> listaEventos = this.eventoService.findEventos();
            model.addAttribute("listaEventos", listaEventos);
            filtroEventosDTO = new FiltroEventosDTO();
        } else {
            if(filtroEventosDTO.getEventosFiltrados() != null && !filtroEventosDTO.getEventosFiltrados().isEmpty()){
                model.addAttribute("listaEventos", filtroEventosDTO.getEventosFiltrados());
            }
        }
        List<String> roles = new ArrayList<>();
        roles.add("Administrador");
        roles.add("Creador de eventos");
        roles.add("Analista de eventos");
        roles.add("Usuario de eventos");
        roles.add("Teleoperador");
        filtro.setRoles(roles);


        List<EtiquetaDTO> listaEtiquetas = this.etiquetaService.findEtiquetas();

        List<String> etiquetas = new ArrayList<>();
        for(EtiquetaDTO etq : listaEtiquetas){
            if(etq.getNombre().startsWith("M")){
                etiquetas.add("MUSICA");
            } else {
                etiquetas.add(etq.getNombre());
            }

        }

        model.addAttribute("listaEtiquetas", listaEtiquetas);
        model.addAttribute("roles", roles);
        model.addAttribute("etiquetas", etiquetas);
        model.addAttribute("filtroUsuariosDTO", filtro);
        model.addAttribute("filtroEventosDTO", filtroEventosDTO);
        return "Administrador";
    }

    @GetMapping("/crearUsuarioAdministrador")
    public String doRedirigirCrearUsuario(Model model, String error, Integer id){
        UsuarioDTO usuarioDTO;
        if(id != null){
            usuarioDTO = this.usuarioService.getUsuarioDTO(id);
            Boolean editar = true;
            model.addAttribute("editar", editar);
        } else {
            usuarioDTO = new UsuarioDTO();
        }

        if(error != null) {
            model.addAttribute("error", error);
        }
        model.addAttribute("usuarioDTO", usuarioDTO);
        return "CrearEditarUsuario";
    }

    @GetMapping("/editarUsuario/id/{id}")
    public String doEditarUsuario(@PathVariable("id") Integer id, Model model){
        UsuarioDTO usuarioDTO = this.usuarioService.getUsuarioDTO(id);
        Boolean editar = true;
        model.addAttribute("usuarioDTO", usuarioDTO);
        model.addAttribute("editar", editar);
        return "CrearEditarUsuario";
    }

    @GetMapping("/crearEventoAdministrador")
    public String doRedirigirCrearEvento(Model model, String error, Integer id){
        List<EtiquetaDTO> listaEtiquetas = this.etiquetaService.findEtiquetas();
        EventoDTO eventoDTO;
        if(id != null){
            eventoDTO = this.eventoService.getEventoDTO(id);
            Boolean editar = true;
            model.addAttribute("editar", editar);
        } else {
            eventoDTO = new EventoDTO();
        }

        if(error != null) {
            model.addAttribute("error", error);
        }

        model.addAttribute("listaEtiquetas", listaEtiquetas);
        model.addAttribute("eventoDTO", eventoDTO);
        return "CrearEditarEventoAdministrador";
    }

    @GetMapping("/editarEvento/id/{id}")
    public String doRedirigirEditarEvento(@PathVariable("id") Integer id, Model model){
        EventoDTO eventoDTO = this.eventoService.getEventoDTO(id);
        List<EtiquetaDTO> listaEtiquetas = this.etiquetaService.findEtiquetas();
        Boolean editar = true;
        model.addAttribute("listaEtiquetas", listaEtiquetas);
        model.addAttribute("eventoDTO", eventoDTO);
        model.addAttribute("editar", editar);
        return "CrearEditarEventoAdministrador";
    }

    @PostMapping("/guardarEvento")
    public String doGuardarNuevoEvento(Model model, @ModelAttribute("eventoDTO") EventoDTO eventoDTO, HttpSession session){
        String strError = "";
        UsuarioDTO creador = (UsuarioDTO) session.getAttribute("usuario");
        if(eventoDTO.getSeleccionAsientos().equals("S")){
            if(eventoDTO.getFilas() == null && eventoDTO.getAsientosFila() == null){
                strError = "seleccionIncorrecta";
                return doRedirigirCrearEvento(model, strError, eventoDTO.getId());
            }
        } else if (eventoDTO.getSeleccionAsientos().equals("N")){
            if(eventoDTO.getFilas() != null && eventoDTO.getAsientosFila() != null){
                strError = "seleccionIncorrecta";
                return doRedirigirCrearEvento(model, strError, eventoDTO.getId());
            }
        }

        if (eventoDTO.getFechaReservaString().compareTo(eventoDTO.getFechaInicioString()) > 0){
            strError = "fechasIncorrectas";
            return doRedirigirCrearEvento(model, strError, eventoDTO.getId());
        }  else if (eventoDTO.getEtiquetas().size() < 1 || eventoDTO.getEtiquetas().size() > 2){
            strError = "etiquetasIncorrectas";
            return doRedirigirCrearEvento(model, strError, eventoDTO.getId());
        } else {
            //this.eventoService.guardarEvento(eventoDTO, eventoDTO.getEtiquetaseventoList());
            this.eventoService.guardarEvento(eventoDTO, creador);
            return "redirect:/administrador/";

        }

    }

    @GetMapping("/eliminarEvento/id/{id}")
    public String doEliminarEvento(@PathVariable("id") Integer id){
        this.eventoService.eliminarEvento(id);
        return "redirect:/administrador/";
    }

    @PostMapping("/guardarUsuario")
    public String doGuardarNuevoUsuario(Model model, @ModelAttribute("usuarioDTO") UsuarioDTO usuarioDTO){
        String strError = "";
        //UsuarioDTO creador = (UsuarioDTO) session.getAttribute("usuario");
        if(!usuarioDTO.getContraseniaRepetida().equals(usuarioDTO.getPassword())){
            strError = "contraseniaIncorrecta";
            return doRedirigirCrearUsuario(model, strError,usuarioDTO.getId());

        } else {
            //this.eventoService.guardarEvento(eventoDTO, eventoDTO.getEtiquetaseventoList());
            this.usuarioService.guardarUsuario(usuarioDTO);
            return "redirect:/administrador/";
        }

    }

    @GetMapping("/eliminarUsuario/id/{id}")
    public String doEliminarUsuario(@PathVariable("id") Integer id){
        this.usuarioService.eliminarUsuario(id);
        return "redirect:/administrador/";
    }


    @PostMapping("/filtrarNombreUsuario")
    public String doFiltrarNombreUsuario(Model model, @ModelAttribute("filtroUsuariosDTO") FiltroUsuariosDTO filtroUsuariosDTO){
        List<UsuarioDTO> listaNombres = new ArrayList<>();
        if(filtroUsuariosDTO.getNombreUsuario() != null && !filtroUsuariosDTO.getNombreUsuario().isEmpty()){
            listaNombres = this.usuarioService.findByNombreUsuario(filtroUsuariosDTO.getNombreUsuario());
        }
        filtroUsuariosDTO.setUsuariosFiltrados(listaNombres);
        return doInicializarAdmin(model, filtroUsuariosDTO, null);
    }

    /* FILTRO ROL USUARIO */
    @PostMapping("/filtrarRolUsuario")
    public String doFiltrarRolUsuario(Model model, @ModelAttribute("filtroUsuariosDTO") FiltroUsuariosDTO filtroUsuariosDTO){
        List<UsuarioDTO> listaNombres = new ArrayList<>();
        if(filtroUsuariosDTO.getRolesSeleccionados() != null && !filtroUsuariosDTO.getRolesSeleccionados().isEmpty()){
            listaNombres = this.usuarioService.findByRolUsuario(filtroUsuariosDTO.getRolesSeleccionados());
        }
        filtroUsuariosDTO.setUsuariosFiltrados(listaNombres);
        return doInicializarAdmin(model, filtroUsuariosDTO, null);
    }

    @PostMapping("/filtrarNombreEvento")
    public String doFiltrarNombreEvento(Model model, @ModelAttribute("filtroEventosDTO") FiltroEventosDTO filtro){
        List<EventoDTO> listaEventos = new ArrayList<>();
        if(filtro.getNombreEvento() != null && !filtro.getNombreEvento().isEmpty()){
            listaEventos = this.eventoService.findByNombreEvento(filtro.getNombreEvento());
        }
        filtro.setEventosFiltrados(listaEventos);
        return doInicializarAdmin(model, null, filtro);
    }

    @PostMapping("/filtrarCategoriaEvento")
    public String doFiltrarCategoriaEvento(Model model, @ModelAttribute("filtroEventosDTO") FiltroEventosDTO filtro){
        List<EventoDTO> eventos = new ArrayList<>();
        if(filtro.getEtiquetasSeleccionadas() != null && !filtro.getEtiquetasSeleccionadas().isEmpty()){
            eventos = this.eventoService.findByCategoriasEvento(filtro.getEtiquetasSeleccionadas());
        }
        filtro.setEventosFiltrados(eventos);
        return doInicializarAdmin(model, null, filtro);
    }
}

