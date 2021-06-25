package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Etiquetasevento;
import es.taw.welkarten.entity.Evento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EtiquetaseventoRepository extends JpaRepository<Etiquetasevento, Integer> {
    @Query("SELECT e from Etiquetasevento  e where  e.evento.id = :id")
    public List<Etiquetasevento> getEtiquetasEventoById(@Param("id") Integer id);
}
