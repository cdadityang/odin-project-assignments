let a = []
var removeFromArray = function(...args) {
  for (var i = 1; i < args.length; i++) {
    if(args[0].includes(args[i])){
      let index = args[0].indexOf(args[i])
      args[0].splice(index, 1)
    }
    a = args[0]
  }
  return a
}

module.exports = removeFromArray
