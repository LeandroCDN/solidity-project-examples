## Exercises: "my tokens are your tokens"

Dificult: 
    
  1. Agregar función para retirar fondos
    Task: Permitir al propietario del contrato retirar fondos sobrantes que no se han reclamado en el grifo.
		- Agrega una función pública llamada withdrawFunds que permita al owner retirar los fondos que no se han reclamado en el grifo.
		- Asegúrate de que solo el owner pueda llamar a esta función y que los fondos se envíen a la dirección del owner.
		
  2. Agregar función para pausar/reanudar el grifo
    Task: Permitir al owner pausar o reanudar la funcionalidad del grifo para evitar que se realicen reclamaciones durante un período de tiempo.
		- Puedes usar la libreria de openzeppelin especificamente para esto
		- Agrega una variable de estado llamada isFaucetPaused para controlar el estado del grifo 
        - Modifica la función claim para que solo se puedan realizar reclamaciones si el grifo no está pausado.

  3. Agregar función para cambiar el token del grifo
    Task: Permitir al owner cambiar el token manejado por el contrato de grifo.
        - Agrega una función pública llamada setToken que permita al owner cambiar el token manejado por el contrato de grifo.
        - Asegúrate de que solo el owner pueda llamar a esta función y que el nuevo token sea una dirección válida de token.