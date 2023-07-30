## Exercises: "Learn basic standar!"

Dificult: Hard
    
    1. Agregar función mint para el owner y establecer un límite máximo de suministro
    Task: Permitir al propietario del contrato "MyToken" (owner) crear nuevos tokens mediante la función mint, y asegurarse de que el suministro total no supere un límite máximo.
		- Agrega una variable de estado llamada maxSupply para definir el límite máximo de suministro de tokens.
		- Implementa una función pública llamada mint que permita al owner crear nuevos tokens y agregarlos al balance de su cuenta.
        - Asegúrate de que el total de tokens creados mediante la función mint no supere el valor de maxSupply.
		
	2.  Agregar un fee de transacción
    Task: Implementar un mecanismo de tarifa de transacción para cada transferencia de tokens realizada en el contrato "MyToken".
		- Agrega una variable de estado llamada transactionFee para definir el porcentaje de tarifa que se aplicará a cada transferencia.
		- Modifica la función transfer para deducir la tarifa de transacción antes de realizar la transferencia y enviar la tarifa al owner del contrato.
        - Puedes hacer este ejercicio haciendo overide de la funcion '_beforeTokenTransfer()"?

    