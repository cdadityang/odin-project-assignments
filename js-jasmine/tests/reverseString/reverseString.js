var reverseString = function(str) {
  let i = str.length;
  let a = str.split("");
  let j = 0;
  let b = []
  while(i){
    b[j] = a[i-1];
    i--;
    j++;
  }
  let c = b.join("");
  return c;
}

module.exports = reverseString