## Exercises: "my tokens are your tokens"

Dificult: 
    
  1. Agregar metadatos a los tokens
    Task: Permitir que cada token de ERC721 tenga metadatos asociados para representar características únicas.
		- Agrega una variable de estado llamada tokenURI para almacenar las URL base de los metadatos.
		- Modifica la función safeMint para que cada nuevo token tenga un URI único asociado.
        - Agrega una función pública llamada setTokenURI que permita al owner cambiar el URI base de los metadatos.
        - OpenSea tiene una libreria para implementar esto.
		