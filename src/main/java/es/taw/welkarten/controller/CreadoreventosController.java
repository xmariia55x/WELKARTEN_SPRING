package es.taw.welkarten.controller;

import es.taw.welkarten.dao.EventoRepository;
import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.*;
import es.taw.welkarten.entity.Conversacion;
import es.taw.welkarten.entity.Etiqueta;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.service.BusquedaAvanzadaService;
import es.taw.welkarten.service.EtiquetaService;
import es.taw.welkarten.service.EventoService;
import es.taw.welkarten.service.UsuarioeventosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/creadoreventos")
public class CreadoreventosController {



    private EventoService eventoService;

    private UsuarioRepository usuarioRepository;

    private BusquedaAvanzadaService busquedaAvanzadaService;

    private EtiquetaService etiquetaService;

    @Autowired
    public void setEtiquetaService(EtiquetaService etiquetaService) {
        this.etiquetaService = etiquetaService;
    }

    @Autowired
    public void setBusquedaAvanzadaService(BusquedaAvanzadaService busquedaAvanzadaService) {
        this.busquedaAvanzadaService = busquedaAvanzadaService;
    }

    @Autowired
    public void setUsuarioRepository(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Autowired
    public void setEventoService(EventoService eventoService) {
        this.eventoService = eventoService;
    }





    @GetMapping("/")
    public String doCreadorEventos(Model model, HttpSession session) {
        BusquedaAvanzadaEvento busqueda = new BusquedaAvanzadaEvento();
        return this.doBusquedaAvanzada(busqueda, model, session);
    }

    @PostMapping("/busquedaavanzada")
    public String doBusquedaAvanzada(@ModelAttribute("busqueda") BusquedaAvanzadaEvento busqueda, Model model, HttpSession session) {

        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
        List<Evento> listaEventosEstaSemana = this.eventoService.findEventosEstaSemana();
        List<Evento> listaEventosPropios = this.eventoService.findEventosCreadorEventos(usuario.getId());
        List<Usuario> creadores = this.usuarioRepository.findByRol(2);

        List<Evento> eventosFiltrados = this.busquedaAvanzadaService.findByBusquedaAvanzada(busqueda.getNombre(), busqueda.getAforo(), busqueda.getPrecio(), busqueda.getCreador());

        model.addAttribute("eventosFiltrados", eventosFiltrados);
        model.addAttribute("busqueda", busqueda);
        model.addAttribute("eventosProximos", listaEventosEstaSemana);
        model.addAttribute("misEventos", listaEventosPropios);
        model.addAttribute("creadores", creadores);
        return "CreadorEventos";
    }

    @GetMapping("/editarEvento/{id}")
    public String doEditar (@PathVariable("id") Integer id, Model model) {

        EventoDTO evento = this.eventoService.buscarEvento(id);
        List<EtiquetaDTO> etiquetas = this.etiquetaService.findEtiquetas();
        model.addAttribute("etiquetas", etiquetas);
        model.addAttribute("evento", evento);

        return "CrearEditarEventoCreador";
    }

    @GetMapping("/nuevoEvento")
    public String doNuevoEvento (Model model) {
        List<EtiquetaDTO> etiquetas = this.etiquetaService.findEtiquetas();
        EventoDTO evento = new EventoDTO();
        model.addAttribute("evento", evento);
        return "CrearEditarEventoCreador";
    }

    @PostMapping("/guardar")
    public String doGuardar (@ModelAttribute("evento") EventoDTO evento) {
       // this.eventoService.guardarCliente(evento);
        return "redirect:/customer/";
    }


    /*


    @GetMapping("/")
    public String doCreadorEventos(Model model, HttpSession session){



        //Lista de filtro


        model.addAttribute("eventosProximos", listaEventosEstaSemana);
        model.addAttribute("misEventos", listaEventosPropios);
        model.addAttribute("creadores", creadores);


        return"CreadorEventos";
    }

    @PostMapping("/BusquedaAvanzada")
    public String doBusquedaAvanzada(@ModelAttribute Model model){

        return"";
    }


*/

}
