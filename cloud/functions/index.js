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

exports.onArtisanCreateOrEdit = functions.firestore
  .document("artisans/{id}")
  .onWrite(async (change, context) => {
    let clientIndex = client.initIndex("artisans");
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
