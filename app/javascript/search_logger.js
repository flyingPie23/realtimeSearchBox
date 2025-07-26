console.log('Search Logger Initialized');
document.addEventListener('turbo:load', function () {
  const input = document.getElementById('search-input');


  if (!input) return;

  let lastSent = '';

  input.addEventListener('keyup', function (event) {
    const query = input.value.trim();
    const searchMessage = document.getElementById('search-message');
    const wordMessage = document.getElementById('last-word-message');

    if (event.key) {
      searchMessage.innerHTML = '';

      if (query) {
        console.log("Sending query:", query);

        fetch(`/search_suggestions?query=${encodeURIComponent(query)}`)
          .then(response => response.json())
          .then(suggestions => {
            wordMessage.innerHTML = ''; // clear old suggestions
            console.log("Received suggestions:", suggestions);

            suggestions.slice(0, 3).forEach(suggestion => {
              const logItem = document.createElement('div');
              logItem.textContent = suggestion;
              wordMessage.appendChild(logItem);
            });
          })
          .catch(err => console.error('Suggestion fetch error:', err));
      }
    }


    if (event.key === 'Enter') {
      searchMessage.textContent = `Your search was: "${query}"`;
      fetch('/requests', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ query })
      });

      wordMessage.innerHTML = '';
      input.value = ''

    }
  });
});
