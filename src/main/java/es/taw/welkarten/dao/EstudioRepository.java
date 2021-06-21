package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Estudio;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EstudioRepository extends JpaRepository<Estudio,Integer> {
}
