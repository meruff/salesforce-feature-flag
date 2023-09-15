/**
 * @description Apex unit tests for FeatureFlag.cls
 *
 * @author meruff
 *
 * @date 2/2/23
 */
@IsTest
private class FeatureFlagTest {
    /**
     * @description This tests that the test feature is on for a given key.
     */
    @IsTest
    static void testIsOn() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOn('Test_Feature'),
            'Test_Feature should be on for this feature key.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on for a given key and date.
     */
    @IsTest
    static void testIsOnForDate() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForDate('Test_Feature', Date.today().addDays(7)),
            'Test_Feature should be on for a date past the start date.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on for a given key and value.
     */
    @IsTest
    static void testIsOnForValue() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForValue('Test_Feature', 'Test Value 3'),
            'Test_Feature should be on for \'Test Value 3\'.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist.
     */
    @IsTest
    static void testDefaultOnForNonExistentFlag() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOn('Flag_That_Does_Not_Exist'),
            'isOn should default to true if the flag does not exist.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist with a date.
     */
    @IsTest
    static void testDefaultOnForNonExistentFlagWithDate() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForDate('Flag_That_Does_Not_Exist', Date.today().addDays(7)),
            'isOn should default to true if the flag does not exist with any date.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist with a value.
     */
    @IsTest
    static void testDefaultOnForNonExistentFlagWithValue() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForValue('Flag_That_Does_Not_Exist', 'Some Test Value'),
            'isOn should default to true if the flag does not exist with any value.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist with no value.
     */
    @IsTest
    static void testDefaultOnForNonExistentFlagWithNoValue() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForValue('Flag_That_Does_Not_Exist', null),
            'isOn should default to true if the flag does not exist with null value.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist with no value.
     */
    @IsTest
    static void testDefaultOnForValueAllNull() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForValue(null, null),
            'isOn should default to true if the flag and value are null.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist with no date.
     */
    @IsTest
    static void testDefaultOnForNonExistentFlagWithNoDate() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForDate('Flag_That_Does_Not_Exist', null),
            'isOn should default to true if the flag does not exist with null date.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist with a null date.
     */
    @IsTest
    static void testIsOffForNullDate() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForDate('Test_Feature', null),
            'isOn should return true if the date is passed as null.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist with a null value.
     */
    @IsTest
    static void testDefaultOnForNullValue() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForValue('Test_Feature', null),
            'isOn should default to true if the value is passed as null.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't have any skip values.
     */
    @IsTest
    static void testDefaultOnForFeatureNoValues() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForValue('Test_Feature_No_Values', 'Something'),
            'isOn should default to true if the flag has no skip values.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't have any start date.
     */
    @IsTest
    static void testDefaultOnForFeatureNoStartDate() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForDate('Test_Feature_No_Values', Date.today()),
            'isOn should default to true if the flag has no start date.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist.
     */
    @IsTest
    static void testIsOff() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isFalse(
            FeatureFlag.isOn('Test_Feature_Off'),
            'Test_Feature_Off should be turned off.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is off for a flag that exists and is active, but with a date
     * that is before the start date, meaning the feature is off.
     */
    @IsTest
    static void testIsOffForDate() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isFalse(
            FeatureFlag.isOnForDate('Test_Feature', Date.today().addDays(-7)),
            'Test_Feature should be off for a date 1 week prior to start date.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on for a given key and value.
     */
    @IsTest
    static void testIsOffForValue() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isFalse(
            FeatureFlag.isOnForValue('Test_Feature', 'Test Value 2'),
            'Test_Feature should be off for \'Test Value 2\'.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on for a given key and value using the Values_to_Allow__c field.
     */
    @IsTest
    static void testIsOnForValueAllow() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForValue('Test_Value_Allow', 'Test Value Allow'),
            'Test_Value_Allow should be on for \'Test Value Allow\'.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is off for a given key and value using the Values_to_Allow__c field
     * but overriding to off using the Values_to_Skip__c field.
     */
    @IsTest
    static void testIsOffForValueAllowWithSkipOverride() {
        populateFeatureFlagMap();

        Test.startTest();
        Assert.isFalse(
            FeatureFlag.isOnForValue('Test_Value_Allow', 'Test Value Allow 2'),
            'Test_Value_Allow should be off for \'Test Value Allow 2\' because it is also referenced in values to skip.'
        );
        Test.stopTest();
    }

    private static void populateFeatureFlagMap() {
        FeatureFlag.featureFlagConfigMap.put('Test_Feature', new Feature_Flag__mdt(
            DeveloperName = 'Test_Feature',
            Is_Active__c = true,
            Start_Date__c = Date.today(),
            Values_to_Skip__c = 'Test Value 1;Test Value 2'
        ));

        FeatureFlag.featureFlagConfigMap.put('Test_Feature_No_Values', new Feature_Flag__mdt(
            DeveloperName = 'Test_Feature_No_Values',
            Is_Active__c = true
        ));

        FeatureFlag.featureFlagConfigMap.put('Test_Feature_Off', new Feature_Flag__mdt(
            DeveloperName = 'Test_Feature_Off',
            Is_Active__c = false
        ));

        FeatureFlag.featureFlagConfigMap.put('Test_Value_Allow', new Feature_Flag__mdt(
            DeveloperName = 'Test_Value_Allow',
            Is_Active__c = true,
            Values_to_Allow__c = 'Test Value Allow;Test Value Allow 2',
            Values_to_Skip__c = 'Test Value Allow 2'
        ));
    }
}