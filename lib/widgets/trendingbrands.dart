import 'package:flutter/material.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/brand_entity.dart';



class Trendingbrands extends StatelessWidget {

  List<BrandData> data = [];


   Trendingbrands(this.data) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width/2.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

          child:   Text("Trending Brands",maxLines: 1,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 17:20,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ),

          MediaQuery.removePadding(context: context, child: Container(
    width: double.infinity,
    height: ResponsiveInfo.isMobile(context)?100:130,

    child: ListView(
      scrollDirection: Axis.horizontal,
      children:

      List.generate(
        data.length,
            (i) => Container(

          width: 90,
          height: 100,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                width: ResponsiveInfo.isMobile(context)? 50:70,
                height: ResponsiveInfo.isMobile(context)? 50:70,
                child: Center(
                  child:Image.network(EcommerceApiHelper.brandimageurl+data[i].image.toString(),width: ResponsiveInfo.isMobile(context)?50:60,
                    height: ResponsiveInfo.isMobile(context)?50:60,) ,
                ),
                // decoration: BoxDecoration(
                //   shape: BoxShape.circle,
                //   color: Color(0xFF9fddff),
                // ),
              ),


              Text(data[i].name.toString(),maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 10:13,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      ),
    ) ,
    )
          ,removeBottom: false,removeLeft: false,removeRight: false,removeTop: false,)



        ],
      )



    );
  }
}
