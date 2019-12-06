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
