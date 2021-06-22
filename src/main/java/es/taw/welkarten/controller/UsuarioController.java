package es.taw.welkarten.controller;

import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.dto.UsuarioeventosDTO;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.entity.Usuarioeventos;
import es.taw.welkarten.service.UsuarioService;
import es.taw.welkarten.service.UsuarioeventosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;


@Controller
@RequestMapping("/usuario")
public class UsuarioController {
    private UsuarioeventosService usuarioeventosService;
    private UsuarioService usuarioService;

    @Autowired
    public void setUsuarioService(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @Autowired
    public void setUsuarioeventosService(UsuarioeventosService usuarioeventosService) {
        this.usuarioeventosService = usuarioeventosService;
    }

    @GetMapping("/verPerfil")
    public String doRedirigirMiPerfil(){
        return "VerPerfil";
    }

    @GetMapping("/editarPerfil")
    public String doRedirigirEditarPerfil(HttpSession session, Model model){
        /*if(((Usuario)session.getAttribute("usuario")).getUsuarioeventos() != null){
            UsuarioeventosDTO usuarioEDTO = ((Usuario)session.getAttribute("usuario")).getUsuarioeventos().getDTO();
            model.addAttribute("usuarioEventosDTO", usuarioEDTO);
        }*/

        UsuarioDTO usuarioDTO = (UsuarioDTO) session.getAttribute("usuario");
        model.addAttribute("usuarioDTO", usuarioDTO);
        return "EditarPerfil";
    }

    @GetMapping("/cerrarSesion")
    public String doCerrarSesion(HttpSession session){
        //Una vez el usuario haya cerrado sesion, lo mandamos a la pagina de inicio
        session.invalidate();

        return "redirect:/";
    }

    @GetMapping("/borrarPerfil")
    public String doBorrarPerfil(HttpSession session){
        UsuarioDTO usuario = (UsuarioDTO)session.getAttribute("usuario");

        if(usuario.getUsuarioeventos() != null){
            UsuarioeventosDTO usuarioEventos = usuario.getUsuarioeventos();
            //Eliminar al usuario de eventos primero
            this.usuarioeventosService.eliminar(usuarioEventos);
        }
        this.usuarioService.eliminar(usuario);
        session.invalidate();

        return "redirect:/";
    }

    @PostMapping("/guardarInformacionPerfil")
    public String doGuardarInformacionPerfilActualizado(HttpSession session, Model model,
                                                        @ModelAttribute("usuarioDTO") UsuarioDTO usuarioDTO){
        String strError = "", strTo = "";
        if(usuarioDTO.getPassword().equals(usuarioDTO.getContraseniaRepetida())){
            UsuarioDTO usuario = this.usuarioService.guardarUsuario(usuarioDTO);
            session.setAttribute("usuario",usuario);
            strTo = "redirect:/verPerfil";
        } else {
            strError = "contraseniaNoCoincide";
            model.addAttribute("error", strError);
            strTo =  "EditarPerfil";

        }
        return strTo;
    }

}
