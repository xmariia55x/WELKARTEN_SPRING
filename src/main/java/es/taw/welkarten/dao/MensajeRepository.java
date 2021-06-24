package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Mensaje;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MensajeRepository extends JpaRepository<Mensaje, Integer> {
    @Query("SELECT m FROM Mensaje m WHERE m.emisor.id = :idEmisor")
    public List<Mensaje> findByEmisor(@Param("idEmisor") Integer idEmisor);
}
