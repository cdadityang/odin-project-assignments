function add(a,b){
  return a + b;
}

function subtract(a,b){
  return a - b;
}

function multiply(a,b){
  return a * b;
}

function divide(a,b){
  return a / b;
}

function operate(op, a, b){
  if(op == "add") return add(a,b)
  else if(op == "subtract") return subtract(a,b)
  else if(op == "multiply") return multiply(a,b)
  else if(op == "divide") return divide(a,b)
}

var numberKeys = document.querySelectorAll(".num-key");
var operaterKeys = document.querySelectorAll(".op-key");
var equalKey = document.querySelector(".eq-key");
var clearKey = document.querySelector(".clear-key");
var decimalKey = document.querySelector('.dec-key');
var backKey = document.querySelector('.back-key');
var screenText = document.querySelector(".screen");
var numberClickValue;
var operaterClickValue;
var firstValue;
var secondValue;
var finalAnswer = 0;
var operatorValue;

screenText.innerText = ""

numberKeys.forEach((num) => {
	num.addEventListener('click', (e) => {
    numberClickValue = e.target.innerText;
    screenText.innerText += numberClickValue
	});
});

decimalKey.addEventListener('click', (e)=> {
  e.target.setAttribute('disabled', true);
});

operaterKeys.forEach((opKey) => {
  opKey.addEventListener('click', (e) => {
    decimalKey.removeAttribute('disabled');
    if(finalAnswer == 0){
      firstValue = screenText.innerText;
    }
    else{
      firstValue = finalAnswer.toString();
      finalAnswer = 0;
      secondValue = 0;
      screenText.innerText = `${firstValue} `
    }
    operatorValue = e.target.attributes[1].nodeValue
    operaterClickValue = e.target.innerText;
    screenText.innerText += operaterClickValue;
  });
});

equalKey.addEventListener('click', (e) => {
  secondValue = screenText.innerText.slice(firstValue.length + 1)
  firstValue = parseFloat(firstValue);
  secondValue = parseFloat(secondValue);
  finalAnswer = operate(operatorValue, firstValue, secondValue);
  if(finalAnswer == Infinity || isNaN(finalAnswer) == true){
    screenText.innerText = "Error: Press C and start again"
  }
  else{
    backKey.setAttribute('disabled', true);
    decimalKey.setAttribute('disabled', true);
    finalAnswer = Math.round(finalAnswer * 100)/100;
    finalAnswer = finalAnswer.toString();
    screenText.innerText += " = "
    screenText.innerText += finalAnswer;
  }
});

clearKey.addEventListener('click', (e) => {
  screenText.innerHTML = ""
  firstValue = 0
  secondValue = 0
  finalAnswer = 0
  decimalKey.removeAttribute('disabled');
  backKey.removeAttribute('disabled');
});

backKey.addEventListener('click', (e) => {
  screenText.innerText = screenText.innerText.slice(0, screenText.innerText.length - 1)
});