package es.taw.welkarten.dao;

import es.taw.welkarten.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    @Query("SELECT u FROM Usuario u WHERE u.correo = :email AND u.password = :password")
    public Usuario findByEmailAndPassword (@Param("email") String email, @Param("password") String password);

    @Query("SELECT u FROM Usuario u WHERE u.correo = :email")
    public Usuario findByCorreo(@Param("email") String email);

    @Query("SELECT u FROM Usuario u WHERE u.rol = :rol")
    public List<Usuario> findByRol(@Param("rol") Integer rol);

    @Query("SELECT u FROM Usuario u WHERE u.nombre LIKE %:nombre%")
    List<Usuario> findByNombreUsuario(@Param("nombre") String nombreUsuario);

    @Query("SELECT u FROM Usuario u WHERE u.rol IN :roles")
    List<Usuario> findByRolUsuario(@Param("roles") List<Integer> idRol);
}
