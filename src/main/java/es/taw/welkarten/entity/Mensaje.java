/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.taw.welkarten.entity;

import es.taw.welkarten.dto.MensajeDTO;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author yeray
 */
@Entity
@Table(name = "MENSAJE")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Mensaje.findAll", query = "SELECT m FROM Mensaje m")
    , @NamedQuery(name = "Mensaje.findById", query = "SELECT m FROM Mensaje m WHERE m.id = :id")
    , @NamedQuery(name = "Mensaje.findByCuerpo", query = "SELECT m FROM Mensaje m WHERE m.cuerpo = :cuerpo")
    , @NamedQuery(name = "Mensaje.findByFecha", query = "SELECT m FROM Mensaje m WHERE m.fecha = :fecha")
    , @NamedQuery(name = "Mensaje.findByHora", query = "SELECT m FROM Mensaje m WHERE m.hora = :hora")})
public class Mensaje implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @Basic(optional = false)

    @Column(name = "CUERPO", nullable = false, length = 2000)
    private String cuerpo;
    @Basic(optional = false)

    @Column(name = "FECHA", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @Basic(optional = false)

    @Column(name = "HORA", nullable = false)
    @Temporal(TemporalType.TIME)
    private Date hora;
    @JoinColumn(name = "CONVERSACION", referencedColumnName = "ID")
    @ManyToOne(optional = false)
    private Conversacion conversacion;
    @JoinColumn(name = "EMISOR", referencedColumnName = "ID")
    @ManyToOne(optional = false)
    private Usuario emisor;

    public Mensaje() {
    }

    public Mensaje(Integer id) {
        this.id = id;
    }

    public Mensaje(Integer id, String cuerpo, Date fecha, Date hora) {
        this.id = id;
        this.cuerpo = cuerpo;
        this.fecha = fecha;
        this.hora = hora;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCuerpo() {
        return cuerpo;
    }

    public void setCuerpo(String cuerpo) {
        this.cuerpo = cuerpo;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Date getHora() {
        return hora;
    }

    public void setHora(Date hora) {
        this.hora = hora;
    }

    public Conversacion getConversacion() {
        return conversacion;
    }

    public void setConversacion(Conversacion conversacion) {
        this.conversacion = conversacion;
    }

    public Usuario getEmisor() {
        return emisor;
    }

    public void setEmisor(Usuario emisor) {
        this.emisor = emisor;
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
        if (!(object instanceof Mensaje)) {
            return false;
        }
        Mensaje other = (Mensaje) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "GestorEventos2021.entity.Mensaje[ id=" + id + " ]";
    }

    @Transient
    public MensajeDTO getDTO() {
        MensajeDTO dto = new MensajeDTO();
        dto.setId(this.getId());
        dto.setCuerpo(this.getCuerpo());
        dto.setFecha(this.getFecha());
        dto.setHora(this.getHora());
        //dto.setConversacion(this.getConversacion().getDTO());
        dto.setEmisor(this.getEmisor().getDTO());
        return dto;
    }
}
