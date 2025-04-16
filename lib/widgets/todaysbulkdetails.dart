import 'package:flutter/material.dart';

import '../design/ResponsiveInfo.dart';



class Todaysbulkdetails extends StatelessWidget {

  List<String>datas=['bulk1.png','bulk1.png'];


   Todaysbulkdetails() ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width/2.3,

      child: Column(

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

                child:   Text("Today’s Bulk Deals",maxLines: 1,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 17:20,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),



              Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

                  child: Image.asset('assets/homecategory/blackarrow.png',width: 30,height: 30,fit: BoxFit.fill,)
              ),

            ],

          ),

          MediaQuery.removePadding(context: context, child: Container(
            width: double.infinity,
            height: ResponsiveInfo.isMobile(context)?100:110,

            child: GestureDetector(

              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?10:15, 0, ResponsiveInfo.isMobile(context)?10:15, 0),
                children:

                List.generate(
                    datas.length,
                        (i) => Padding(padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?5:10, 0, ResponsiveInfo.isMobile(context)?5:10, 0),

                      child:  Image.asset('assets/homecategory/'+datas[i],width: ResponsiveInfo.isMobile(context)? 237:250,
                        height: ResponsiveInfo.isMobile(context)? 98 :105,fit: BoxFit.fill,) ,
                    )







                ),
              ) ,
              onTap: (){

                // Navigator.push(context,
                //     MaterialPageRoute(builder:
                //         (context) =>
                //         ProductDetailsPage()
                //     )
                // );
              },
            )



            ,
          )
            ,removeBottom: false,removeLeft: false,removeRight: false,removeTop: false,)






        ],

      ),


    );
  }
}
