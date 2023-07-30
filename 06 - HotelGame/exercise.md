## Exercises: "That hotel!"

*El contrato "TheHotelGame" es un juego basado en Solidity que permite a los usuarios administrar hoteles y ganar recompensas*

Dificult: medium
    
    1. Agregar un límite de tiempo para vender hoteles
    Task: Restringir la venta de hoteles para que solo se pueda realizar después de cierto tiempo de propiedad.
		- Agrega una variable de estado llamada saleLockTime para definir el tiempo mínimo de propiedad (en segundos) antes de que se pueda vender un hotel.
		- Modifica la función sellHotel para que solo permita vender un hotel si el usuario ha sido dueño del hotel durante al menos saleLockTime segundos
		
	2.  Agregar un evento para notificar la venta de un hotel
    Task: Agregar un evento que se emita cada vez que se vende un hotel.
		- Agrega un evento llamado HotelSold que incluya información relevante sobre la venta del hotel, como el usuario que vendió el hotel y el dinero recibido.