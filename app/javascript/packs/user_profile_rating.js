const element = document.getElementById("ave-rating");
let rating = element.dataset.averating;
const starTotal = 5;

const starPercentage = (rating / starTotal) * 100;
const starPercentageRounded = `${(Math.round(starPercentage))}%`;
document.querySelector('.stars-inner').style.width = starPercentageRounded;
console.log(starPercentageRounded) 


