




import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/widgets/searchproduct.dart';

import '../design/ResponsiveInfo.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';
import 'cartscreen.dart';

class AppbarWidgett extends StatefulWidget {
  @override
  _AppbarWidgettState createState() => _AppbarWidgettState();
}

class _AppbarWidgettState extends State<AppbarWidgett> {
  final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  String? selectedValue;
  String cartcount="0";

  late Timer timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartCount();
  }



  @override
  Widget build(BuildContext context) {
    return  Container(

      width: double.infinity,
      // decoration: BoxDecoration(
      //     color:const Color.fromARGB(224, 255, 255, 255),
      //     borderRadius: BorderRadius.circular(60)
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
Expanded(child: Stack(

          children: [

            Align(
          alignment: FractionalOffset.centerLeft,
        child: Padding(
          
          padding: EdgeInsets.all(10),
          child: Image.asset("assets/splashtwo.jpeg",width: MediaQuery.sizeOf(context).width/2,height: (MediaQuery.sizeOf(context).width/2)/2.99,fit: BoxFit.fill,)
          ,
        )
        
        
        ,
      )
        ],
      )


,flex: 2,)

          ,

          Expanded(child: Row(
            children: [

              Expanded(child: IconButton(onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) =>
                            ProductSearchScreen()
                    )
                );

              }, icon: Icon(Icons.search_rounded,color: Color(0xff0B7D97),)),flex: 1,),
              Expanded(child:  Stack(
                children: [

                  Align(
                    alignment: FractionalOffset.center,
                    child:GestureDetector(

                      child: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

                        child: Icon(Icons.shopping_cart,color: Color(0xff0B7D97),size: ResponsiveInfo.isMobile(context)?20:25,),

                      ),
                      onTap: (){

                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context) =>
                                CartScreen()
                            )
                        );
                      },
                    ) ,
                  ),
                  (cartcount.compareTo("0")!=0)?  Align(alignment: FractionalOffset.topCenter,

                      child: GestureDetector(

                          child:

                      Padding(padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?10:15,ResponsiveInfo.isMobile(context)?25:35,0,0),

                        child:CircleAvatar(
                          radius: ResponsiveInfo.isMobile(context)?8:10,
                          backgroundColor: Colors.red,
                          child: Text(cartcount,style: TextStyle(color: Colors.white,fontSize: ResponsiveInfo.isMobile(context)?12:14),),
                        )


                        ,) ,

                      onTap: (){

                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context) =>
                                CartScreen()
                            )
                        );
                      },

                      )

                  ) : Container(),
                ],

              ),flex: 1,)



            ],
          ),flex: 1,)


          ,


        ],
      ),
    );
  }

  getCartCount()async
  {
    // ResponsiveInfo.ShowProgressDialog(context);

    timer = Timer.periodic(Duration(seconds: 6), (Timer t) async {
      EcommerceApiHelper apihelper = new EcommerceApiHelper();

      var t=EcommerceApiHelper.getTimeStamp();

      var response= await  apihelper.get(Apimethodes.getCartDataCount+"?q="+t.toString());

      var js= jsonDecode( response) ;

      if(js['status']==1)
      {

        String c=js['data'].toString();

        setState(() {
          cartcount=c;

        });

      }
    });



  }
}




void main() {
  runApp(MaterialApp(
    home: AppbarWidgett(),
  ));
}