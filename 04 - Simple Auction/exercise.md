## Exercises: "I buy that"

Dificult: XxX
    
    1. Añadir una función para extender el tiempo de subasta 
    Task: Permitir al beneficiario (dueño) de la subasta extender el tiempo de la subasta si lo desea.*
		A. Agrega una función pública llamada extendAuction que acepte un argumento uint256 llamado extraTime.
		B. Esta función debería permitir que solo el beneficiario (dueño) de la subasta extienda la fecha de finalización de la subasta en extraTime segundos adicionales.
		
	2. Agregar función para finalizar manualmente la subasta. *Permitir al beneficiario finalizar manualmente la subasta en caso de que desee detenerla antes de que expire el tiempo.*
		A. Agrega una función pública llamada endAuctionManually que permita al beneficiario finalizar manualmente la subasta.
		B. Esta función debería transferir el monto de la oferta más alta al beneficiario y emitir el evento AuctionEnded con la información apropiada.