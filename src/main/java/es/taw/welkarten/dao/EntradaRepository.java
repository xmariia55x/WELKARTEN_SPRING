package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Entrada;
import es.taw.welkarten.entity.Evento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

public interface EntradaRepository extends JpaRepository<Entrada, Integer> {

    @Query("SELECT e.numero FROM Entrada e WHERE e.evento.id = :eventoId")
    public List<Integer> findByListaDeEntradaNumeroDeUnEvento(@Param("eventoId") Integer eventoId);

    @Query("SELECT MAX(e.numero) FROM Entrada e WHERE e.evento.id = :eventoId")
    public Integer maxNumeroDeUnEvento(@Param("eventoId") Integer eventoId);

    @Query("SELECT DISTINCT e.evento FROM Entrada e WHERE e.usuario.id = :usuarioId AND :fecha <= e.evento.fechaInicio ORDER BY e.evento.fechaInicio ASC")
    public List<Evento> findByEventosDeUnUsuarioRecientes(@Param("usuarioId") Integer usuarioId, @Param("fecha") Date fecha);

    @Query("SELECT DISTINCT e.evento FROM Entrada e WHERE e.usuario.id = :usuarioId AND :fecha > e.evento.fechaInicio ORDER BY e.evento.fechaInicio ASC")
    public List<Evento> findByEventosDeUnUsuarioFinalizados(@Param("usuarioId") Integer usuarioId, @Param("fecha") Date fecha);

    @Query("SELECT DISTINCT e FROM Entrada e WHERE e.usuario.id = :usuarioId AND e.evento.id = :eventoId ORDER BY e.numero ASC")
    public List<Entrada> findByEntradasDeUnUsuarioyEvento(@Param("usuarioId") Integer usuarioId, @Param("eventoId") Integer eventoId);
}
