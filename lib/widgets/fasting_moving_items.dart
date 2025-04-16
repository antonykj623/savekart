
import 'package:flutter/material.dart';

import '../design/ResponsiveInfo.dart';


class FastingMovingItems extends StatelessWidget {
   FastingMovingItems() ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height/1.52,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

            child:   Text("Fast Moving Items",maxLines: 1,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 17:20,fontWeight: FontWeight.bold,color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),

          MediaQuery.removePadding(context: context,removeBottom: false,removeLeft: false,removeRight: false,removeTop: false, child: Container(

    child:  GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.85,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(4, (index)
            {
          return GestureDetector(

            child: Center(
              child: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),

                child:  Container(

                  width: ResponsiveInfo.isMobile(context)? 150:180,
                  height: ResponsiveInfo.isMobile(context)? 185 :215,
                  padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:8),

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),

                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Expanded(child:Stack(

                        children: [
                          Align(
                            alignment: FractionalOffset.center,
                            child: Image.asset('assets/homecategory/accblock.png',width: ResponsiveInfo.isMobile(context)?100:120,
                              height: ResponsiveInfo.isMobile(context)?100:120,fit: BoxFit.fill,) ,

                          ),

                          Align(
                            alignment: FractionalOffset.topRight,
                            child: Padding(

                              padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:8),
                              child: Container(
                                width: ResponsiveInfo.isMobile(context)?40:50,
                                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?3:5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),

                                child:
                                Text("-11%",textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?7:10,color: Colors.white),) ,
                              ),
                            )

                            ,
                          )
                        ],
                      )



                        ,flex: 2, )

                      ,

                      Expanded(child: Padding(
                        padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?5:8, 0, 0, 0),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("AAC Blocks",maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13:15,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text("200 x 100 x 150",maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 11:13,fontWeight: FontWeight.bold,color: Colors.black26),
                              textAlign: TextAlign.center,

                            ),
                            Row(
                              children: [
                                Expanded(child:     Text("\$ 1.50",maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13:15,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),flex: 1,),
                                Expanded(child: Container(

                                  child: Icon(Icons.add_box_rounded,color: Colors.green,size: ResponsiveInfo.isMobile(context)?18:23,),

                                ),flex: 1,)
                              ],
                            )


                          ],
                        ) ,
                      )

                      )




                    ],
                  ),






                ),
              )
              ,
            ),
            onTap: (){

              // Navigator.push(context,
              //     MaterialPageRoute(builder:
              //         (context) =>
              //         ProductDetailsPage()
              //     )
              // );
            },
          )

            ;
        }
        )
    ),
            width: double.infinity,
            height:MediaQuery.of(context).size.height/1.7 ,
    )





    ,)






        ],

      ),


    );
  }
}
