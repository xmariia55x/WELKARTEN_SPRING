package es.taw.welkarten.controller;

import es.taw.welkarten.dto.UsuarioeventosDTO;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.service.UsuarioeventosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/usuarioeventos")
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
        String strError = "", strTo = "";
        if(usuarioEDTO.getUsuario().getPassword().equals(usuarioEDTO.getContraseniaRepetida())){
            Usuario usuario = this.usuarioeventosService.guardarUsuarioeventos(model, usuarioEDTO);
            session.setAttribute("usuario",usuario);
            strTo = "/usuarioeventos/init";
        } else {
            strError = "v";
            model.addAttribute("error", strError);
            strTo =  "Registro";

        }
        return strTo;
    }
}
