var ftoc = function(a) {
  let num = ((5 * (a-32))/9)
  return Math.round(num*10)/10
}

var ctof = function(a) {
  let num = (((9*a)/5)+32)
  return Math.round(num*10)/10
}

module.exports = {
  ftoc,
  ctof
}
