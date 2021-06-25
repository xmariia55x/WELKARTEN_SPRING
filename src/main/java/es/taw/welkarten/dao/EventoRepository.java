package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Evento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

public interface EventoRepository extends JpaRepository<Evento, Integer> {
    //Eventos no caducados
    @Query("SELECT e FROM Evento e WHERE e.fechaInicio > :fecha OR (e.fechaInicio = :fecha AND e.hora >= :hora) ORDER BY e.fechaInicio ASC")
    public List<Evento> findByEventosNoCaducados(@Param("fecha") Date fecha, @Param("hora") java.sql.Time hora);

    //Eventos hoy
    @Query("SELECT e FROM Evento e WHERE e.fechaInicio = :fecha")
    public List<Evento> findByEventosHoy(@Param("fecha") Date fecha);

    //Eventos esta semana
    @Query("SELECT e FROM Evento e WHERE e.fechaInicio >= :fechaHoy AND e.fechaInicio <= :fechaSemana ORDER BY e.fechaInicio ASC")
    public List<Evento> findByEventosEstaSemana(@Param("fechaHoy") Date fechaHoy, @Param("fechaSemana") Date fechaSemana);

    @Query("SELECT e FROM Evento e WHERE e.titulo = :titulo")
    public Evento findByTitulo(String titulo);

    //Eventos de un creadorEventos
    @Query("SELECT e FROM Evento e WHERE e.creador.id = :creador")
    public List<Evento> findByCreadorEventos(@Param("creador") Integer creador);

    @Query("SELECT MAX(e.id) FROM Evento e")
    public Integer findMaxId();

    @Query("SELECT DISTINCT e FROM Evento e WHERE e.titulo LIKE :filtro OR e.lugar LIKE :filtro")
    public List<Evento> findByEventosNombreOrLugar(@Param("filtro") String filtro);

    @Query("SELECT e FROM Evento e WHERE e.titulo LIKE %:nombre%")
    List<Evento> findByNombreEvento(@Param("nombre") String nombreEvento);

    @Query("SELECT distinct e FROM Evento e JOIN e.etiquetaseventoList et WHERE e.id = et.evento.id and et.etiqueta.id IN :tag")
    List<Evento> findByEtiquetas(@Param("tag") List<Integer> idEtiquetas);
}
