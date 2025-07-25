
document.addEventListener('DOMContentLoaded', function () {
  const input = document.getElementById('search-input');


  if (!input) return;

  let lastSent = '';

  input.addEventListener('keyup', function (event) {
    const query = input.value.trim();
    const searchMessage = document.getElementById('search-message');
    const wordMessage = document.getElementById('last-word-message');

    if (event.key === ' ') {
      if (query) {
        const logItem = document.createElement('div');

        if (wordMessage.children.length >= 3) {
          wordMessage.removeChild(wordMessage.lastChild);
        }

        logItem.textContent = query;
        wordMessage.insertBefore(logItem, wordMessage.firstChild);
      }
    }

    if (event.key) {
      searchMessage.innerHTML = '';
    }


    if (event.key === 'Enter') {
      searchMessage.textContent = `Your search is: "${query}"`;
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
