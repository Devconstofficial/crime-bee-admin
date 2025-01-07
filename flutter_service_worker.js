'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "3eab9f344fc6577cc105075cab3cff4d",
"assets/AssetManifest.bin.json": "557cc1bed08122a0f6546d251d19c006",
"assets/AssetManifest.json": "22e0206387173feec40c241ed9eae820",
"assets/assets/icons/arrow.svg": "ad2290638700b4f5cbb03e5b757882c6",
"assets/assets/icons/blog.svg": "3dd3c810e50f011b5f56a25d4204409f",
"assets/assets/icons/clock.png": "7cf774802b66be6024140ff42ec3dd8f",
"assets/assets/icons/clown.svg": "07c2fd45eae8f981b0c895a8ba84345f",
"assets/assets/icons/comment.svg": "fd02525b67aec7c74212dcdd3c03e3d2",
"assets/assets/icons/comment1.svg": "2bb38020c2d41c6dd344a0f1ea5a2d81",
"assets/assets/icons/cross.svg": "eb0ae270848af2d83a5bf03a69b80d54",
"assets/assets/icons/dashboard.svg": "c6a6482da935f839b8bf1d6b6fdb4e96",
"assets/assets/icons/delete.svg": "1b8ddf8cd6b5874db00d9164af7fdee6",
"assets/assets/icons/deleteDialog.svg": "ba57ac06650d52dc76b93e0bdb7d974e",
"assets/assets/icons/edit.svg": "48ecc98670fb92f55b1b9b07658cff91",
"assets/assets/icons/eye.svg": "e65fd09375a395deb5f29ef2b28412fb",
"assets/assets/icons/eyeIcon.png": "f378a1c0d0b73733a363d3e215139ab5",
"assets/assets/icons/filter.svg": "45cb352703332e0446bee7c0053b14eb",
"assets/assets/icons/gallery.svg": "730a2fe9a20f2c054e1ea01e0efd0071",
"assets/assets/icons/location.png": "a5b519750ecdfe10343965181e0a55ae",
"assets/assets/icons/logout.svg": "67a45545d3a390396ff20226cef31613",
"assets/assets/icons/noti2.png": "9ed5a9676beac0fb4baea3f1bf3f19cc",
"assets/assets/icons/notification.png": "c47f06ec4d7fcdff36636c77686317ac",
"assets/assets/icons/notification.svg": "af49f4564e5b35ca8c19a9c48e2f97a7",
"assets/assets/icons/person.svg": "9a14ff240ece446adffd95414451c82a",
"assets/assets/icons/subscription.svg": "372481748bb1ef1f2ff1c97cb50af1a2",
"assets/assets/icons/terms.svg": "ccff982a8516f18bdefc7b581922d8fb",
"assets/assets/icons/user.svg": "f91568fa3c79f39aa7b26d5778667c4d",
"assets/assets/images/logo.svg": "3fcf7d80a3e8b330a585157884774b3d",
"assets/assets/images/logo1.png": "b6676ede128e2cf4fe50fbe290064380",
"assets/assets/images/user.svg": "8715d36b105f1bc89a16b04c9ae5fac8",
"assets/assets/images/user1.svg": "c9c71fd237b72a84221e9cda925bb770",
"assets/assets/images/user2.svg": "937570cb7fe96cb10c9c8e0b0fa1aeb0",
"assets/assets/images/user3.svg": "fc2a8fc11cb13f56958d9e7387dc260a",
"assets/assets/images/user4.svg": "f3c1be58328fa0bf0cf6195e5308e2d5",
"assets/assets/images/userLogo.png": "818752bcef5bdb55d486081117cb59ab",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "236d447f292b2c6ba1c2d7cc08918e3b",
"assets/NOTICES": "6c62bcb4cc6b272fa2bbe40e94d26753",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/quill_native_bridge_linux/assets/xclip": "d37b0dbbc8341839cde83d351f96279e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "bc3d9df89b9a3ea0ef8f62ed39806ac5",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f9d8b7679c1bdc920a1c13666de049ae",
"/": "f9d8b7679c1bdc920a1c13666de049ae",
"main.dart.js": "f9956679ed84e8fd5542952ed23470e4",
"manifest.json": "7a5cd2f71851c2b789146f68540b9119",
"version.json": "bf18f60b4e11a8e03ada51b631418b7a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
