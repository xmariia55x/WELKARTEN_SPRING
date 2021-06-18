package es.taw.welkarten.controller;

import es.taw.welkarten.entity.Conversacion;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.service.ConversacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
        List<Conversacion> conversaciones = this.conversacionService.findConversaciones();
        model.addAttribute("conversaciones", conversaciones);
        return "Teleoperador";
    }

    @GetMapping("/cargaPeticiones")
    public String doCargarPeticiones(Model model, HttpSession session) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        List<Conversacion> peticiones = this.conversacionService.findPeticiones(usuario);
        model.addAttribute("listaPeticiones", peticiones);
        return "PeticionesTeleoperador";
    }
}
