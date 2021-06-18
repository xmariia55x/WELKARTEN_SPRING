package es.taw.welkarten.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;

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
        List<Usuario> listaUsuarios = this.usuarioService.findUsuarios();
        List<Evento> listaEventos = this.eventoService.findEventos();
        List<Etiqueta> listaEtiquetas = this.etiquetaService.findEtiquetas();

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
    public String doRedirigirCrearEvento(){
        return "CrearEditarEvento";
    }
}
