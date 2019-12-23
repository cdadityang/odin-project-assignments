var computerSelection;
function computerPlay(){
  var number = Math.ceil(Math.random()*3);
  if(number==1)
    computerSelection = "rock"
  else if(number == 2)
    computerSelection = "paper"
  else
    computerSelection = "scissors"
  
    return computerSelection;
};

// COmputer = 1, Player = 0, TIe = 2
var winner;
var winnerString;

function playRound(computerSelection, playerSelection){
  if(computerSelection == playerSelection){
    winner = 2;
    winnerString = "Tie";
    return winner;
  }
  if(computerSelection == "rock"){
    if(playerSelection == "scissors"){
      winner = 1;
      winnerString = "Computer Wins";
      return winner;
    }
    else if(playerSelection == "paper"){
      winner = 0;
      winnerString = "Player Wins";
      return winner;
    }
  }
  if(computerSelection == "paper"){
    if(playerSelection == "rock"){
      winner = 1;
      winnerString = "Computer Wins";
      return winner;
    }
    else if(playerSelection == "scissors"){
      winner = 0;
      winnerString = "Player Wins";
      return winner;
    }
  }
  if(computerSelection == "scissors"){
    if(playerSelection == "paper"){
      winner = 1;
      winnerString = "Computer Wins";
      return winner;
    }
    else if(playerSelection == "rock"){
      winner = 0;
      winnerString = "Player Wins";
      return winner;
    }
  }
}
var playerPrompt;
var playerSelection;
var computerScore = 0;
var playerScore = 0;
function game(){
  var i = 0;
  while(i<5){
    computerPlay();
    playerPrompt = prompt("Select your choice", "rock, paper, scissors");
    playerSelection = playerPrompt.toLowerCase();
    console.log("Player: " + playerSelection);
    console.log("Computer: " + computerSelection);
    playRound(computerSelection, playerSelection);
    console.log(winnerString);
    if(winner == 1)
      computerScore += 1
    else if(winner == 0)
      playerScore += 1
    console.log("Player: " + playerScore + ", Computer: " + computerScore);
    i += 1;
  }
  if(playerScore > computerScore)
    return "Finally Player Wins";
  else if(playerScore == computerScore)
    return "Finally Tie";
  else
    return " Finally COmputer Wins";
}
console.log(game());