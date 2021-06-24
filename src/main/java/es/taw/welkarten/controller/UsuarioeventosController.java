package es.taw.welkarten.controller;

import es.taw.welkarten.dto.EntradaDTO;
import es.taw.welkarten.dto.EventoDTO;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.dto.UsuarioeventosDTO;
import es.taw.welkarten.entity.Entrada;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuario;
import es.taw.welkarten.service.EntradaService;
import es.taw.welkarten.service.EventoService;
import es.taw.welkarten.service.UsuarioeventosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/usuarioeventos")
public class UsuarioeventosController {
    private UsuarioeventosService usuarioeventosService;
    private EventoService eventoService;
    private EntradaService entradaService;

    @Autowired
    public void setEntradaService(EntradaService entradaService) {
        this.entradaService = entradaService;
    }

    @Autowired
    public void setEventoService(EventoService eventoService) {
        this.eventoService = eventoService;
    }

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
            UsuarioDTO usuario = this.usuarioeventosService.guardarUsuarioeventos(usuarioEDTO);
            session.setAttribute("usuario",usuario);
            strTo = "redirect:/";
        } else {
            strError = "v";
            model.addAttribute("error", strError);
            strTo =  "Registro";

        }
        return strTo;
    }

    @GetMapping("/evento/id/{id}")
    public String doInfoEvento(@PathVariable("id") Integer id, Model model){
        EventoDTO evento = this.eventoService.findEvento(id);
        model.addAttribute("evento", evento);
        return "InfoEvento";
    }

    @PostMapping("/evento/comprarTickets")
    public String doComprarTicket(@RequestParam("idEvento") Integer idEvento,
                                  @RequestParam("nEntradas") String nEntradas,
                                  Model model, HttpSession session){
        String strTo = "";
        EventoDTO evento = this.eventoService.findEvento(idEvento);
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");

        if (usuario == null || usuario.getUsuarioeventos() == null) { //No se ha iniciado sesión como usuario de eventos
            strTo = "InicioSesion";
        } else {
            if (evento.getFilas() == null){
                strTo = "ComprarTicketEventoSinAsientos";
            } else {
                List<Integer> listaEntradas = this.entradaService.findListaEntradaGetNumeroDeUnEvento(evento.getId());
                strTo = "ComprarTicketEvento";
                model.addAttribute("listaEntradas", listaEntradas);
            }

            model.addAttribute("evento", evento);
            model.addAttribute("nEntradas", nEntradas);
        }

        return strTo;
    }

    @PostMapping("/evento/guardarTickets")
    public String doGuardarTicket(@RequestParam("idEvento") Integer idEvento,
                                  @RequestParam("nEntradas") Integer nEntradas,
                                  @RequestParam("asientosSeleccionados") String[] seleccionadas,
                                  Model model, HttpSession session){
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
        String strTo = "";
        List<EntradaDTO> listaEntradas = new ArrayList<>();
        EventoDTO evento = this.eventoService.findEvento(idEvento);
        EntradaDTO e;

        if (usuario == null){
            strTo = "InicioSesion";
        } else {
            strTo = "ImprimirTicket";
            if (evento.getFilas() == null) {        //Evento sin asientos
                Integer maxIndice = this.entradaService.findByMaxNumeroDeUnEvento(idEvento);

                if (maxIndice == null) maxIndice = 1;
                else maxIndice++;

                for (int i=0; i < nEntradas; i++){
                    e = new EntradaDTO();
                    e.setEvento(evento);
                    e.setUsuario(usuario);
                    e.setNumero(maxIndice);

                    listaEntradas.add(e);
                    maxIndice++;
                }

            } else {                            //Evento con asientos
                Integer numero;
                for (int i=0; i < nEntradas; i++){
                    numero = Integer.parseInt(seleccionadas[i]);

                    e = new EntradaDTO();
                    e.setEvento(evento);
                    e.setUsuario(usuario);
                    e.setNumero(numero);
                    e.setFila((numero - 1) / evento.getAsientosFila() + 1);
                    e.setAsiento(numero);

                    listaEntradas.add(e);
                }
            }

            this.entradaService.guardarEntradasNuevas(listaEntradas, usuario, evento);

            model.addAttribute("listaEntradas", listaEntradas);
            model.addAttribute("evento", evento);
            model.addAttribute("compra", 1);
        }

        return strTo;
    }

    @GetMapping("/miseventos")
    public String doMisEventos(Model model, HttpSession session){
        UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
        List<EventoDTO> listaEventosRecientes = this.entradaService.listaEventosDeUnUsuarioRecientes(usuario);
        List<EventoDTO> listaEventosFinalizados = this.entradaService.listaEventosDeUnUsuarioFinalizados(usuario);

        model.addAttribute("listaEventosRecientes", listaEventosRecientes);
        model.addAttribute("listaEventosFinalizados", listaEventosFinalizados);

        return "MisEventos";
    }

    @GetMapping("/misentradas/{eventoId}")
    public String doMisEntradas(@PathVariable("eventoId") Integer eventoId, Model model, HttpSession session){
        EventoDTO eventoDTO = this.eventoService.findEvento(eventoId);
        UsuarioDTO usuarioDTO = (UsuarioDTO) session.getAttribute("usuario");
        List<EntradaDTO> listaEntradas = this.entradaService.listaEntradaDeUnUsuarioYEvento(usuarioDTO, eventoDTO);

        model.addAttribute("listaEntradas", listaEntradas);
        model.addAttribute("evento", eventoDTO);
        return "ImprimirTicket";
    }

    @PostMapping("/misentradas/eliminartickets")
    public String doEliminarEntradas(@RequestParam("idEvento") Integer idEvento,
                                     @RequestParam("entradasSeleccionadas") List<Integer> entradasSeleccionadas,
                                     Model model, HttpSession session){
        EventoDTO eventoDTO = this.eventoService.findEvento(idEvento);
        UsuarioDTO usuarioDTO = (UsuarioDTO) session.getAttribute("usuario");

        this.entradaService.eliminarEntradas(entradasSeleccionadas, usuarioDTO, eventoDTO);

        return "redirect:/usuarioeventos/miseventos";
    }

    @PostMapping("/misentradas/modificartickets")
    public String doModificarEntradas(@RequestParam("idEvento") Integer idEvento,
                                     @RequestParam("entradasSeleccionadas") List<Integer> entradasSeleccionadas,
                                     Model model){
        EventoDTO eventoDTO = this.eventoService.findEvento(idEvento);
        List<Integer> listaEntradas = this.entradaService.findListaEntradaGetNumeroDeUnEvento(eventoDTO.getId());
        model.addAttribute("evento", eventoDTO);
        model.addAttribute("listaEntradas", listaEntradas);
        model.addAttribute("entradasSeleccionadas", entradasSeleccionadas);
        return "ModificarAsientos";
    }

    @PostMapping("/misentradas/guardartickets")
    public String doGuardarTicketsEditados(@RequestParam("entradas") List<Integer> entradasIdAntiguas,
                                           @RequestParam("asientosSeleccionados") List<Integer> seleccionados){
        this.entradaService.modificarEntradas(entradasIdAntiguas, seleccionados);
        return "redirect:/usuarioeventos/miseventos";
    }
}
