@isTest
private class AwesomeCalculatorTest {

    static Double x = 6.0;
    static Double y = 3.0;

    @isTest static void testAddCallout() {
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new CalculatorCalloutMock(CalculatorCalloutMock.ADD_MODE));
        // Call the method that invokes a callout

        Double result = AwesomeCalculator.add(x, y);
        // Verify that a fake result is returned
        Assert.areEqual(9, result);
    }

    @isTest static void testMultiplyCallOut() {
        Test.setMock(WebServiceMock.class, new CalculatorCalloutMock(CalculatorCalloutMock.MUL_MODE));

        Double result = AwesomeCalculator.multiply(x, y);
        Assert.areEqual(18, result);
    }

    @isTest static  void testSubCallout () {
        Test.setMock(WebServiceMock.class, new CalculatorCalloutMock(CalculatorCalloutMock.SUB_MODE));
        Double result = AwesomeCalculator.substract(x, y);
        Assert.areEqual(3, result);
    }

    @IsTest static void testDivCallOut() {
        Test.setMock(WebServiceMock.class, new CalculatorCalloutMock(CalculatorCalloutMock.DIV_MODE));
        Double result = AwesomeCalculator.divide(x, y);
        Assert.areEqual(2, result);
    }
}