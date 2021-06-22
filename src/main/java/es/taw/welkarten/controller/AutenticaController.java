package es.taw.welkarten.controller;

import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class AutenticaController{

    private UsuarioService usuarioService;

    public UsuarioService getUsuarioService() {
        return usuarioService;
    }

    @Autowired
    public void setUsuarioService(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @GetMapping("/login")
    public String doLogin(){
        return "InicioSesion";
    }

    @PostMapping("/autenticar")
    public String doAutenticar (@RequestParam("email") String email,
                                @RequestParam("password") String password,
                                Model model, HttpSession session) {

        String strTo = "", strError = "";

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {  // Error de autenticación por email o clave
            // vacíos o nulos.
            strError = "v";
            model.addAttribute("error", strError);
            strTo = "InicioSesion";
        } else {
            UsuarioDTO usuario = this.usuarioService.comprobarCredenciales(email, password);
            if (usuario == null) { // Error -- No se encuentra el usuario en la BD
                strError = "n";
                model.addAttribute("error", strError);
                strTo = "InicioSesion";
            } else { //Usuario está en la BD
                //Comprobamos el rol del usuario
                switch (usuario.getRol()){
                    case 1: strTo = "redirect:/administrador/"; break;
                    case 2: strTo = "redirect:/creadoreventos/"; break;
                    case 3: strTo = "redirect:/analista/"; break;
                    case 4: strTo = "redirect:/"; break;
                    default: strTo = "redirect:/teleoperador/"; break;
                }
                session.setAttribute("usuario", usuario);
            }
        }
        return strTo;
    }

}
