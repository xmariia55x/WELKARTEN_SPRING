/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.taw.welkarten.entity;

import es.taw.welkarten.dto.ConversacionDTO;
import es.taw.welkarten.dto.MensajeDTO;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
import javax.transaction.Transactional;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author yeray
 */
@Entity
@Table(name = "CONVERSACION")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Conversacion.findAll", query = "SELECT c FROM Conversacion c")
    , @NamedQuery(name = "Conversacion.findById", query = "SELECT c FROM Conversacion c WHERE c.id = :id")})
public class Conversacion implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @JoinColumn(name = "TELEOPERADOR", referencedColumnName = "ID")
    @ManyToOne(optional = false)
    private Usuario teleoperador;
    @JoinColumn(name = "USUARIO", referencedColumnName = "ID")
    @ManyToOne(optional = false)
    private Usuario usuario;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "conversacion", fetch = FetchType.EAGER)
    private List<Mensaje> mensajeList;
    
    public Conversacion() {
    }

    public Conversacion(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Usuario getTeleoperador() {
        return teleoperador;
    }

    public void setTeleoperador(Usuario teleoperador) {
        this.teleoperador = teleoperador;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    @XmlTransient
    public List<Mensaje> getMensajeList() {
        return mensajeList;
    }

    public void setMensajeList(List<Mensaje> mensajeList) {
        this.mensajeList = mensajeList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Conversacion)) {
            return false;
        }
        Conversacion other = (Conversacion) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "GestorEventos2021.entity.Conversacion[ id=" + id + " ]";
    }

    @Transient
    public ConversacionDTO getDTO() {
        ConversacionDTO dto = new ConversacionDTO();
        dto.setId(this.getId());
        dto.setTeleoperador(this.getTeleoperador().getDTO());
        dto.setUsuario(this.getUsuario().getDTO());

        //Lista de mensajes
        List<MensajeDTO> lista = new ArrayList<>();
        for(Mensaje m : this.getMensajeList()) {
            lista.add(m.getDTO());
        }
        dto.setMensaje(lista);

        return dto;
    }
    
}
