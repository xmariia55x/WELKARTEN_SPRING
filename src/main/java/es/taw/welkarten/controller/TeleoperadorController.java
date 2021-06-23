package es.taw.welkarten.controller;

import es.taw.welkarten.dto.ConversacionDTO;
import es.taw.welkarten.dto.FiltroConversacion;
import es.taw.welkarten.dto.MensajeDTO;
import es.taw.welkarten.dto.UsuarioDTO;

import es.taw.welkarten.service.ConversacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/teleoperador")
public class TeleoperadorController {
    ConversacionService conversacionService;

    public ConversacionService getConversacionService() {
        return conversacionService;
    }

    @Autowired
    public void setConversacionService(ConversacionService conversacionService) {
        this.conversacionService = conversacionService;
    }

    @GetMapping("/")
    public String doTeleoperador(Model model) {
        FiltroConversacion filtroConversacion = new FiltroConversacion();
        return this.doFiltrarConversacion(filtroConversacion, model);
    }

    @PostMapping("/filtrarConversacion")
    public String doFiltrarConversacion(@ModelAttribute("filtro") FiltroConversacion filtro, Model model) {
        List<ConversacionDTO> conversaciones = this.conversacionService.findConversaciones(filtro.getTeleoperador(), filtro.getUsuario());
        model.addAttribute("conversaciones", conversaciones);
        model.addAttribute("filtro", filtro);
        return "Teleoperador";
    }

    @GetMapping("/cargaPeticiones")
    public String doCargarPeticiones(Model model, HttpSession session) {
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
        List<ConversacionDTO> peticiones = this.conversacionService.findPeticionesTeleoperador(usuario);
        model.addAttribute("listaPeticiones", peticiones);
        return "PeticionesTeleoperador";
    }

    @GetMapping("/listaMisChats")
    public String doListarMisChats(Model model, HttpSession session) {
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
        List<ConversacionDTO> misChats;
        if(usuario.getRol() == 5) {
            misChats = this.conversacionService.findPeticionesTeleoperador(usuario);
        } else {
            misChats = this.conversacionService.findPeticionesUsuario(usuario);
        }
        model.addAttribute("misChats", misChats);
        return "MisChats";
    }

    @GetMapping("/infoConversacion/{id}")
    public String doInfoConversacion(Model model, @PathVariable("id") Integer id) {
        ConversacionDTO c = this.conversacionService.findConversacion(id);
        List<MensajeDTO> listaMensajes = c.getMensaje();
        model.addAttribute("conversacion", c);
        model.addAttribute("listaMensajes", listaMensajes);
        return "InfoConversacion";
    }

    @GetMapping("/eliminarConversacion/{id}")
    public String doEliminarConversacion(@PathVariable("id") Integer id) {
        this.conversacionService.eliminarConversacion(id);
        return"redirect:/teleoperador/";
    }

    @GetMapping("/linkChat/{id}")
    public String doLinkChat(@PathVariable("id") Integer id, Model model) {
        ConversacionDTO c = this.conversacionService.findConversacion(id);
        model.addAttribute("conversacion", c);
        return "chatSync";
    }

    @GetMapping("/iniciarConversacion/{id}")
    public String doIniciarConversacion(@PathVariable("id") Integer id, HttpSession session) {
        UsuarioDTO usuario = (UsuarioDTO)session.getAttribute("usuario");
        this.conversacionService.iniciarConversacion(id, usuario);
        return"redirect:/teleoperador/";
    }

}
