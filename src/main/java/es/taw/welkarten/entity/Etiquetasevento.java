/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.taw.welkarten.entity;

import es.taw.welkarten.dto.EtiquetaseventoDTO;

import java.io.Serializable;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author yeray
 */
@Entity
@Table(name = "ETIQUETASEVENTO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Etiquetasevento.findAll", query = "SELECT e FROM Etiquetasevento e")
    , @NamedQuery(name = "Etiquetasevento.findById", query = "SELECT e FROM Etiquetasevento e WHERE e.id = :id")})
public class Etiquetasevento implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @JoinColumn(name = "ETIQUETA", referencedColumnName = "ID")
    @ManyToOne(optional = false)
    private Etiqueta etiqueta;
    @JoinColumn(name = "EVENTO", referencedColumnName = "ID")
    @ManyToOne(optional = false)
    private Evento evento;

    public Etiquetasevento() {
    }

    public Etiquetasevento(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Etiqueta getEtiqueta() {
        return etiqueta;
    }

    public void setEtiqueta(Etiqueta etiqueta) {
        this.etiqueta = etiqueta;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
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
        if (!(object instanceof Etiquetasevento)) {
            return false;
        }
        Etiquetasevento other = (Etiquetasevento) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "GestorEventos2021.entity.Etiquetasevento[ id=" + id + " ]";
    }

    @Transient
    public EtiquetaseventoDTO getDTO(){
        EtiquetaseventoDTO etiqueta = new EtiquetaseventoDTO();
        etiqueta.setEtiqueta(this.getEtiqueta().getDTO());
        //etiqueta.setEvento(this.getEvento().getDTO());
        etiqueta.setId(this.getId());
        return etiqueta;
    }
}
