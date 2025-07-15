import 'dart:async';

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
  Timer? _timer;
  _SlidbarrState(this.bannersdata);
  PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
loadData();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (AdsCurrentIndex < w.length - 1) {
        AdsCurrentIndex++;
      } else {
        AdsCurrentIndex = 0;
      }
      _pageController.animateToPage(
        AdsCurrentIndex,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });


  }

  @override
  Widget build(BuildContext context) {





    return (w.length>0)? Column(
      children: [
        SizedBox(
          height: 200, // Adjust height as needed
          child: PageView.builder(
            controller: _pageController,
            itemCount: bannersdata.length,
            onPageChanged: (index) {
              setState(() {
                AdsCurrentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Transform.scale(
                scale: AdsCurrentIndex == index ? 1.0 : 0.9,
                child: w[index],  // Assuming `w` contains the widgets/images
              );
            },
          ),
        ),
        SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: AdsCurrentIndex,
          count: bannersdata.length,
          effect: WormEffect(
            dotWidth: 12,
            dotHeight: 12,
            dotColor: Colors.grey,
            activeDotColor: Colors.black,
            paintStyle: PaintingStyle.fill,
          ),
        ),
      ],
    ):Container();



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

          w.add(Card(
            elevation: 10,

            child: Image.network(ApiHelper.bannerimageurl+ cbd.imageFile.toString()+"?q="+t,width: screenWidth,
                height: screenWidth/2, loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child; // Image loaded successfully
                  return Center(child: CircularProgressIndicator()); // Show loader while loading
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image,size: 60,color: Colors.black26,); // Show a local placeholder on error
                },fit: BoxFit.fill) ,
          )


              );
        }
      });
      // Safe to use context here
    });


  }
}