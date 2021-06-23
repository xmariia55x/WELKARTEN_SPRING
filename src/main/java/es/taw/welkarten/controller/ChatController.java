package es.taw.welkarten.controller;

import es.taw.welkarten.dto.ConversacionDTO;
import es.taw.welkarten.dto.MensajeDTO;
import es.taw.welkarten.dto.UsuarioDTO;
import es.taw.welkarten.model.ChatMessage;
import es.taw.welkarten.service.ConversacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpSession;

@Controller
public class ChatController {
    ConversacionService conversacionService;

    public ConversacionService getConversacionService() {
        return conversacionService;
    }

    @Autowired
    public void setConversacionService(ConversacionService conversacionService) {
        this.conversacionService = conversacionService;
    }

    @MessageMapping("/chat.register")
    @SendTo("/topic/public")
    public ChatMessage register(@Payload ChatMessage chatMessage, SimpMessageHeaderAccessor headerAccessor) {
        headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
        return chatMessage;
    }

    @MessageMapping("/chat.send")
    @SendTo("/topic/public")
    public ChatMessage sendMessage(@Payload ChatMessage chatMessage) {
        //ConversacionDTO c = (ConversacionDTO) session.getAttribute("conversacion");
        //UsuarioDTO usuario = (UsuarioDTO) session.getAttribute("usuario");
        //this.conversacionService.guardarMensaje(c.getId(),usuario.getId(), chatMessage.getContent());
        return chatMessage;
    }
}
