package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Entrada;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface EntradaRepository extends JpaRepository<Entrada, Integer> {

    @Query("SELECT e.numero FROM Entrada e WHERE e.evento.id = :eventoId")
    public List<Integer> findByListaDeEntradaNumeroDeUnEvento(@Param("eventoId") Integer eventoId);

    @Query("SELECT MAX(e.numero) FROM Entrada e WHERE e.evento.id = :eventoId")
    public Integer maxNumeroDeUnEvento(@Param("eventoId") Integer eventoId);
}
