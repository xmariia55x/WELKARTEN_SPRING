/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.taw.welkarten.entity;

import es.taw.welkarten.dto.EtiquetaDTO;
import es.taw.welkarten.dto.EtiquetaseventoDTO;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author yeray
 */
@Entity
@Table(name = "ETIQUETA")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Etiqueta.findAll", query = "SELECT e FROM Etiqueta e")
    , @NamedQuery(name = "Etiqueta.findById", query = "SELECT e FROM Etiqueta e WHERE e.id = :id")
    , @NamedQuery(name = "Etiqueta.findByNombre", query = "SELECT e FROM Etiqueta e WHERE e.nombre = :nombre")})
public class Etiqueta implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @Basic(optional = false)

    @Column(name = "NOMBRE", nullable = false, length = 50)
    private String nombre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "etiqueta")
    private List<Etiquetasevento> etiquetaseventoList;

    public Etiqueta() {
    }

    public Etiqueta(Integer id) {
        this.id = id;
    }

    public Etiqueta(Integer id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @XmlTransient
    public List<Etiquetasevento> getEtiquetaseventoList() {
        return etiquetaseventoList;
    }

    public void setEtiquetaseventoList(List<Etiquetasevento> etiquetaseventoList) {
        this.etiquetaseventoList = etiquetaseventoList;
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
        if (!(object instanceof Etiqueta)) {
            return false;
        }
        Etiqueta other = (Etiqueta) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "GestorEventos2021.entity.Etiqueta[ id=" + id + " ]";
    }

    @Transient
    public EtiquetaDTO getDTO(){
        EtiquetaDTO dto = new EtiquetaDTO();

        dto.setId(this.getId());
        dto.setNombre(this.getNombre());

        /*
        List<EtiquetaseventoDTO> lista = new ArrayList<>();
        for(Etiquetasevento etq : this.getEtiquetaseventoList()){
            lista.add(etq.getDTO());
        }

        dto.setEtiquetaseventoList(lista);
        */
        return dto;
    }
}
