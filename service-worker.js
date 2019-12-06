const CACHE_NAME = 'relwindow-cache-v1';
const PRE_CACHED_ASSETS = [
  'js/main.js', 
  'css/main.css', 
  'css/bootstrap.min.css',
  'index.html'
];

self.addEventListener('install', function(event) {
  event.waitUntil(
    caches.open(CACHE_NAME).then(function(cache) {
      let cachePromises = PRE_CACHED_ASSETS.map(function(asset) {
        var url = new URL(asset, location.href);
        var request = new Request(url);
        return fetch(request).then(function(response) {
          return cache.put(asset, response);
        });
      });

      return Promise.all(cachePromises);
    }),
  );
});

self.addEventListener('activate', function(event) {
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        // delete old caches
        cacheNames.map(function(cacheName) {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        }),
      );
    }),
  );
});

self.addEventListener('fetch', function(event) {
  if (event.request.headers.get('accept').startsWith('text/html')) {
    event.respondWith(
      fetch(event.request).catch(error => {
        return caches.match('index.html');
      }),
    );
  }
});
