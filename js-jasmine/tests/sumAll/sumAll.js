var sumAll = function(a, b) {
  if(typeof(a) != "number" || typeof(b) != "number") return "ERROR";
  if(a < 0 || b<0) return "ERROR";
  if(a > b ){
    let sum = 0;
    for(var i = b; i<=a;i++){
      sum = sum + i;
    }
    return sum;
  }
  if(b > a ){
    let sum = 0;
    for(var i = a; i<=b;i++){
      sum = sum + i;
    }
    return sum;
  }
}

module.exports = sumAll
