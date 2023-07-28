## Exercises: "Bugflow"

Dificult: Medium
    
    1. Corregir el error de desbordamiento: *Identificar y corregir el error que causa un desbordamiento en el contrato.*
		A. Actualmente, la función store intenta almacenar un número en la posición length del array number. Sin embargo, esto causará un desbordamiento ya que el índice válido máximo es length - 1.
		B. Corrige el contrato para que se pueda almacenar el número correctamente en el array.
		
	2. Agregar función para obtener informacion del array: *Practicar cómo obtener información sobre la longitud del array desde fuera del contrato.*
		A. Agrega una función pública llamada getArrayLength que permita a cualquiera obtener la longitud actual del array number.
		B. Agregar una funcion publica que retorne el array completo.