## Exercises: "Wait a time."

Dificult: 
    
1. Múltiples tipos de token
    Task: Permitir que el contrato de vesting pueda manejar múltiples tipos de tokens, no solo el token específico que se definió en el constructor.
		- Agrega una función pública llamada setCurrency que permita solo al owner cambiar el token manejado por el contrato de vesting.
		- Agrega una función pública llamada setCurrency que permita al owner cambiar el token manejado por el contrato de vesting.
        - Ten cuidado con los problemas que podria ocacionar cambiar el token, con vesting ya en marcha.
		
2.  Completar la función removeAccounts
    Task: Permitir al owner del contrato eliminar cuentas registradas antes de que comience el vesting.
		- Asegúrate de que el estado del vesting no haya comenzado y que solo el owner pueda llamar a esta función.
