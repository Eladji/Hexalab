function loadapi() {
  document.addEventListener("DOMContentLoaded", function () {
    fetch(
      "https://api.sketchfab.com/v3/models?sort_by=createdAt&categories=electronics-gadgets&downloadable=true&restricted=false&archives_flavours=false&offset=19&limit=1"
    )
      .then((response) => response.json())
      .then((data) => {
        // Sketchfab v3 wraps models in `results`
        const models = data.results;
        const container = document.querySelector(".card-container");
        if (!container) {
          console.error("Container with class 'card-container' not found.");
          return;
        }

        models.forEach((model) => {
          const card = document.createElement("div");
          card.className = "card";
          card.onclick = () => card.classList.toggle("expanded");
          // pick the first available thumbnail image
          const thumbUrl = model.thumbnails?.images?.[0]?.url || "";

          const img = document.createElement("img");
          img.dataset.src = thumbUrl;
          img.alt = model.name || "Model thumbnail";
          img.classList.add("lazy");
          card.appendChild(img);

          const body = document.createElement("div");
          body.className = "card-body";

          const title = document.createElement("h3");
          title.className = "card-title";
          title.textContent = model.name || "Untitled";
          body.appendChild(title);

          const desc = document.createElement("p");
          desc.className = "card-desc";
          count = 25;
          var text = "default"
          text = model.description.slice(0, count) + (text.length > count ? "..." : "");
          desc.textContent = text || "No description.";
          body.appendChild(desc);

          const author = document.createElement("p");
          author.className = "card-author";
          author.textContent = `Author: ${model.user.displayName || "Unknown"}`;
          body.appendChild(author);

          const viewBtn = document.createElement("a");
          viewBtn.className = "card-btn";
          viewBtn.href = `https://sketchfab.com/3d-models/${model.uid}`;
          viewBtn.target = "_blank";
          viewBtn.textContent = "View";
          viewBtn.onclick = function (event) {
            event.stopPropagation(); // Prevents the click from bubbling to the card
          };
          body.appendChild(viewBtn);

          body.appendChild(viewBtn);

          card.appendChild(body);
          container.appendChild(card);
        });

        initializeLazyLoading();
      })
      .catch((err) => console.error("Error fetching or processing data:", err));
  });

  function initializeLazyLoading() {
    let lazyImages = Array.from(document.querySelectorAll("img.lazy"));

    if ("IntersectionObserver" in window) {
      const observer = new IntersectionObserver((entries, obs) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            const img = entry.target;
            img.src = img.dataset.src;
            img.classList.remove("lazy");
            obs.unobserve(img);
          }
        });
      });

      lazyImages.forEach((img) => observer.observe(img));
    } else {
      // fallback
      let active = false;
      const lazyLoad = () => {
        if (active) return;
        active = true;
        setTimeout(() => {
          lazyImages = lazyImages.filter((img) => {
            const rect = img.getBoundingClientRect();
            if (
              rect.top <= window.innerHeight &&
              rect.bottom >= 0 &&
              getComputedStyle(img).display !== "none"
            ) {
              img.src = img.dataset.src;
              img.classList.remove("lazy");
              return false;
            }
            return true;
          });
          if (lazyImages.length === 0) {
            document.removeEventListener("scroll", lazyLoad);
            window.removeEventListener("resize", lazyLoad);
            window.removeEventListener("orientationchange", lazyLoad);
          }
          active = false;0
        }, 200);
      };

      document.addEventListener("scroll", lazyLoad);
      window.addEventListener("resize", lazyLoad);
      window.addEventListener("orientationchange", lazyLoad);
      lazyLoad();
    }
  }
}
loadapi();
