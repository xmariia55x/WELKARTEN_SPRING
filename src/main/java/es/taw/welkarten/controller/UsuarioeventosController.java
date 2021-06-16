package es.taw.welkarten.controller;

import es.taw.welkarten.dto.UsuarioeventosDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
public class UsuarioeventosController {
    @GetMapping("/registro")
    public String doRegistrar(Model model) {
        UsuarioeventosDTO usuarioEDTO = new UsuarioeventosDTO();
        model.addAttribute("usuarioEDTO", usuarioEDTO);
        return "Registro";
    }

    @GetMapping("/guardarUsuario")
    public String doGuardarUsuario(@ModelAttribute("usuarioEDTO") UsuarioeventosDTO usuarioEDTO) {

        return "tabien";
    }
}
