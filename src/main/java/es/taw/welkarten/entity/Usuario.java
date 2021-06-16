/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.taw.welkarten.entity;

import es.taw.welkarten.dto.UsuarioDTO;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author yeray
 */
@Entity
@Table(name = "USUARIO")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Usuario.findAll", query = "SELECT u FROM Usuario u")
    , @NamedQuery(name = "Usuario.findById", query = "SELECT u FROM Usuario u WHERE u.id = :id")
    , @NamedQuery(name = "Usuario.findByNombre", query = "SELECT u FROM Usuario u WHERE u.nombre = :nombre")
    , @NamedQuery(name = "Usuario.findByNif", query = "SELECT u FROM Usuario u WHERE u.nif = :nif")
    , @NamedQuery(name = "Usuario.findByCorreo", query = "SELECT u FROM Usuario u WHERE u.correo = :correo")
    , @NamedQuery(name = "Usuario.findByPassword", query = "SELECT u FROM Usuario u WHERE u.password = :password")
    , @NamedQuery(name = "Usuario.findByRol", query = "SELECT u FROM Usuario u WHERE u.rol = :rol")})
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "NOMBRE", nullable = false, length=50)
    private String nombre;
    @Basic(optional = false)
    @Column(name = "NIF", nullable = false, length=50)
    private String nif;
    @Basic(optional = false)
    @Column(name = "CORREO", nullable = false, length=50)
    private String correo;
    @Basic(optional = false)
    @Column(name = "PASSWORD", nullable = false, length=50)
    private String password;
    @Basic(optional = false)
    @Column(name = "ROL", nullable = false)
    private int rol;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "teleoperador")
    private List<Conversacion> conversacionList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "usuario")
    private List<Conversacion> conversacionList1;
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "usuario")
    private Usuarioeventos usuarioeventos;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "usuario")
    private List<Entrada> entradaList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "analista")
    private List<Estudio> estudioList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "creador")
    private List<Evento> eventoList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "emisor")
    private List<Mensaje> mensajeList;

    public Usuario() {
    }

    public Usuario(Integer id) {
        this.id = id;
    }

    public Usuario(Integer id, String nombre, String nif, String correo, String password, int rol) {
        this.id = id;
        this.nombre = nombre;
        this.nif = nif;
        this.correo = correo;
        this.password = password;
        this.rol = rol;
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

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRol() {
        return rol;
    }

    public void setRol(int rol) {
        this.rol = rol;
    }

    @XmlTransient
    public List<Conversacion> getConversacionList() {
        return conversacionList;
    }

    public void setConversacionList(List<Conversacion> conversacionList) {
        this.conversacionList = conversacionList;
    }

    @XmlTransient
    public List<Conversacion> getConversacionList1() {
        return conversacionList1;
    }

    public void setConversacionList1(List<Conversacion> conversacionList1) {
        this.conversacionList1 = conversacionList1;
    }

    public Usuarioeventos getUsuarioeventos() {
        return usuarioeventos;
    }

    public void setUsuarioeventos(Usuarioeventos usuarioeventos) {
        this.usuarioeventos = usuarioeventos;
    }

    @XmlTransient
    public List<Entrada> getEntradaList() {
        return entradaList;
    }

    public void setEntradaList(List<Entrada> entradaList) {
        this.entradaList = entradaList;
    }

    @XmlTransient
    public List<Estudio> getEstudioList() {
        return estudioList;
    }

    public void setEstudioList(List<Estudio> estudioList) {
        this.estudioList = estudioList;
    }

    @XmlTransient
    public List<Evento> getEventoList() {
        return eventoList;
    }

    public void setEventoList(List<Evento> eventoList) {
        this.eventoList = eventoList;
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
        if (!(object instanceof Usuario)) {
            return false;
        }
        Usuario other = (Usuario) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "GestorEventos2021.entity.Usuario[ id=" + id + " ]";
    }

    @Transient
    public UsuarioDTO getDTO() {
        UsuarioDTO usuarioDTO = new UsuarioDTO();
        usuarioDTO.setConversacionList(this.getConversacionList());
        usuarioDTO.setCorreo(this.getCorreo());
        usuarioDTO.setEntradaList(this.getEntradaList());
        usuarioDTO.setUsuarioeventos(this.getUsuarioeventos());
        usuarioDTO.setEstudioList(this.getEstudioList());
        usuarioDTO.setId(this.getId());
        usuarioDTO.setConversacionList1(this.getConversacionList1());
        usuarioDTO.setMensajeList(this.getMensajeList());
        usuarioDTO.setNif(this.getNif());
        usuarioDTO.setNombre(this.getNombre());
        usuarioDTO.setPassword(this.getPassword());
        usuarioDTO.setRol(this.getRol());
        return usuarioDTO;
    }
}
