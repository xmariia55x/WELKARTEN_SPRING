# WELKARTEN_SPRING
<h4>
Proyecto realizado por:

Javier Blanco Navarro

Adrián Corrales Moreno

María Gálvez Manceras

David Gerena Comino

Yeray Ruiz Suárez

</h4>

- - -
## 1 Requisitos implementados
Se trata de una aplicación web para la gestión de eventos, similar a Evenbrite (www.eventbrite.es). Esta aplicación 
permitirá publicar eventos de pago o gratuitos, de forma que un usuario podría reservar entradas para ese evento. 
Los requisitos son:

Creador de eventos:
- Un creador podrá crear eventos que contendrán: título del evento, descripción, fecha del evento, fecha hasta la que se pueden reservar entradas, coste de la entrada, aforo del evento, máximo numero de entradas que se pueden adquirir por usuario, etiquetas que caracterizan al evento, etc. En caso de que se decida que el evento tiene asientos fijos asignados, habrá que indicar la configuración del aforo (número de filas y asientos por fila). 
- Un creador podrá editar eventos creados anteriormente.
- Un creador podrá listar los eventos que ha creado.
- Un creador podrá eliminar un evento.
- Un creador podrá buscar eventos según el nombre, precio y aforo.
- Un creador podrá filtrar los eventos disponibles en el sistema.

Administrador del sistema:
- Un administrador creará todos los usuarios del sistema, a excepción de los usuarios de eventos que podrán registrarse ellos mismos en la aplicación.
- Un administrador podrá crear un usuario del sistema.
- Un administrador podrá listar los usuarios del sistema.
- Un administrador podrá actualizar la información de los usuarios del sistema.
- Un administrador podrá eliminar un usuario del sistema.
- Un administrador podrá buscar usuarios por su nombre.
- Un administrador podrá filtrar usuarios por su rol.
- Un administrador podrá crear un evento en el sistema.
- Un administrador podrá listar los eventos del sistema.
- Un administrador podrá actualizar la información de los eventos del sistema.
- Un administrador podrá eliminar un evento del sistema.
- Un administrador podrá buscar eventos por su nombre.
- Un administrador podrá filtrar eventos por etiquetas.

Usuario de eventos: 
- Un usuario de eventos podrá registrarse a través de la aplicación. Deberá indicar información personal como nombre, apellidos, domicilio, ciudad de residencia, edad, sexo...
- Un usuario de eventos podrá ver la información de un evento.
- Un usuario de eventos podrá adquirir entradas (con asientos o no) de un evento. También podrá seleccionar los asientos que estén disponibles.
- Un usuario de eventos podrá listar los eventos a los que va a asistir, ha asistido o tiene reserva.
- Un usuario de eventos podrá modificar la entrada o el asiento del evento.
- Un usuario de eventos podrá eliminar un evento de sus eventos.
- Un usuario de eventos podrá filtrar sus eventos según el nombre.

Teleoperadores:
- Un teleoperador permitirá que un usuario de eventos se comunique con ellos directamente a través de un chat.
- Un teleoperador podrá enviar mensajes al chat.
- Un teleoperador podrá listar las conversaciones de todos los teleoperadores.
- Un teleoperador podrá leer el contenido de una conversación.
- Un teleoperador podrá volver a abrir una conversación existente.
- Un teleoperador podrá eliminar una conversación.
- Un teleoperador podrá buscar y filtrar conversaciones. 
- Un teleoperador podrá aceptar una petición de conversación. 
- Un teleoperador podrá visualizar la lista de peticiones de conversación. 

Analistas de eventos:
- Un analista de eventos podrá diseñar estudios estadísticos sobre los datos de la BD y almacenarlos. 
- Un analista de eventos podrá visualizar los estudios que tiene diseñados y acceder a los datos resultantes.
- Un analista de eventos podrá crear una copia de un estudio y realizar modificaciones sobre él, como si se tratara de uno nuevo. 
- Un analista de eventos podrá listar todos los estudios que tiene diseñados.
- Un analista de eventos podrá editar los estudios que tiene diseñados.
- Un analista de eventos podrá borrar los estudios que tiene diseñados.

## 2 Tecnología empleada
