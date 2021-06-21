package es.taw.welkarten.controller;

import es.taw.welkarten.dto.FiltroConversacion;
import es.taw.welkarten.entity.Conversacion;
import es.taw.welkarten.entity.Mensaje;
import es.taw.welkarten.entity.Usuario;
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
        List<Conversacion> conversaciones = this.conversacionService.findConversaciones(filtro.getTeleoperador(), filtro.getUsuario());
        model.addAttribute("conversaciones", conversaciones);
        model.addAttribute("filtro", filtro);
        return "Teleoperador";
    }

    @GetMapping("/cargaPeticiones")
    public String doCargarPeticiones(Model model, HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        List<Conversacion> peticiones = this.conversacionService.findPeticionesTeleoperador(usuario);
        model.addAttribute("listaPeticiones", peticiones);
        return "PeticionesTeleoperador";
    }

    @GetMapping("/listaMisChats")
    public String doListarMisChats(Model model, HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        List<Conversacion> misChats;
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
        Conversacion c = this.conversacionService.findConversacion(id);
        List<Mensaje> listaMensajes = c.getMensajeList();
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
        Conversacion c = this.conversacionService.findConversacion(id);
        model.addAttribute("conversacion", c);
        return "chat";
    }



}
