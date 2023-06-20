// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Ballot {

  struct Voter {
    uint weight; // el peso se acumula mediante delegación
    bool voted;  // si es verdadero, la persona ya votó
    address delegate; // persona a la que se delega
    uint vote;   // índice de la propuesta votada
  }
  
  struct Proposal {
    // Si puedes limitar la longitud a un número determinado de bytes,
    // siempre usa uno de bytes1 a bytes32, ya que son mucho más baratos
    bytes32 name;   // nombre corto (hasta 32 bytes)
    uint voteCount; // número de votos acumulados
  }

  address public chairperson;

  mapping(address => Voter) public voters;

  Proposal[] public proposals;

  /** 
  * @dev Crea una nueva votación para elegir una de las 'proposalNames'.
  * @param proposalNames nombres de las propuestas
  */
  constructor(bytes32[] memory proposalNames) {
    chairperson = msg.sender;
    voters[chairperson].weight = 1;
    
    for (uint i = 0; i < proposalNames.length; i++) {
      // 'Proposal({...})' crea un objeto temporal
      // Proposal y 'proposals.push(...)'
      // lo agrega al final de 'proposals'.
      proposals.push(Proposal({
          name: proposalNames[i],
          voteCount: 0
      }));
    }
  }

  /** 
  * @dev Otorga a 'voter' el derecho a votar en esta votación. Solo puede ser llamada por el 'chairperson'.
  * @param voter dirección del votante
  */
  function giveRightToVote(address voter) public {
    require(
      msg.sender == chairperson,
      "Solo el chairperson puede otorgar el derecho a votar."
    );
    require(
      !voters[voter].voted,
      "El votante ya ha votado."
    );
    require(voters[voter].weight == 0);
    voters[voter].weight = 1;
  }

  /**
  * @dev Delega tu voto al votante 'to'.
  * @param to dirección a la que se delega el voto
  */
  function delegate(address to) public {
    Voter storage sender = voters[msg.sender];
    require(!sender.voted, "Ya has votado.");
    require(to != msg.sender, "La auto-delegacion no esta permitida.");
    
    while (voters[to].delegate != address(0)) {
      to = voters[to].delegate;
      
      // Se encontró un bucle en la delegación, no está permitido.
      require(to != msg.sender, "Se encontro un bucle en la delegacion.");
    }
    sender.voted = true;
    sender.delegate = to;
    Voter storage delegate_ = voters[to];
    if (delegate_.voted) {
      // Si el delegado ya ha votado,
      // se añade directamente al número de votos
      proposals[delegate_.vote].voteCount += sender.weight;
    } else {
      // Si el delegado aún no ha votado,
      // se añade a su peso.
      delegate_.weight += sender.weight;
    }
  }

  /**
  * @dev Da tu voto (incluidos los votos delegados a ti) a la propuesta 'proposals[proposal].name'.
  * @param proposal índice de la propuesta en el array proposals
  */
  function vote(uint proposal) public {
    Voter storage sender = voters[msg.sender];
    require(sender.weight != 0, "No tienes derecho a votar");
    require(!sender.voted, "Ya has votado.");
    sender.voted = true;
    sender.vote = proposal;
    
    // Si 'proposal' está fuera del rango del array,
    // esto generará automáticamente una excepción y revertirá todos
    // los cambios.
    proposals[proposal].voteCount += sender.weight;
  }

  /** 
  * @dev Calcula la propuesta ganadora teniendo en cuenta todos los votos anteriores.
  * @return winningProposal_ índice de la propuesta ganadora en el array proposals
  */
  function winningProposal() public view returns (uint winningProposal_) {
    uint winningVoteCount = 0;
    for (uint p = 0; p < proposals.length; p++) {
      if (proposals[p].voteCount > winningVoteCount) {
        winningVoteCount = proposals[p].voteCount;
        winningProposal_ = p;
      }
    }
  }

  /** 
  * @dev Llama a la función winningProposal() para obtener el índice del ganador contenido en el array proposals y luego
  * @return winnerName_ el nombre del ganador
  */
  function winnerName() public view returns (bytes32 winnerName_) {
    winnerName_ = proposals[winningProposal()].name;
  }
}