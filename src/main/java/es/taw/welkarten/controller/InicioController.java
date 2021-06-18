package es.taw.welkarten.controller;

import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.service.EventoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class InicioController {
    private EventoService eventoService;

    @Autowired
    public void setEventoService(EventoService eventoService) {
        this.eventoService = eventoService;
    }

    @GetMapping("/")
    public String doInicio(Model model){
        List<Evento> listaEventos = this.eventoService.findEventosNoCaducados();
        List<Evento> listaEventosHoy = this.eventoService.findEventosHoy();
        List<Evento> listaEventosEstaSemana = this.eventoService.findEventosEstaSemana();

        model.addAttribute("listaEventos", listaEventos);
        model.addAttribute("listaEventosHoy", listaEventosHoy);
        model.addAttribute("listaEventosEstaSemana", listaEventosEstaSemana);

        return "index";
    }
}
