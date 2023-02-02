# Salesforce Feature Flag

One way to implement feature flagging in your Salesforce org.

## In LWC

```javascript
import { isOn } from "c/featureFlagUtils";

isFeatureOn;

connectedCallback() {
    isOn("My_Feature_Flag")
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

## Default Values

* If a feature flag does not exist for a given key, the default value returned is `true` meaning the feature is "on".
* If you pass a null date to `isOnForDate`, the default value returned is `false` and the feature is considered "off".
* If you pass a blank value to `isOnForValue`, the default value returned is `true` and the feature is considered "on".