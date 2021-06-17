package es.taw.welkarten.controller;

import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.UsuarioeventosDTO;
import es.taw.welkarten.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Optional;


@Controller
@RequestMapping("/usuario")
public class UsuarioController {

}
