# Exercises: "Modifie the message"

Dificult: Basic

### 1. Establecer límite mínimo y máximo**
**Objective: Añadir restricciones para evitar que el contador se salga de ciertos límites.**
        - Agrega dos variables de estado: uint256 private minCount y uint256 private maxCount.
        - Modifica las funciones incrementCount y decrementCount para que solo aumenten o disminuyan count si el resultado permanece dentro de los límites minCount y maxCount.
        - Crea funciones para permitir al propietario del contrato cambiar los valores de minCount y maxCount.


### 2: Agregar función de reseteo
**Objetivo: Permitir al propietario restablecer el contador a un valor específico.**  
		- Agrega una función llamada resetCount que acepte un argumento uint256 llamado newValue.
		- Esta función debería permitir que solo el propietario del contrato restablezca el contador (count) al valor newValue.