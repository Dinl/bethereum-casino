pragma solidity ^0.4.11;

contract Casino {
	address owner;
	uint public minimumBet;
	uint public totalBet;
	uint public numberOfBets;
	uint public maxAmountOfBets = 5;
	address[] players;

	struct Player {
		uint amountBet;
		uint numberSelected;
	}
	mapping(address => Player) playerInfo;

	function Casino(uint _minimumBet) public{
		owner = msg.sender;
		if(_minimumBet != 0 ) minimumBet = _minimumBet;
	}
	function kill() public{
		if(msg.sender == owner)
		selfdestruct(owner);
	}

	// To bet for a number between 1 and 10 both inclusive
	function bet(uint number) payable public{
		assert(checkPlayerExists(msg.sender) == false);
		assert(number >= 1 && number <= 10);
		assert(msg.value >= minimumBet);
		playerInfo[msg.sender].amountBet = msg.value;
		playerInfo[msg.sender].numberSelected = number;
		numberOfBets += 1;
		players.push(msg.sender);
		totalBet += msg.value;

		if(numberOfBets >= maxAmountOfBets) generateNumberWinner();
	}

	function checkPlayerExists(address player) public constant returns(bool) {
		for(uint i = 0; i < players.length; i++){
			if(players[i] == player) return true;
		}
		return false;
	}

	// Generates a number between 1 and 10
	function generateNumberWinner() private{
		uint numberGenerated = block.number % 10 + 1; // This isn't secure
		distributePrizes(numberGenerated);
	}

	// Sends the corresponding ether to each winner depending on the total bets
	function distributePrizes(uint numberWinner) private{
		address[100] memory winners; // We have to create a temporary in memory array with fixed size
		uint count = 0; // This is the count for the array of winners
		for(uint i = 0; i < players.length; i++){
			address playerAddress = players[i];
			if(playerInfo[playerAddress].numberSelected == numberWinner){
				winners[count] = playerAddress;
				count++;
			}
			delete playerInfo[playerAddress]; // Delete all the players
		}
		players.length = 0; // Delete all the players array
		uint winnerEtherAmount = totalBet / winners.length; // How much each winner gets
		for(uint j = 0; j < count; j++){
			if(winners[j] != address(0)) // Check that the address in this fixed array is not empty
			winners[j].transfer(winnerEtherAmount);
		}
		resetData();
	}
	
	function resetData() private{
        players.length = 0; // Delete all the players array
        totalBet = 0;
        numberOfBets = 0;
    }

	// Fallback function in case someone sends ether to the contract so it doesn't get lost
   function() payable public {}
}