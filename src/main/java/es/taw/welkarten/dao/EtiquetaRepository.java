package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Etiqueta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface EtiquetaRepository extends JpaRepository<Etiqueta, Integer> {
    @Query("SELECT e FROM Etiqueta e WHERE e.nombre = :nombre")
    Etiqueta findByNombre(@Param("nombre") String etq);
}
