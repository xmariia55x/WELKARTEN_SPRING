package es.taw.welkarten.controller;

import es.taw.welkarten.dao.EventoRepository;
import es.taw.welkarten.dao.UsuarioRepository;
import es.taw.welkarten.dto.*;
import es.taw.welkarten.entity.Conversacion;
import es.taw.welkarten.entity.Etiqueta;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.service.*;
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
    private BusquedaAvanzadaService busquedaAvanzadaService;
    private EtiquetaService etiquetaService;
    private UsuarioService usuarioService;
    @Autowired
    public void setUsuarioService(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @Autowired
    public void setEtiquetaService(EtiquetaService etiquetaService) {
        this.etiquetaService = etiquetaService;
    }

    @Autowired
    public void setBusquedaAvanzadaService(BusquedaAvanzadaService busquedaAvanzadaService) {
        this.busquedaAvanzadaService = busquedaAvanzadaService;
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
        List<EventoDTO> listaEventosPropios = this.eventoService.findByCreador(usuario.getId());
        List<EventoDTO> listaEventosEstaSemana = this.eventoService.findEventosEstaSemana();
        List<UsuarioDTO> creadores = this.usuarioService.findCreadores();

        List<EventoDTO> eventosFiltrados = this.busquedaAvanzadaService.findByBusquedaAvanzada(busqueda.getNombre(), busqueda.getAforo(), busqueda.getPrecio(), busqueda.getCreador());

        model.addAttribute("eventosFiltrados", eventosFiltrados);
        model.addAttribute("busqueda", busqueda);
        model.addAttribute("eventosProximos", listaEventosEstaSemana);
        model.addAttribute("misEventos", listaEventosPropios);
        model.addAttribute("creadores", creadores);
        return "CreadorEventos";
    }


    @GetMapping("/infoEvento/{id}")
    public String doInfoEvento(@PathVariable("id") Integer id, Model model){
        EventoDTO evento = this.eventoService.findEvento(id);
        model.addAttribute("evento", evento);
        return "InfoEvento";
    }

    @GetMapping("/nuevoEvento")
    public String doNuevoEvento(Model model, String error, Integer id){
        List<EtiquetaDTO> listaEtiquetas = this.etiquetaService.findEtiquetas();
        EventoDTO eventoDTO;
        if(id != null){
            eventoDTO = this.eventoService.getEventoDTO(id);
            Boolean editar = true;
            model.addAttribute("editar", editar);
        } else {
            eventoDTO = new EventoDTO();
        }


        if(error != null) {
            model.addAttribute("error", error);
        }

        model.addAttribute("etiquetas", listaEtiquetas);
        model.addAttribute("eventoDTO", eventoDTO);
        return "CrearEditarEventoCreador";
    }

    @GetMapping("/eliminarEvento/{id}")
    public String doBorrar (@PathVariable("id") Integer id) {
        this.eventoService.eliminarEvento(id);
        return "redirect:/creadoreventos/";
    }

    @PostMapping("/guardar")
    public String doGuardar (Model model, @ModelAttribute("eventoDTO") EventoDTO eventoDTO, HttpSession session) {

        String strError = "";
        UsuarioDTO creador = (UsuarioDTO) session.getAttribute("usuario");
        if(eventoDTO.getSeleccionAsientos().equals("S")){
            if(eventoDTO.getFilas() == null && eventoDTO.getAsientosFila() == null){
                strError = "seleccionIncorrecta";
                return doNuevoEvento(model, strError, eventoDTO.getId());
            }
        } else if (eventoDTO.getSeleccionAsientos().equals("N")){
            if(eventoDTO.getFilas() != null && eventoDTO.getAsientosFila() != null){
                strError = "seleccionIncorrecta";
                return doNuevoEvento(model, strError, eventoDTO.getId());
            }
        }
        if (eventoDTO.getFechaReservaString().compareTo(eventoDTO.getFechaInicioString()) > 0){
            strError = "fechasIncorrectas";
            return doNuevoEvento(model, strError, eventoDTO.getId());
        }  else if (eventoDTO.getEtiquetas().size() < 1 || eventoDTO.getEtiquetas().size() > 2){
            strError = "etiquetasIncorrectas";
            return doNuevoEvento(model, strError, eventoDTO.getId());
        } else {
            //this.eventoService.guardarEvento(eventoDTO, eventoDTO.getEtiquetaseventoList());
            this.eventoService.guardarEvento(eventoDTO, creador);
            return "redirect:/creadoreventos/";

        }
    }

    @GetMapping("/editarEvento/{id}")
    public String doRedirigirEditarEvento(@PathVariable("id") Integer id, Model model){
        EventoDTO eventoDTO = this.eventoService.getEventoDTO(id);
        Boolean editar = true;
        List<EtiquetaDTO> listaEtiquetas = this.etiquetaService.findEtiquetas();
        model.addAttribute("etiquetas", listaEtiquetas);
        model.addAttribute("eventoDTO", eventoDTO);
        model.addAttribute("editar", editar);
        return "CrearEditarEventoCreador";
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
