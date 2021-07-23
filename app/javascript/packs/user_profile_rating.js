const starTotal = 5;
let rating = 4.6
const starPercentage = (rating / starTotal) * 100;
const starPercentageRounded = `${(Math.round(starPercentage))}%`;
document.querySelector('.stars-inner').style.width = starPercentageRounded; 


