package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Estudio;
import es.taw.welkarten.entity.Evento;
import es.taw.welkarten.entity.Usuarioeventos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface EstudioRepository extends JpaRepository<Estudio,Integer> {
    @Query("SELECT u from Usuarioeventos u, Entrada e where e.evento = :ev")
    public List<Usuarioeventos> doResultado(Evento ev);
}
