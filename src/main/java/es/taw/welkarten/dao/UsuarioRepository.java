package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    @Query("SELECT u FROM Usuario u WHERE u.correo = :email AND u.password = :password")
    public Usuario findByEmailAndPassword (@Param("email") String email, @Param("password") String password);
}
