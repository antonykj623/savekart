
import 'package:flutter/material.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/category_entity.dart';

class CategoryWidget extends StatelessWidget {

  List<String>images=['masonry-removebg-preview.png','ConcreateReady-removebg-preview.png','ConstructionChemicals-removebg-preview.png',
  'SteelspacersScaffolding-removebg-preview.png','plasterandmoter-removebg-preview.png','precast-removebg-preview.png',
  'drywall-removebg-preview.png','landscape-removebg-preview.png','cement_Sand-removebg-preview.png','whiteewood-removebg-preview.png'];

  List<String>text=['Mansonry','Concrete\nReady','Construction chemicals','Steel,spacer & Scaffolding','Plaster&mortar','PreCast',
  'Drywall & Gypsum','Landscape','Cement & Sand','White wood'];
  List<CategoryData> categorydata = [];


  CategoryWidget(this.categorydata);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width/1.6,
      child: GridView.count(
          crossAxisCount: 5,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
          shrinkWrap: true,
          primary: false,
          children: List.generate(categorydata!.length, (index) {
            return Container(


              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    width: ResponsiveInfo.isMobile(context)? 50:70,
                    height: ResponsiveInfo.isMobile(context)? 50:70,
                    child: Center(
                      child:Image.network(EcommerceApiHelper.categoryimageurl+ categorydata[index].image.toString(),width: ResponsiveInfo.isMobile(context)?50:60,
                        height: ResponsiveInfo.isMobile(context)?50:60,) ,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF9fddff),
                    ),
                  ),


                  Text(categorydata[index].categoryName.toString(),maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 10:13,fontWeight: FontWeight.bold),
                   textAlign: TextAlign.center,
                  ),

                ],
              ),
            );
          }
          )
      ),
    )


      ;





  }
}