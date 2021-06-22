package es.taw.welkarten.controller;

import es.taw.welkarten.dto.EstudioDTO;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.entity.Estudio;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.service.AnalistaService;
import es.taw.welkarten.service.EventoService;
import es.taw.welkarten.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/analista")
public class AnalistaController {
    private AnalistaService analistaService;



    @Autowired
    public void setAnalistaService(AnalistaService analistaService) {
        this.analistaService = analistaService;
    }

    @GetMapping("/")
    public String doInti(Model model) {
        model.addAttribute("estudios", analistaService.findAllEstudios());
        return "AnalistaEventos";
    }

    @GetMapping("/copiar/{id}")
    public String doCopiar(@PathVariable("id") Integer id, Model model) {

        this.analistaService.copiarEstudio(id);
        return "redirect:/analista/";
    }


    @GetMapping("/eliminar/{id}")
    public String doEliminar(@PathVariable("id") Integer id, Model model) {


        this.analistaService.eliminarEstudio(id);
        return "redirect:/analista/";
    }


    @GetMapping("/info/{id}")
    public String toInfo(@PathVariable ("id") Integer id, Model model){
        EstudioDTO estudioDTO=this.analistaService.findByIdDTO(id);
        UsuarioDTO usuarioDTO = this.analistaService.findByCorreoUsuarioDTO(estudioDTO.getCorreo());

        model.addAttribute("estudio",estudioDTO);
        model.addAttribute("usuario",usuarioDTO);
        return "InfoEstudio";
    }

    @GetMapping("/modificar/{id}")
    public String toModificar(@PathVariable ("id") Integer id, Model model){
        EstudioDTO estudio =this.analistaService.findByIdDTO(id);
        model.addAttribute("estudio",estudio);
        EstudioDTO estudioDTO = new EstudioDTO();
        estudioDTO.setId(estudio.getId());
        //estudioDTO.setCorreo(estudio.getAnalista().getCorreo());
        estudioDTO.setDescripcion(estudio.getDescripcion());
        estudioDTO.setResultado(estudio.getResultado());
        model.addAttribute("estudioDTO",estudioDTO);
        return "EditarEstudio";
    }

    @GetMapping("/crear")
    public String toCrear(Model model){

        model.addAttribute("eventos",this.analistaService.findAllEventos());
        EstudioDTO estudioDTO = new EstudioDTO();
        model.addAttribute("estudioDTO",estudioDTO);
        return "CrearEstudio";

    }

    @PostMapping("/crearDTO")
    public String doGuardar(Model model, @ModelAttribute("estudioDTO") EstudioDTO estudioDTO,HttpSession session){

        this.analistaService.doGuardarEstudio(model,estudioDTO,session);

        return "redirect:/analista/";
    }

    @PostMapping("/modiDTO")
    public String doModi(Model model, @ModelAttribute("estudioDTO") EstudioDTO estudioDTO){

        //this.analistaService.doGuardarEstudio();
        return "redirect:/analista/";
    }
}


