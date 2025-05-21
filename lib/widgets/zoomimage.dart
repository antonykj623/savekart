import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class ZoomableImageScreen extends StatefulWidget {

  String imageUrl ;
  List<String>images=[];

  ZoomableImageScreen(this.imageUrl,this.images);

  @override
  ZoomableImageScreenState createState() => ZoomableImageScreenState(this.imageUrl,this.images);
}

class ZoomableImageScreenState extends State<ZoomableImageScreen> {
   String imageUrl ;
   List<String>images=[];
   List<Widget>w=[];

   int AdsCurrentIndex=0;

   ZoomableImageScreenState(this.imageUrl,this.images);

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i=0;i<images.length;i++)
      {

        if(images[i].compareTo(imageUrl)==0)
          {
            setState(() {
              AdsCurrentIndex=i;
            });

            break;

          }



      }


  }

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: AppBar(),
      body: Column(

        children: [
          Expanded(child:InteractiveViewer(
            panEnabled: true, // Enable dragging
            boundaryMargin: EdgeInsets.all(20),
            minScale: 1.0,  // Minimum zoom level
            maxScale: 5.0,
            // Maximum zoom level
            child:




            Image.network(images[AdsCurrentIndex], loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // Image loaded successfully
              return Center(child: CircularProgressIndicator()); // Show loader while loading
            },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
              },),
          ),flex: 4, ),

          Expanded(child:   Padding(padding: EdgeInsets.all(5),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                IconButton(onPressed: (){

                  if(AdsCurrentIndex>0)
                    {
                      setState(() {
                        AdsCurrentIndex=AdsCurrentIndex-1;
                      });
                    }



                }, icon: Icon(Icons.arrow_back_ios,size: 25,)),



                IconButton(onPressed: (){

                  if(AdsCurrentIndex<images.length-1)
                  {
                    setState(() {
                      AdsCurrentIndex=AdsCurrentIndex+1;
                    });
                  }



                }, icon: Icon(Icons.arrow_forward_ios_sharp,size: 25,))
              ],



            )
          ),flex: 1,)



        ],
      )










    );
  }
}
