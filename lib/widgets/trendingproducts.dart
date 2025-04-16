
import 'package:flutter/material.dart';

import '../design/ResponsiveInfo.dart';


class Trendingproducts extends StatelessWidget {
   Trendingproducts() ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width/1.25,
      color: Color(0xffEAFFC8),
      child: Column(

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

                child:   Text("Trending Products",maxLines: 1,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 17:20,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),



              Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

                child: Image.asset('assets/homecategory/rightcirclearrow.png',width: 30,height: 30,fit: BoxFit.fill,)
              ),

            ],

          ),

          MediaQuery.removePadding(context: context, child: Container(
            width: double.infinity,
            height: ResponsiveInfo.isMobile(context)?200:220,

            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?10:15, 0, ResponsiveInfo.isMobile(context)?10:15, 0),
              children:

              List.generate(
                5,
                    (i) =>GestureDetector(

                      child:Padding(padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?5:10, 0, ResponsiveInfo.isMobile(context)?5:10, 0),

                        child:  Container(

                            width: ResponsiveInfo.isMobile(context)? 140:173,
                            height: ResponsiveInfo.isMobile(context)? 165 :195,

                            child: Card(
                              child: Column(
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
                              color: Colors.white,
                              elevation: ResponsiveInfo.isMobile(context)?5:10,
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










              ),
            ) ,
          )
            ,removeBottom: false,removeLeft: false,removeRight: false,removeTop: false,)






        ],

      ),


    );
  }
}
