const functions = require("firebase-functions");
const admin = require("firebase-admin");
const client = require("./algolia");
admin.initializeApp();

// notification types
const booking_type = "booking";
const conversation_type = "conversation";
const token_type = "token";
const account_approval_type = "approval";

// booking requests
exports.bookingNotifications = functions.firestore
  .document("bookings/{id}")
  .onWrite(async (change, _) => {
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
            customer: customer,
            artisan: artisan,
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
            customer: customer,
            artisan: artisan,
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
            customer: customer,
            artisan: artisan,
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
            customer: customer,
            artisan: artisan,
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
exports.chatNotifications = functions.firestore
  .document("conversations/{id}")
  .onWrite(async (change, context) => {
    if (!change.after.exists)
      return Promise.reject(
        "Cannot find conversation. It may have been deleted"
      );
    // get ids of sender & recipient
    let sender = change.after.get("sender");
    let recipient = change.after.get("recipient");

    // get conversation metadata
    let id = context.params.id;
    let body = change.after.get("body");

    let _as = await admin.firestore().doc(`artisans/${recipient}`).get();
    let _cs = await admin.firestore().doc(`customers/${recipient}`).get();

    if (_as.exists) {
      // case 1: customer -> artisan
      // get customer snapshot
      let _customer__snapshot = await admin
        .firestore()
        .doc(`customers/${sender}`)
        .get();

      // validate
      if (!_customer__snapshot.exists) {
        return Promise.reject("customer (recipient) does not exist");
      } else {
        // get customer's metadata
        let token = _customer__snapshot.get("token");
        let avatar = _customer__snapshot.get("avatar");
        let name = _customer__snapshot.get("name");
        let uid = _customer__snapshot.get("id");

        // create message payload
        let message = {
          notification: {
            title: `Message from ${name}`,
            body: body,
          },
          data: {
            id: id,
            type: conversation_type,
            sender: uid,
            avatar: avatar,
          },
        };

        return await admin.messaging().sendToDevice(token, message);
      }
    } else if (_cs.exists) {
      // case 2: artisan -> customer
      // get artisan snapshot
      let _artisan__snapshot = await admin
        .firestore()
        .doc(`artisans/${sender}`)
        .get();

      // validate
      if (!_artisan__snapshot.exists) {
        return Promise.reject("artisan (recipient) does not exist");
      } else {
        // get customer's metadata
        let token = _artisan__snapshot.get("token");
        let avatar = _artisan__snapshot.get("avatar");
        let name = _artisan__snapshot.get("name");
        let uid = _artisan__snapshot.get("id");

        // create message payload
        let message = {
          notification: {
            title: `Message from ${name}`,
            body: body,
          },
          data: {
            id: id,
            type: conversation_type,
            sender: uid,
            avatar: avatar,
          },
        };

        return await admin.messaging().sendToDevice(token, message);
      }
    } else {
      return Promise.resolve();
    }
  });

// device registration notification
exports.artisanDeviceTokenNotifications = functions.firestore
  .document("artisans/{id}")
  .onWrite(async (change, context) => {
    // account was deleted from database
    if (change.before.exists && !change.after.exists) return Promise.resolve();
    let oldToken = change.before.get("token");
    let newToken = change.after.get("token");
    let name = change.after.get("name");

    if (change.after.exists) {
      // save to algolia
      let clientIndex = client.initIndex("artisans");
      data.objectID = change.after.id;
      await clientIndex.saveObject(data);
      console.log(`${name} saved`);
    }

    // device token has not changed
    if (oldToken == newToken) return Promise.resolve();
    // account approval
    else if (change.after.get("approved") === true) {
      let message = {
        notification: {
          title: "Account approval",
          body: `Hello 👋 ${name}, your request for account approval on HandyMan was successful. You will now receive job requests from your prospective customers. We are happy to serve you 😄`,
        },
        data: {
          id: context.params.id,
          type: account_approval_type,
        },
      };
      return await admin.messaging().sendToDevice(newToken, message);
    }
    // notify user of token update
    else {
      let message = {
        notification: {
          title: "New login to HandyMan",
          body: `We noticed a new login 🔐 to your account ${name} from a new device. Was this you?`,
        },
        data: {
          id: context.params.id,
          type: token_type,
        },
      };
      return await admin.messaging().sendToDevice(newToken, message);
    }
  });

exports.customerDeviceTokenNotifications = functions.firestore
  .document("customers/{id}")
  .onWrite(async (change, context) => {
    // account was deleted from database
    if (change.before.exists && !change.after.exists) return Promise.resolve();
    let oldToken = change.before.get("token");
    let newToken = change.after.get("token");
    let name = change.after.get("name");

    if (change.after.exists) {
      // save to algolia
      let clientIndex = client.initIndex("customers");
      data.objectID = change.after.id;
      await clientIndex.saveObject(data);
      console.log(`${name} saved`);
    }

    // device token has not changed
    if (oldToken == newToken) return Promise.resolve();
    // notify user of token update
    else {
      let message = {
        notification: {
          title: "New login to HandyMan",
          body: `We noticed a new login to your account ${name} from a new device. Was this you?`,
        },
        data: {
          id: context.params.id,
          type: token_type,
        },
      };
      return await admin.messaging().sendToDevice(newToken, message);
    }
  });
