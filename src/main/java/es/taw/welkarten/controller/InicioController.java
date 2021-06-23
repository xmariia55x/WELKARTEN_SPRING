package es.taw.welkarten.controller;

import es.taw.welkarten.dto.EventoDTO;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.service.EventoService;
import es.taw.welkarten.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class InicioController {
    private EventoService eventoService;
    private UsuarioService usuarioService;

    public EventoService getEventoService() {
        return eventoService;
    }

    public UsuarioService getUsuarioService() {
        return usuarioService;
    }

    @Autowired
    public void setUsuarioService(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @Autowired
    public void setEventoService(EventoService eventoService) {
        this.eventoService = eventoService;
    }

    @GetMapping("/")
    public String doInicio(Model model){
        List<EventoDTO> listaEventos = this.eventoService.findEventosNoCaducados();
        List<EventoDTO> listaEventosHoy = this.eventoService.findEventosHoy();
        List<EventoDTO> listaEventosEstaSemana = this.eventoService.findEventosEstaSemana();

        model.addAttribute("listaEventos", listaEventos);
        model.addAttribute("listaEventosHoy", listaEventosHoy);
        model.addAttribute("listaEventosEstaSemana", listaEventosEstaSemana);

        return "index";
    }

    @GetMapping("/conocenos")
    public String doConocer() {
        return "conocenos";
    }

    @GetMapping("/contactanos")
    public String doContactar() {
        return "contactanos";
    }

    @GetMapping("/crearConversacion")
    public String doCrearConversacion(Model model, HttpSession session) {
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
        String strTo;
        String strErr;
        String done = (String)model.getAttribute("done");

        if(done != null) {
            strTo = "CrearPeticion";
            model.addAttribute("done", done);
        } else {
            if(usuario == null) {
                strErr = "v";
                model.addAttribute("strErr", strErr);
                strTo = "contactanos";
            } else if(usuario.getRol() == 2 || usuario.getRol() == 4) {
                //Aqui creamos la lista de teleoperadores que tenemos en la BD para mostrarla
                List<UsuarioDTO> listaTeleoperadores = this.usuarioService.findTeleoperadores();
                strTo = "CrearPeticion";
                UsuarioDTO teleoperador = new UsuarioDTO();
                model.addAttribute("teleoperador", teleoperador);
                model.addAttribute("listaTeleoperadores", listaTeleoperadores);
            } else {
                strErr = "i";
                model.addAttribute("strErr", strErr);
                strTo = "contactanos";
            }
        }
        return strTo;
    }

    @PostMapping("/guardarConversacion")
    public String doGuardarConversacion(HttpSession session, @ModelAttribute("teleoperador") UsuarioDTO teleoperador, Model model) {
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("usuario");

        //Busco el teleoperador en la BD
        String done = this.usuarioService.crearConversacion(teleoperador.getId(), user.getId());
        model.addAttribute("done", done);

        return "contactanos";
    }
}
