package es.taw.welkarten.controller;

import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class UsuarioController {
       private UsuarioRepository usuarioRepository;

    @Autowired
    public void setUsuarioRepository(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    /*@GetMapping("/hola")
    public String inicio() {
        return "hola";
    }*/

    @GetMapping("/hola2")
    public String listarUsers(Model model){
        List<Usuario> usuarios = this.usuarioRepository.findAll();
        model.addAttribute("lista", usuarios);
        return "entrada";
    }
}
