import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as ApiService;
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/web/SavekartApiHelper.dart';
import 'package:savekart/web/apimethodes.dart';
import 'package:savekart/web/encrypthelper.dart';
// Make sure this import points to your actual TicketInfoScreen file
import 'package:savekart/widgets/ticketinfo.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../domain/profile_data_entity.dart';
import '../domain/ssm/s_s_m_event_entity.dart';
import '../domain/ssm/s_s_m_ticket_entity.dart';
import '../web/AppStorage.dart';
import 'package:intl/intl.dart';

import '../web/api_helper.dart';
import 'bookedticketdetails.dart';

class SSMTicket extends StatefulWidget {
  String mobile;
  SSMTicket(this.mobile);

  @override
  _SSMTicketState createState() => _SSMTicketState();
}

class _SSMTicketState extends State<SSMTicket> {
  int _quantity = 1;
  final Color _ticketColor =  Color(0xFF1E5149); // Extracted color

  SSMEventData? ssmdata=null;
  SSMTicketData? ssmt=null;

  String qrstring="";
  String formattedDate ="";

  String email="";
  String phone="";
  String fullname="";

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getEventDetails();
    showProfileDetails();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Changed background to light grey to match the visual context of the image
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading:  BackButton(color: Colors.black), // Standard back button
        title:  Text('Mega SSM Ticket', style: TextStyle(color: Colors.black,fontSize: 14)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Padding(padding: EdgeInsets.all(10),

          child: IconButton(onPressed: (){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventTicketsPage(eventId: ssmdata!.id.toString(),mobile: phone,)),
            );

          }, icon: Icon(Icons.qr_code,color: Colors.black54,)),

          )
        ],
      ),
      body: Center(
        child: (qrstring.isNotEmpty)? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            QrImageView(
              data: qrstring,
              version: QrVersions.auto,
              size: 250,
            ),
            Padding(padding: EdgeInsets.all(10),
            child: Text("Scan this QR code.Mark your attendance\n\n Venue : "+ssmdata!.venue.toString()+" "+ssmdata!.place.toString()+"\n\nEvent : "+ssmdata!.eventName.toString()+"\n\nDate : "+formattedDate,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            
            )
          ],
        )
        
        :  (ssmdata!=null)?SingleChildScrollView(
          padding:  EdgeInsets.all(16.0),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding:  EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                color: _ticketColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Main alignment left
                children: [
                  // ==================== NEW TOP BANNER AREA ====================
                  Row(
                    children: [
                      // Stylized 'S'/'G' Logo in white box
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: Image.network("https://mysaving.in/assets/images/logo/saveicon.png",width: 45,height: 45, fit: BoxFit.fill,),
                      ),
                       SizedBox(width: 16),
                      // "SAVE" Text
                       Text(
                        'MY SAVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: 32), // Spacing after header

                  // ==================== EVENT DETAILS AREA ====================
                  // Event Title (Specific text from image)
                   Text(
                    ssmdata!.eventName.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                   SizedBox(height: 20),

                  // Event Details (Specific text from image)
                  _buildDetailText(
                      'VENUE: '+ssmdata!.venue.toString()+"\n"+ssmdata!.place.toString()),
                  _buildDetailText('DATE: '+formattedDate),
                  _buildDetailText('TIME: '+ssmdata!.time.toString()),
                   SizedBox(height: 32),

                  // ==================== QUANTITY COUNTER ====================
                  // Centered counter as seen in the wireframe
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon:  Icon(Icons.remove, color: Colors.white),
                              onPressed: _decrement,
                            ),
                            Container(
                              padding:  EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                '$_quantity',
                                style:  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon:  Icon(Icons.add, color: Colors.white),
                              onPressed: _increment,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: 32),

                  // ==================== SUBMIT BUTTON ====================
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // White button
                        foregroundColor: _ticketColor, // Text color is teal
                        padding:  EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketInfoScreen(quantity: _quantity,ssmEventData: ssmdata!,),
                          ),
                        );
                      },
                      child:  Text(
                        'SUBMIT',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                   SizedBox(height: 24),

                  // ==================== FOOTER TAGLINE & ICON ====================
                   Center(
                    child: Text(
                      'Join us to celebrate our shared achievements and future vision!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                   SizedBox(height: 16),
                   Center(
                    child: Icon(
                      Icons.handshake_outlined, // Using Material handshake icon
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) : CircularProgressIndicator(),
      ),
    );
  }

  showProfileDetails() async {

    WidgetsBinding.instance.addPostFrameCallback((_) {

      ResponsiveInfo.showLoaderDialog(context);
    });
    //ResponsiveInfo.ShowProgressDialog(context);
    Map<String,String> m=new HashMap();
    ApiHelper apihelper1 = new ApiHelper();

    var response2= await  apihelper1.post(Apimethodes.getUserDetails,formDataPayload: m);
    WidgetsBinding.instance.addPostFrameCallback((_) {

      Navigator.pop(context);
    });
    var js= jsonDecode(jsonDecode(response2)) ;
    ProfileDataEntity entity=ProfileDataEntity.fromJson(js);

    setState(() {

      email=entity.data!.emailId.toString();
      phone=entity.data!.mobile.toString();
      fullname=entity.data!.fullName.toString();
    });


    // Navigator.pop(context);
  }

  // Helper widget for consistent detail text style
  Widget _buildDetailText(String text) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style:  TextStyle(
          color: Colors.white,
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }



  getEventDetails()async
  {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      ResponsiveInfo.showLoaderDialog(context);
    });
    String? token= await AppStorage.getString(AppStorage.token);
    final response = await SavekartApiService.get(
      Apimethodes.getEventData,
      token: token!,
    );

    print(response);

    WidgetsBinding.instance.addPostFrameCallback((_) {

   Navigator.pop(context);
    });

    if(response!=null )
      {
        SSMEventEntity smm=SSMEventEntity.fromJson(response);
        
        if(smm.status.toString().compareTo("true")==0)
          {
            
            setState(() {

              ssmdata=smm.data!;
              DateTime parsedDate = DateTime.parse(ssmdata!.eventDate!.toString());
               formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
             // getEventTicket(ssmdata!.id.toString());
            });

         
            
          }
        else{
          
          ResponsiveInfo.showAlertDialog(context, "Savekart", "No events scheduled");
          
        }
        
        
        
        
      }



  }


  getEventTicket(String eventid)async{

    WidgetsBinding.instance.addPostFrameCallback((_) {

      ResponsiveInfo.showLoaderDialog(context);
    });

    String? token= await AppStorage.getString(AppStorage.token);

    final res = await SavekartApiService.post(
      Apimethodes.getEventTicket,
      token: token,
      body: {
        'eventId': eventid,
        'mobile': widget.mobile
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {


      Navigator.pop(context);
    });

    if(res!=null)
      {

        SSMTicketEntity smm=SSMTicketEntity.fromJson(res);

        if(smm!=null)
          {

            if(smm.status.toString().compareTo("true")==0)
              {

                setState(() {
                  if(smm.data!=null)
                  {

                    if(smm.data!.length>0)
                    {



                      ssmt=smm.data![0];

                      qrstring=   EncryptionHelper.encryptText(ssmt!.toJson().toString());

                    }



                  }

                });


              }



          }


      }






  }









}

