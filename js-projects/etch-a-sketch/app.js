const containerDiv = document.querySelector('.container');
var style = window.getComputedStyle ? getComputedStyle(containerDiv, null) : containerDiv.currentStyle;
const containerWidth = 1000;
const containerHeight = 1000;
var promptSquares = prompt("For grid enter number from to 100!");
var intSquares = parseInt(promptSquares);
startFn(intSquares);

const resetBtn = document.querySelector('.reset-button');
resetBtn.addEventListener('click', function(){
  resetFn();
  var promptNewSquares = prompt("For grid enter number from to 100!");
  var intNewSquares = parseInt(promptNewSquares);
  startFn(intNewSquares);
});

function resetFn(){
  containerDiv.innerHTML = "";
}

function startFn(intSquares){
  for(var i = 0; i < intSquares; i++){
    for(var j = 0; j < intSquares; j++){
      var sqDiv = document.createElement('div');
      sqDiv.setAttribute('style', 'width: '+ (containerWidth)/intSquares + 'px; height: ' + (containerHeight)/intSquares + 'px;');
      sqDiv.classList.add('sq-div');
      containerDiv.appendChild(sqDiv);
    }
  }
  var sqDivAll = document.querySelectorAll('.sq-div');
  sqDivAll.forEach(function(sqDivMember){
    sqDivMember.addEventListener('mouseover', function(){
      var randomR = Math.ceil(255 * Math.random());
      var randomG = Math.ceil(255 * Math.random());
      var randomB = Math.ceil(255 * Math.random());
      sqDivMember.style.background = "rgb(" + randomR +", "+randomG+", "+randomB+")";
    });
  });
}