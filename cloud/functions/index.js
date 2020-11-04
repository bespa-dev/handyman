const functions = require("firebase-functions");
const admin = require("firebase-admin");
const client = require("./algolia");
admin.initializeApp();

// exports.showConfigDiff = functions.remoteConfig.onUpdate((versionMetadata) => {
//   return admin.credential
//     .applicationDefault()
//     .getAccessToken()
//     .then((accessTokenObj) => {
//       return accessTokenObj.access_token;
//     })
//     .then((accessToken) => {
//       const currentVersion = versionMetadata.versionNumber;
//       const templatePromises = [];
//       templatePromises.push(getTemplate(currentVersion, accessToken));
//       templatePromises.push(getTemplate(currentVersion - 1, accessToken));

//       return Promise.all(templatePromises);
//     })
//     .then((results) => {
//       const currentTemplate = results[0];
//       const previousTemplate = results[1];

//       const diff = jsonDiff.diffString(previousTemplate, currentTemplate);

//       console.log(diff);

//       return null;
//     })
//     .catch((error) => {
//       console.error(error);
//       return null;
//     });
// });

// invoked when an artisan is created, updated or deleted
exports.onArtisanWrite = functions.firestore
  .document("artisans/{id}")
  .onWrite(async (change, context) => {
    let clientIndex = client.initIndex("artisans");

    if (change.before.exists) {
      var isTokenUpdated =
        change.before.data().token != change.after.data().token;
      if (isTokenUpdated) {
        // This registration token comes from the client FCM SDKs.
        var registrationToken = change.after.data().token;

        var message = {
          data: {
            body: "New sign in event detected on a different device.",
          },
          token: registrationToken,
        };

        // Send a message to the device corresponding to the provided
        // registration token.
        await admin.messaging().send(message);
        console.log("Successfully sent message:", response);
      }
    }

    if (change.after.data()) {
      let data = change.after.data();
      data.objectID = change.after.id;
      await clientIndex.saveObject(data);
      console.log("artisan updated");
    } else if (!change.after.exists) {
      let data = change.before.data();
      data.objectID = change.before.id;
      await clientIndex.deleteObject(data.objectID);
      console.log("artisan deleted");
    }

    return Promise.resolve();
  });

// invoked when a booking record is created, updated or deleted
exports.onBookingRequestWrite = functions.firestore
  .document("requests/{id}")
  .onWrite(async (change, context) => {
    let clientIndex = client.initIndex("requests");
    if (change.after.data()) {
      let data = change.after.data();
      data.objectID = change.after.id;
      await clientIndex.saveObject(data);
      console.log("booking request updated");

      if (data.is_accepted) {
        // Get customer id from request and get data from database
        var customerSnapshot = await admin.firestore
          .document(`customers/${data.customer_id}`)
          .get();

        if (customerSnapshot.data().exists) {
          // This registration token comes from the client FCM SDKs.
          var registrationToken = customerSnapshot.data().token;

          var message = {
            data: {
              booking: data.id,
              provider: data.provider_id,
            },
            token: registrationToken,
          };

          // Send a message to the device corresponding to the provided
          // registration token.
          await admin.messaging().send(message);
          console.log("Successfully sent message:", response);
        }
      }

      // Get artisan id from request and get data from database
      var artisanSnapshot = await admin.firestore
        .document(`artisans/${data.provider_id}`)
        .get();

      if (artisanSnapshot.data().exists) {
        // This registration token comes from the client FCM SDKs.
        var registrationToken = artisanSnapshot.data().token;

        var message = {
          data: {
            booking: data.id,
            customer: data.customer_id,
          },
          token: registrationToken,
        };

        // Send a message to the device corresponding to the provided
        // registration token.
        await admin.messaging().send(message);
        console.log("Successfully sent message:", response);
      }
    } else if (!change.after.exists) {
      let data = change.before.data();
      data.objectID = change.before.id;
      await clientIndex.deleteObject(data.objectID);
      console.log("booking request deleted");
    }

    return Promise.resolve();
  });
