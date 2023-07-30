## Exercises: "I vote for that"

Dificult: medium
    
    1. Restringir la votación a un período de tiempo específico
    Task: Agregar una funcionalidad para permitir que el presidente de la votación defina un período de tiempo durante el cual se puede votar.
		- Agrega dos variables de estado llamadas votingStartTime y votingEndTime para representar el inicio y el final del período de votación.
		- Modifica la función giveRightToVote para que solo el chairperson pueda otorgar el derecho a votar a los votantes durante el período de votación.
        - Asegúrate de que la función vote solo se pueda llamar durante el período de votación.
		
	2.  Limitar la cantidad de propuestas
    Task: Limitar la cantidad máxima de propuestas que se pueden agregar a la votación.
		- Agrega una variable de estado llamada maxProposals para definir el límite máximo de propuestas.
		- Modifica el constructor para que solo se permita agregar hasta maxProposals propuestas.
        - Asegúrate de que la función vote solo acepte índices de propuestas válidos (de 0 a maxProposals-1).