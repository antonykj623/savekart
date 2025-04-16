import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:savekart/web/api_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../domain/cart_banners_entity.dart';
import '../web/ecommerce_api_helper.dart';


class Slidbar extends StatefulWidget {
  List<CartBannersData> bannersdata = [];

   Slidbar(this.bannersdata);

  @override
  State<Slidbar> createState() => _SlidbarrState(this.bannersdata);
}

class _SlidbarrState extends State<Slidbar> {

  int AdsCurrentIndex= 0;
  List<CartBannersData> bannersdata = [];

  List<Widget>w=[];

  _SlidbarrState(this.bannersdata);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
loadData();

  }

  @override
  Widget build(BuildContext context) {



    return
       Column(
        children: [
             CarouselSlider( options: CarouselOptions(
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: Duration(microseconds: 800),
              autoPlayInterval: Duration(seconds: 2),
              autoPlay: true,
            //  height: 200,
              enlargeCenterPage: true,
              aspectRatio: 1.78,
              onPageChanged: (index, reason) {
                setState(() {
                  AdsCurrentIndex = index;
                });
              },
             ),
             items: w,
             ),
             AnimatedSmoothIndicator(activeIndex: AdsCurrentIndex,
              count: bannersdata.length,
              effect: 
              WormEffect(
                dotWidth: 12,
                dotHeight: 12,
                dotColor: Colors.grey,
               // spacing: 2,
                activeDotColor: Colors.black,
                paintStyle: PaintingStyle.fill
                ),
              )
        ],
      )
    ;
  }


  loadData()
  {
    w=[];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      print("Screen width: $screenWidth");
      setState(() {


        for(CartBannersData cbd in bannersdata)
        {

          String t=ApiHelper.getTimeStamp();

          print("Slider url : "+ApiHelper.bannerimageurl+ cbd.imageFile.toString());

          w.add(Image.network(ApiHelper.bannerimageurl+ cbd.imageFile.toString()+"?q="+t,width: screenWidth,
            height: screenWidth/1.78, loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // Image loaded successfully
              return Center(child: CircularProgressIndicator()); // Show loader while loading
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image,size: 60,color: Colors.black26,); // Show a local placeholder on error
            },) );
        }
      });
      // Safe to use context here
    });


  }
}