@isTest
global class CalculatorCalloutMock implements WebServiceMock {

   public String mode;
   public static String ADD_MODE = 'ADD_MODE';
   public static String SUB_MODE = 'SUB_MODE';
   public static String MUL_MODE = 'MUL_MODE';
   public static String DIV_MODE = 'DIV_MODE';

   global CalculatorCalloutMock(String modeIn){
      this.mode = modeIn;
   }
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {




        // start - specify the response you want to send
        if(mode == ADD_MODE) {
         
         calculatorServices.doAddResponse response_x = new calculatorServices.doAddResponse();
         response_x.return_x = 9;
         
         response.put('response_x', response_x);
        } else if(mode == SUB_MODE) {

         calculatorServices.doSubtractResponse response_x = new calculatorServices.doSubtractResponse();
         response_x.return_x = 3;
         
         response.put('response_x', response_x);
            
        } else if(mode == MUL_MODE) {

         calculatorServices.doMultiplyResponse response_x = new calculatorServices.doMultiplyResponse();
         response_x.return_x = 18;
         
         response.put('response_x', response_x);
            
        } else if(mode == DIV_MODE) {
         calculatorServices.doDivideResponse  response_x = new calculatorServices.doDivideResponse();
         response_x.return_x = 2.0;
         
         response.put('response_x', response_x);
            
        }
        
        

   }
}