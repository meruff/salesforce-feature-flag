/**
 * @description A class to interface with Feature_Flag__mdt and check if certain features are enabled. 
 * 
 * @author meruff
 * 
 * @date 2/2/23
 */
public without sharing class FeatureFlag {
    @TestVisible
    private static final Map<String, Feature_Flag__mdt> featureFlagConfigMap {
        get {
            if (featureFlagConfigMap == null) {
                featureFlagConfigMap = new Map<String, Feature_Flag__mdt>();

                for (Feature_Flag__mdt featureFlag : [
                    SELECT Id,
                        DeveloperName,
                        Is_Active__c,
                        Start_Date__c,
                        Values_to_Skip__c
                    FROM Feature_Flag__mdt
                ]) {
                    featureFlagConfigMap.put(featureFlag.DeveloperName, featureFlag);
                }
            }

            return featureFlagConfigMap;
        }

        set;
    }

    /**
     * @description Determines whether or not the Feature_Flag__mdt is turned on for the given key. If no
     * Feature_Flag__mdt record is found for the given key, assume the feature is on and return true.
     *
     * @param featureKey a String representing the name of the feature to check.
     *
     * @return a Boolean representing whether or not the feature is turned on for the given key.
     */
    @AuraEnabled(Cacheable=true)
    public static Boolean isOn(String featureKey) {
        Feature_Flag__mdt featureFlag = featureFlagConfigMap.get(featureKey);

        return featureFlag != null
            ? featureFlag.Is_Active__c
            : true;
    }

    /**
     * @description Determines whether or not the Feature_Flag__mdt is turned on for the given key and start date. If
     * no Feature_Flag__mdt record is found for the given key, assume the feature is on and return true. Whatever date
     * is passed to this method is used to check if it is the same or greater than the start date defined in the feature
     * flag.
     *
     * @param featureKey a String representing the name of the feature to check.
     * @param dateToCheck a Date to compare against the start date on the feature flag.
     *
     * @return a Boolean representing whether or not the feature is turned on for the given key.
     */
    @AuraEnabled(Cacheable=true)
    public static Boolean isOnForDate(String featureKey, Date dateToCheck) {
        Feature_Flag__mdt featureFlag = featureFlagConfigMap.get(featureKey);

        return featureFlag != null
            ? featureFlag.Is_Active__c && dateToCheck >= featureFlag.Start_Date__c
            : true;
    }

    /**
     * @description Determines whether or not the Feature_Flag__mdt is turned on for the given key and value. If
     * no Feature_Flag__mdt record is found for the given key, assume the feature is on and return true. Whatever value
     * is passed to this method is used to check if it is included in the Values_to_Skip__c field on the flag. If so,
     * the feature is OFF for that value.
     *
     * @param featureKey a String representing the name of the feature to check.
     * @param valueToCheck a String to check against the feature flag.
     *
     * @return a Boolean representing whether or not the feature is turned on for the given key.
     */
    @AuraEnabled(Cacheable=true)
    public static Boolean isOnForValue(String featureKey, String valueToCheck) {
        Feature_Flag__mdt featureFlag = featureFlagConfigMap.get(featureKey);

        return featureFlag != null
            ? featureFlag.Is_Active__c && !featureFlag.Values_to_Skip__c.split(';').contains(valueToCheck)
            : true;
    }
}