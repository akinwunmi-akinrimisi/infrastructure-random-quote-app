
const quotes = [
    "The best way to predict the future is to invent it.",
    "The only way to do great work is to love what you do.",
    "The only true wisdom is in knowing you know nothing.",
    "You miss 100% of the shots you don’t take.",
    "Believe you can and you’re halfway there.",
    "It does not matter how slowly you go as long as you do not stop.",
    "Success is not final, failure is not fatal, it’s the courage to continue that counts.",
    "If you want to achieve greatness stop asking for permission.",
    "The only limit to our realization of tomorrow will be our doubts of today.",
    "If you don’t build your dream, someone else will hire you to help them build theirs."
  ];

  const colors = [
    "#16a085",
    "#27ae60",
    "#2c3e50",
    "#f39c12",
    "#e74c3c",
    "#9b59b6",
    "#FB6964",
    "#342224",
    "#472E32",
    "#BDBB99",
    "#77B1A9",
    "#73A857"
  ];

  function getRandomQuote() {
      return quotes[Math.floor(Math.random() * quotes.length)];
  }

  function getRandomColor() {
      return colors[Math.floor(Math.random() * colors.length)];
  }

  function setRandomQuote() {
      const quote = document.getElementById("quote");
      const generateButton = document.getElementById("generate");
      const randomQuote = getRandomQuote();
      const randomColor = getRandomColor();

      document.body.style.backgroundColor = randomColor;

      generateButton.style.backgroundColor = randomColor;

      generateButton.style.color = '#fff';

      document.body.style.backgroundImage = `url('https://source.unsplash.com/random')`;

      document.body.style.transition = 'background-image 1s ease-in-out';

      document.body.style.backgroundSize = 'cover';

      document.body.style.backgroundRepeat = 'no-repeat';

      document.body.style.backgroundPosition = 'center center';

      generateButton.style.border = `2px solid ${randomColor}`;

      generateButton.onmouseover = function() {
          this.style.backgroundColor = '#fff';
          this.style.color = randomColor;
          this.style.transition = 'background-color 0.5s ease-in-out';
          this.style.border = `2px solid ${randomColor}`;
      };

      generateButton.onmouseout = function() {
          this.style.backgroundColor = randomColor;
          this.style.color = '#fff';
          this.style.transition = 'background-color 0.5s ease-in-out';
          this.style.border = `2px solid ${randomColor}`;
      };

      generateButton.onclick = function() {
          setRandomQuote();
      };

      return quote.innerHTML = randomQuote; 
  }

  setRandomQuote();