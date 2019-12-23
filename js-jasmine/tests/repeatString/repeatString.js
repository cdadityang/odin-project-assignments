var repeatString = function(str, multiple) {
  var repeatedStr = ''
  while(multiple > 0){
    repeatedStr += str
    multiple--;
  }
  if(multiple < 0)
    repeatedStr = "ERROR";
  return repeatedStr;
}

module.exports = repeatString
