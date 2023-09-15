# Salesforce Feature Flag

One way to implement feature flagging in your Salesforce org.

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

## Default Values

* If a feature flag does not exist for a given key, the default value returned is `true` meaning the feature is "on".
* If you pass a null date to `isOnForDate`, the default value returned is `false` and the feature is considered "off".
* If you pass a blank value to `isOnForValue`, the default value returned is `true` and the feature is considered "on".