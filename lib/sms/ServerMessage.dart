class ServerMessage{

   static String sender="CGSAVE";
   static String forgotpasstemplateid="1007856104698741987";
   static String registrationtemplateid="1007625690429475781";
   static String registration_Confirm_templateid="1007134283594642980";

   static String route="2";

   static String type="1";

   static String apikey="bf25917c3254cfe9f50694f24884f23a";


   static   String smsbaseurl="http://eapoluenterprise.in/httpapi/";

   static int forgot_password=1;

   static int registration_Confirm_password=2;


   static int registration=3;


   static String buildServerMessage(int Type, String otp,String username,String password)
   {
     String message="";

     if(Type==forgot_password)
     {

       message="Your OTP for forgot Password is "+otp+" .CGSAVE";
     }

     if(Type==registration_Confirm_password)
     {

       message="Your registration is successful. Your Registration ID "+username+" Passowrd "+password+" .CGSAVE";
     }

     if(Type==registration)
     {

       message="Dear "+username+" Welcome to SAVEKART App - My Personal App. Your OTP is "+otp+" CGSAVE";
     }


     return message;
   }

    static String smsMethode="httpapi";

}