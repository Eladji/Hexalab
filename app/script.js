fetch('https://jsonplaceholder.typicode.com/photos?_limit=50') // Using JSONPlaceholder API, limiting to 50 items
  .then(response => response.json())
  .then(data => {
    // const array = data.items; // Adjust according to your API response structure
    const array = data; // For JSONPlaceholder /photos, the array is the data itself
    array.forEach(element => {
        const card = document.createElement('div');
    card.className = 'card';
    card.onclick = function() { this.classList.toggle('expanded'); };

    const img = document.createElement('img');
    // Use thumbnailUrl for the data-src and url for a higher quality if needed
    img.setAttribute('data-src', element.thumbnailUrl); 
    img.alt = element.title || 'Image'; 
    img.classList.add('lazy'); 
    card.appendChild(img);

    const cardBody = document.createElement('div');
    cardBody.className = 'card-body';

    const title = document.createElement('h3');
    title.className = 'card-title';
    title.textContent = element.title || 'Card Title'; 
    cardBody.appendChild(title);

    const desc = document.createElement('p');
    desc.className = 'card-desc';
    // JSONPlaceholder /photos doesn't have a description, so we'll use the title or a generic one
    desc.textContent = element.title || 'Description for card.'; 
    cardBody.appendChild(desc);

    const author = document.createElement('p');
    author.className = 'card-author';
    // JSONPlaceholder /photos doesn't have an author, so we'll use a generic one or omit
    author.textContent = 'Album ID: ' + element.albumId; 
    cardBody.appendChild(author);

    card.appendChild(cardBody);

    // Append card to a container in your HTML, e.g.:
    const container = document.querySelector('card-container');
    if (container) {
        container.appendChild(card);
    } else {
        console.error("Container with class 'cards-container' not found.");
    }
    });

    // Lazy loading with IntersectionObserver
// ...existing code...
  })