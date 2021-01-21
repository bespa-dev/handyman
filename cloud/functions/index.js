const functions = require("firebase-functions");
const admin = require("firebase-admin");
const client = require("./algolia");
admin.initializeApp();

// notification types
const booking_type = "booking";
const conversation_type = "conversation";
const token_type = "token";

// booking requests
exports.bookingNotifications = functions.firestore
  .document("bookings/{id}")
  .onWrite(async (change, context) => {
    // no new booking found
    if (change.after == null || !change.after.exists)
      return Promise.reject("No booking found");

    // get data
    let data = change.after.data();
    let state = change.after.get("current_state");
    let customer = change.after.get("customer_id");
    let artisan = change.after.get("artisan_id");

    // get state info
    let pending = state === "Pending";
    let none = state === "None";
    let complete = state === "Complete";
    let cancelled = state === "Cancelled";

    if (change.after.exists) {
      // save to algolia
      let clientIndex = client.initIndex("bookings");
      data.objectID = change.after.id;
      await clientIndex.saveObject(data);
      console.log("job request saved");
    }

    if (none) {
      // new booking
      let snapshot = await admin.firestore().doc(`artisans/${artisan}`).get();

      if (snapshot.exists && snapshot.data() != null) {
        // create message payload
        let message = {
          notification: {
            title: `New job request`,
            body: `Tap here for more info`,
          },
          data: {
            id: change.after.id,
            type: booking_type,
            click_action: "FLUTTER_NOTIFICATION_CLICK",
          },
        };

        // send notification to artisan
        return await admin
          .messaging()
          .sendToDevice(snapshot.get("token"), message);
      } else {
        return Promise.reject(`artisan with id: ${artisan} not found`);
      }
    } else if (pending) {
      // accepted booking
      let snapshot = await admin.firestore().doc(`customers/${customer}`).get();

      if (snapshot.exists && snapshot.data() != null) {
        // create message payload
        let message = {
          notification: {
            title: `Request accepted`,
            body: `Your job request has been accepted. Tap here for more details`,
          },
          data: {
            id: change.after.id,
            type: booking_type,
            click_action: "FLUTTER_NOTIFICATION_CLICK",
          },
        };

        // send notification to artisan
        return await admin
          .messaging()
          .sendToDevice(snapshot.get("token"), message);
      } else {
        return Promise.reject(`customer with id: ${customer} not found`);
      }
    } else if (cancelled) {
      // declined booking
      let _as = await admin.firestore().doc(`artisans/${artisan}`).get();
      let _cs = await admin.firestore().doc(`customers/${customer}`).get();

      if (_as.exists && _cs.exists) {
        // create message payload
        let message = {
          notification: {
            title: `Job cancelled`,
            body: `This job request has been cancelled successfully`,
          },
          data: {
            id: change.after.id,
            type: booking_type,
            click_action: "FLUTTER_NOTIFICATION_CLICK",
          },
        };

        // send notification to artisan
        let artisanMessage = admin
          .messaging()
          .sendToDevice(_as.get("token"), message);

        // send notification to customer
        let customerMessage = admin
          .messaging()
          .sendToDevice(_cs.get("token"), message);
        return Promise.all([artisanMessage, customerMessage]);
      } else {
        return Promise.reject(`unable to cancel job request`);
      }
    } else if (complete) {
      // completed booking
      let _as = await admin.firestore().doc(`artisans/${artisan}`).get();
      let _cs = await admin.firestore().doc(`customers/${customer}`).get();

      if (_as.exists && _cs.exists) {
        // create message payload
        let message = {
          notification: {
            title: `Job completed successfully`,
            body: `Tap here for more details`,
          },
          data: {
            id: change.after.id,
            type: booking_type,
            click_action: "FLUTTER_NOTIFICATION_CLICK",
          },
        };

        // send notification to artisan
        let artisanMessage = admin
          .messaging()
          .sendToDevice(_as.get("token"), message);

        // send notification to customer
        let customerMessage = admin
          .messaging()
          .sendToDevice(_cs.get("token"), message);
        return Promise.all([artisanMessage, customerMessage]);
      } else {
        return Promise.reject(`unable to complete job request`);
      }
    }
  });

// conversations

// registration token
