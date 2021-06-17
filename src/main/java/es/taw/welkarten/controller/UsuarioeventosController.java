package es.taw.welkarten.controller;

import es.taw.welkarten.dto.UsuarioeventosDTO;
import es.taw.welkarten.service.UsuarioeventosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class UsuarioeventosController {
    private UsuarioeventosService usuarioeventosService;

    @Autowired
    public void setUsuarioeventosService(UsuarioeventosService usuarioeventosService) {
        this.usuarioeventosService = usuarioeventosService;
    }

    @GetMapping("/registro")
    public String doRegistrar(Model model) {
        UsuarioeventosDTO usuarioEDTO = new UsuarioeventosDTO();
        model.addAttribute("usuarioEDTO", usuarioEDTO);
        return "Registro";
    }

    @PostMapping("/guardarUsuario")
    public String doGuardarUsuario(Model model, @ModelAttribute("usuarioEDTO") UsuarioeventosDTO usuarioEDTO,
                                   HttpSession session) {
        return this.usuarioeventosService.guardarUsuarioeventos(model, usuarioEDTO, session);
        //return "tabien";
    }
}
