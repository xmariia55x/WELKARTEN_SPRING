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
}
