const algolia = require("algoliasearch");
const functions = require("firebase-functions");

const ALGOLIA_ID = functions.config().algolia.app_id;
const ALGOLIA_ADMIN_KEY = functions.config().algolia.admin_key;

module.exports = algolia(ALGOLIA_ID, ALGOLIA_ADMIN_KEY);