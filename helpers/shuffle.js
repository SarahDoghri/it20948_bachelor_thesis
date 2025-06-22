function shuffleAnswers(el) {
    const answers = Array.from(el.querySelectorAll('.multiple-choice-answer'));
  
    // Shuffle the answers array
    for (let i = answers.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [answers[i], answers[j]] = [answers[j], answers[i]];
    }
  
    // Clear the existing answers from the el
    while (el.firstChild) {
      el.removeChild(el.firstChild);
    }
  
    // Append the shuffled answers back to the el
    for (const answer of answers) {
      el.appendChild(answer);
    }
  }

  