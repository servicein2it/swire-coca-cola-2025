importScripts(
  "https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyAYsPbYAOFRelOGZPywaX_OD_mPdsECAKA",
  authDomain: "swire-coca-cola.firebaseapp.com",
  projectId: "swire-coca-cola",
  storageBucket: "swire-coca-cola.firebasestorage.app",
  messagingSenderId: "504053208911",
  appId: "1:504053208911:web:6520c0b2fffdc0e3ded73a",
  measurementId: "G-5JNLK7N1EE",
});

const messaging = firebase.messaging();

// จัดการกับ background messages
messaging.onBackgroundMessage((payload) => {
  console.log("Received background message:", payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: "Leaders_Summit__with_Bangkok.png",
    badge: "Leaders_Summit__with_Bangkok.png",
    data: payload.data,
    // เพิ่ม actions ถ้าต้องการ
    actions: [
      {
        action: "view",
        title: "View",
      },
    ],
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});

// จัดการกับการคลิกที่การแจ้งเตือน
self.addEventListener("notificationclick", (event) => {
  console.log("Notification click received:", event);

  event.notification.close();

  // มีการคลิกที่การแจ้งเตือน - เปิดหน้าหลักหรือ URL เฉพาะ
  // หรือปรับให้เปิด URL ที่มาจาก payload ถ้าต้องการ
  const urlToOpen = new URL("/", self.location.origin).href;

  const promiseChain = clients
    .matchAll({
      type: "window",
      includeUncontrolled: true,
    })
    .then((windowClients) => {
      // ตรวจสอบว่ามีหน้าต่างที่เปิดอยู่หรือไม่
      for (let i = 0; i < windowClients.length; i++) {
        const client = windowClients[i];
        if (client.url === urlToOpen && "focus" in client) {
          return client.focus();
        }
      }
      // ถ้าไม่มีหน้าต่างที่เปิดอยู่ ให้เปิดหน้าต่างใหม่
      if (clients.openWindow) {
        return clients.openWindow(urlToOpen);
      }
    });

  event.waitUntil(promiseChain);
});