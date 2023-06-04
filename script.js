// Array of quotes
const quotes = [
    "The greatest glory in living lies not in never falling, but in rising every time we fall. - Nelson Mandela",
    "The way to get started is to quit talking and begin doing. - Walt Disney",
    "If you set your goals ridiculously high and it's a failure, you will fail above everyone else's success. - James Cameron",
    "It does not matter how slowly you go as long as you do not stop. - Confucius",
    "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
    "The only limit to our realization of tomorrow will be our doubts of today. - Franklin D. Roosevelt",
    "The best time to plant a tree was 20 years ago. The second best time is now. - Chinese Proverb",
    "Believe you can and you're halfway there. - Theodore Roosevelt",
    "I can't change the direction of the wind, but I can adjust my sails to always reach my destination. - Jimmy Dean",
    "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt"
];

// Function to generate a random quote
function generateQuote() {
    const randomIndex = Math.floor(Math.random() * quotes.length);
    const quoteText = document.getElementById("quoteText");
    quoteText.textContent = quotes[randomIndex];
}

// Event listener for the button click
const generateBtn = document.getElementById("generateBtn");
generateBtn.addEventListener("click", generateQuote);

// Initial quote generation
generateQuote();
