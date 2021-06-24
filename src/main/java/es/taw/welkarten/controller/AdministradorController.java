package es.taw.welkarten.controller;

import es.taw.welkarten.dto.EtiquetaDTO;
import es.taw.welkarten.dto.EventoDTO;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.Etiqueta;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.service.EtiquetaService;
import es.taw.welkarten.service.EventoService;
import es.taw.welkarten.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
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
    public String doInicializarAdmin(Model model){
        List<UsuarioDTO> listaUsuarios = this.usuarioService.findUsuarios();
        List<EventoDTO> listaEventos = this.eventoService.findEventos();
        List<EtiquetaDTO> listaEtiquetas = this.etiquetaService.findEtiquetas();

        model.addAttribute("listaUsuarios", listaUsuarios);
        model.addAttribute("listaEventos", listaEventos);
        model.addAttribute("listaEtiquetas", listaEtiquetas);
        return "Administrador";
    }

    @GetMapping("/crearUsuarioAdministrador")
    public String doRedirigirCrearUsuario(){
        return "CrearUsuarioAdministrador";
    }

    @GetMapping("/crearEventoAdministrador")
    public String doRedirigirCrearEvento(Model model){
        List<EtiquetaDTO> listaEtiquetas = this.etiquetaService.findEtiquetas();
        EventoDTO eventoDTO = new EventoDTO();

        model.addAttribute("listaEtiquetas", listaEtiquetas);
        model.addAttribute("eventoDTO", eventoDTO);
        return "CrearEditarEventoAdministrador";
    }

    @PostMapping("/guardarEvento")
    public String doGuardarNuevoEvento(Model model, @ModelAttribute("eventoDTO") EventoDTO eventoDTO, HttpSession session){
        String strError = "";
        UsuarioDTO creador = (UsuarioDTO) session.getAttribute("usuario");
        if(eventoDTO.getSeleccionAsientos().equals("S")){
            if(eventoDTO.getFilas() == null && eventoDTO.getAsientosFila() == null){
                strError = "seleccionIncorrecta";
                return "redirect:/crearEventoAdministrador";
            }
        } else if (eventoDTO.getSeleccionAsientos().equals("N")){
            if(eventoDTO.getFilas() != null && eventoDTO.getAsientosFila() != null){
                strError = "seleccionIncorrecta";
                return "redirect:/crearEventoAdministrador";
            }
        }
        if (eventoDTO.getFechaReservaString().compareTo(eventoDTO.getFechaInicioString()) > 0){
            strError = "fechasIncorrectas";
            return "redirect:/crearEventoAdministrador";
        }  else if (eventoDTO.getEtiquetas().size() < 1 || eventoDTO.getEtiquetas().size() > 2){
            strError = "etiquetasIncorrectas";
            return "redirect:/crearEventoAdministrador";
        } else {
            //this.eventoService.guardarEvento(eventoDTO, eventoDTO.getEtiquetaseventoList());
            this.eventoService.guardarEvento(eventoDTO, creador);
            return "redirect:/administrador/";

        }

    }

}
