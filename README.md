# Salesforce Feature Flag

One way to implement feature flagging in your Salesforce org.

## Custom Metadata

Uses a custom metadata type named `Feature_Flag__mdt` for configuration.

| Field API Name       | Field Type | Description                                                                                                                                                                                                                                                                                                                                                                                                                            |
|----------------------|------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Feature_Flag_Name__c | Text       | The unique API name of the flag, used in code to figure out                                                                                                                                                                                                                                                                                                                                                                            |
| Is_Active__c         | Checkbox   | Whether or not the flag is turned on, this overrides any other field values below.                                                                                                                                                                                                                                                                                                                                                     |
| Start_Date__c        | Text       | A date representing the "start" date of the feature. It is up to the developer to determine what date to check against (a record's created date, today's date, etc.).                                                                                                                                                                                                                                                                  |
| Values_to_Skip__c    | Long Text  | A semi-colon delimited list of values to skip for a given feature flag. For example, if we want to skip this feature for specified accounts, you can add them here and the feature will work for others but not for the accounts listed. i.e. Account 1;Account 2; etc. It is up to the developer to configure the values in this list and pass the value to the feature flag class for comparison. This overrides Values_to_Allow__c. |
| Values_to_Allow__c   | Text       | A semi-colon delimited list of values to allow. ex: email, Account name, etc. If there is a value in this field, the feature will ONLY be on for these given values.                                                                                                                                                                                                                                                                   |
# Uses

## In LWC

```javascript
import { isFeatureOn } from "c/featureFlagUtils";

isFeatureOn;

connectedCallback() {
    isFeatureOn("My_Feature_Flag")
        .then((result) => {
            this.isFeatureOn = result;
        })
        .catch((error) => {
            // handle error
        });
}
```

## In Apex

```java
FeatureFlag.isOn("My_Feature_Flag");
```

## Other Options

You can also designate specific dates/values in the custom metadata depending on your use case.

### Feature Date

You can pass a record date (or today's date) to see if a specific feature is turned on for that date. The date passed needs to be the same date as defined in the metadata or past.

```java
FeatureFlag.isOnForDate("My_Feature_Flag", Date.today());
```

### Feature Value

You can also pass a value to see if that feature is turned on for that value. You can define a list of semi-colon delimited values in the metadata and check if the feature is turned on for that value. This is useful for something like say, an Account name. The feature can be live for the entire org, but turned off for specific Accounts.

```java
FeatureFlag.isOnForValue("My_Feature_Flag", "My Account Name");
```

### Skip / Allow Values

Using the `Values_to_Skip__c` field, you can specify specific values that do not get access to the feature. All other values not defined in this field will have access.

Using the `Values_to_Allow__c` field, you can specify flag access to specific values. All other values not defined in this field will _not_ have access.

> Currently this is built to only allow use of one of the two fields described above.

# Default Values

* If a feature flag does not exist for a given key, the default value returned is `true` meaning the feature is "on".
* If you pass a null date to `isOnForDate`, the default value returned is `false` and the feature is considered "off".
* If you pass a blank value to `isOnForValue`, the default value returned is `true` and the feature is considered "on".
