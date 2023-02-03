import isOn from "@salesforce/apex/FeatureFlag.isOn";
import isOnForDate from "@salesforce/apex/FeatureFlag.isOnForDate";
import isOnForValue from "@salesforce/apex/FeatureFlag.isOnForValue";

/**
 * @description Using the FeatureFlag class, determines whether or not a
 * feature is enabled based on the key supplied.
 *
 * @param key the feature key to check.
 *
 * @returns {Promise<Boolean>} a Boolean representing whether or not the feature
 * is turned on.
 */
const isFeatureOn = async (key) => {
  return isOn({ featureKey: key })
    .then((result) => {
      return result ?? true;
    })
    .catch((error) => console.error(error));
};

/**
 * @description Using the FeatureFlag class, determines whether or not a
 * feature is enabled based on the key and date supplied.
 *
 * @param key the developer name to check for on the flag.
 * @param date the date to check against the start date on the flag.
 *
 * @returns {Promise<Boolean>} a Boolean representing whether or not the feature
 * is turned on.
 */
const isFeatureOnForDate = async (key, date) => {
  return isOnForDate({ featureKey: key, dateToCheck: new Date(date) })
    .then((result) => {
      return result ?? true;
    })
    .catch((error) => console.error(error));
};

/**
 * @description Using the FeatureFlag class, determines whether or not a
 * feature is enabled based on the key and value supplied.
 *
 * @param key the developer name to check for on the flag.
 * @param value the value to check against the values to skip field on the flag.
 *
 * @returns {Promise<Boolean>} a Boolean representing whether or not the feature
 * is turned on.
 */
const isFeatureOnForValue = async (key, value) => {
  return isOnForValue({ featureKey: key, valueToCheck: value })
    .then((result) => {
      return result ?? true;
    })
    .catch((error) => console.error(error));
};

export {
  isFeatureOn,
  isFeatureOnForDate,
  isFeatureOnForValue
};