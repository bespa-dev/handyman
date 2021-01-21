const algolia = require("algoliasearch");

const ALGOLIA_ID = /*functions.config().algolia.app_id ||*/ "0EB6NMS1JY";
const ALGOLIA_ADMIN_KEY = /*functions.config().algolia.admin_key ||*/ "5db32463283429146eb5da8ec4b7f405";

module.exports = algolia(ALGOLIA_ID, ALGOLIA_ADMIN_KEY);