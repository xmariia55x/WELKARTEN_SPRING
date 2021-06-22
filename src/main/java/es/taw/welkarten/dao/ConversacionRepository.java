package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Conversacion;
import es.taw.welkarten.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ConversacionRepository extends JpaRepository<Conversacion, Integer> {
    @Query("select c from Conversacion c where c.teleoperador.id = :id")
    List<Conversacion> findPeticionesTeleoperador(@Param("id") Integer id);

    @Query("SELECT c FROM Conversacion c WHERE c.usuario.id = :id")
    List<Conversacion> findPeticionesUsuario(@Param("id") Integer id);

    @Query("SELECT c FROM Conversacion c WHERE c.teleoperador.nombre LIKE CONCAT('%', :filtroTeleoperador, '%') AND c.usuario.nombre LIKE CONCAT('%', :filtroUsuario, '%')")
    List<Conversacion> findConversacionesByTeleoperadorAndUsuario(@Param("filtroTeleoperador") String filtroTeleoperador, @Param("filtroUsuario") String filtroUsuario);

    @Query("SELECT c FROM Conversacion c WHERE c.teleoperador.nombre LIKE CONCAT('%', :filtroTeleoperador, '%')")
    List<Conversacion> findConversacionesByTeleoperador(String filtroTeleoperador);

    @Query("SELECT c FROM Conversacion c WHERE c.usuario.nombre LIKE CONCAT('%', :filtroUsuario, '%')")
    List<Conversacion> findConversacionesByUsuario(String filtroUsuario);
}
