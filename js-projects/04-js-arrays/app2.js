const people = [
  { name: 'Wes', year: 1988 },
  { name: 'Kait', year: 1986 },
  { name: 'Irv', year: 1970 },
  { name: 'Lux', year: 2015 }
];

const comments = [
  { text: 'Love this!', id: 523423 },
  { text: 'Super good', id: 823423 },
  { text: 'You are the best', id: 2039842 },
  { text: 'Ramen is my fav food ever', id: 123523 },
  { text: 'Nice Nice Nice!', id: 542328 }
];

// Some and Every Checks
// Array.prototype.some() // is at least one person 19 or older?
// Array.prototype.every() // is everyone 19 or older?
const isAdult = people.some((person) => {
  const currentYear = new Date().getFullYear();
  if(currentYear - person.year >= 19) return true;
});

console.log(isAdult);

const isEvery19 = people.every((person) => {
  const currentYear = new Date().getFullYear();
  if(currentYear - person >= 19) return true;
});

console.log(isEvery19);

// Array.prototype.find()
// Find is like filter, but instead returns just the one you are looking for
// find the comment with the ID of 823423
const commentFind = comments.find((comment) => {
  if(comment.id === 823423) return true;
});

console.log(commentFind);

// Array.prototype.findIndex()
// Find the comment with this ID
// delete the comment with the ID of 823423
const commentIndex = comments.findIndex((comment) => {
  if(comment.id === 823423) return true;
});
console.table(comments);
comments.splice(commentIndex, 1);
console.table(comments);