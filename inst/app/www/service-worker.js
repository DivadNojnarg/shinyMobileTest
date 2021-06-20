// 1. Save the files to the user's device
// The "install" event is called when the ServiceWorker starts up.
// All ServiceWorker code must be inside events.
self.addEventListener('install', function(e) {
  console.log('install');

  // waitUntil tells the browser that the install event is not finished until we have
  // cached all of our files
  e.waitUntil(
    // Here we call our cache "myonsenuipwa", but you can name it anything unique
    caches.open('myonsenuipwa').then(cache => {
      // If the request for any of these resources fails, _none_ of the resources will be
      // added to the cache.
      return cache.addAll([
        'offline.html',
        'manifest.webmanifest'//,
        // The 2 below work well ...
        //'/www/framework7-5.7.14/css/framework7.bundle.min.css',
        //'/www/framework7-5.7.14/js/framework7.bundle.min.js'
      ]);
    })
  );
});

// 2. Intercept requests and return the cached version instead
self.addEventListener("fetch", (event) => {
  // We only want to call event.respondWith() if this is a navigation request
  // for an HTML page.
  if (event.request.mode === "navigate") {
    event.respondWith(
      (async () => {
        try {
          // First, try to use the navigation preload response if it's supported.
          const preloadResponse = await event.preloadResponse;
          if (preloadResponse) {
            return preloadResponse;
          }

          // Always try the network first.
          const networkResponse = await fetch(event.request);
          return networkResponse;
        } catch (error) {
          // catch is only triggered if an exception is thrown, which is likely
          // due to a network error.
          // If fetch() returns a valid HTTP response with a response code in
          // the 4xx or 5xx range, the catch() will NOT be called.
          console.log("Fetch failed; returning offline page instead.", error);

          const cache = await caches.open("myonsenuipwa");
          const cachedResponse = await cache.match("offline.html");
          return cachedResponse;
        }
      })()
    );
  }

  // If our if() condition is false, then this fetch handler won't intercept the
  // request. If there are any other fetch handlers registered, they will get a
  // chance to call event.respondWith(). If no fetch handlers call
  // event.respondWith(), the request will be handled by the browser as if there
  // were no service worker involvement.
});