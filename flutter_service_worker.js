'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "ec190b6c392c7ceefe1503078ae65177",
"assets/AssetManifest.bin.json": "3038fbd95bef2eaa3e6ecb6bafb31372",
"assets/AssetManifest.json": "360cb76d00f843754c926fa1113a53d0",
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
"assets/assets/icons/filter.svg": "45cb352703332e0446bee7c0053b14eb",
"assets/assets/icons/gallery.svg": "730a2fe9a20f2c054e1ea01e0efd0071",
"assets/assets/icons/location.png": "a5b519750ecdfe10343965181e0a55ae",
"assets/assets/icons/logout.svg": "67a45545d3a390396ff20226cef31613",
"assets/assets/icons/notification.svg": "1e03da9321acffc9d1f495a21d21ec3a",
"assets/assets/icons/person.svg": "9a14ff240ece446adffd95414451c82a",
"assets/assets/icons/subscription.svg": "372481748bb1ef1f2ff1c97cb50af1a2",
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
"assets/fonts/MaterialIcons-Regular.otf": "b94cd86c34f3ed0e360ad91f52348016",
"assets/NOTICES": "396a4c02a5dcd46b186716424bbf0aba",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "ceddeb4fedbb180539b65d2de6f89799",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f9d8b7679c1bdc920a1c13666de049ae",
"/": "f9d8b7679c1bdc920a1c13666de049ae",
"main.dart.js": "65e8b0649f0a81ed4813995903725ee9",
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
