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
        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForValue('Flag_That_Does_Not_Exist', 'Some Test Value'),
            'isOn should default to true if the flag does not exist with any value.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist with a null date.
     */
    @IsTest
    static void testIsOffForNullDate() {
        Test.startTest();
        Assert.isFalse(
            FeatureFlag.isOnForDate('Test_Feature', null),
            'isOn should return false if the date is passed as null.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist with a null value.
     */
    @IsTest
    static void testDefaultOnForNullValue() {
        Test.startTest();
        Assert.isTrue(
            FeatureFlag.isOnForValue('Test_Feature', null),
            'isOn should default to true if the value is passed as null.'
        );
        Test.stopTest();
    }

    /**
     * @description This tests that the test feature is on by default for a flag that doesn't exist.
     */
    @IsTest
    static void testIsOff() {
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
        Test.startTest();
        Assert.isFalse(
            FeatureFlag.isOnForValue('Test_Feature', 'Test Value 2'),
            'Test_Feature should be off for \'Test Value 2\'.'
        );
        Test.stopTest();
    }
}