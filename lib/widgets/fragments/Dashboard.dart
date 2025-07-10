
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:savekart/domain/brand_entity.dart';
import 'package:savekart/domain/cart_banners_entity.dart';
import 'package:savekart/domain/category_entity.dart';
import 'package:savekart/domain/product_by_category_entity.dart';
import 'package:savekart/domain/sub_category_entity.dart';
import 'package:savekart/domain/wallet_points_entity.dart';
import 'package:savekart/web/AppStorage.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';
import 'package:savekart/widgets/product_details.dart';
import 'package:savekart/widgets/purchase_points.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../design/ResponsiveInfo.dart';
import '../../domain/app_version_entity.dart';
import '../../domain/product_sub_category_entity.dart';
import '../../domain/wallet_balance_entity.dart';
import '../../web/apimethodes.dart';

import '../CategoryWidget.dart';
import '../Slidbarscreen.dart';
import '../all_products_by_category.dart';
import '../cartscreen.dart';
import '../fasting_moving_items.dart';
import '../productsbycategory.dart';
import '../searchproduct.dart';
import '../todays_special_offer.dart';
import '../todaysbulkdetails.dart';
import '../trendingbrands.dart';
import '../trendingproducts.dart';
import '../wallet_transaction.dart';



class Dashboard extends StatefulWidget {
   Dashboard();

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<CategoryData> categorydata = [];

  List<BrandData> data = [];

  List<SubCategoryData> subcategorydata=[];
  List<ProductSubCategoryData> productbycategorydata = [];
  List<CartBannersData> bannersdata = [];
  double walletbalance=0.0;
  String cartcount="0";
  int walletpoints=0;
  final StreamController<SwipeRefreshState> _controller = StreamController<SwipeRefreshState>();
  Stream<SwipeRefreshState> get myRefreshStateStream => _controller.stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBanners();
    getCategories();
    getBrands();
    getSubCategoriess();
    getProductWithSubcategory();
    getWalletBalanceAndPoints();
    getWalletPoints();
    getCartCount();
    getAppUpdates();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1)); // simulate network fetch
    getBanners();
    getCategories();
    getBrands();
    getSubCategoriess();
    getProductWithSubcategory();
    getWalletBalanceAndPoints();
    getWalletPoints();
    getCartCount();
    getAppUpdates();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        forceMaterialTransparency: true,
        title:Align(
          alignment: FractionalOffset.centerLeft,
          child: Padding(

            padding: EdgeInsets.all(2),
            child: Image.asset("assets/appbaricon.jpeg",width: MediaQuery.sizeOf(context).width/2,height: (MediaQuery.sizeOf(context).width/2)/2,fit: BoxFit.fill,)
            ,
          )


          ,
        ) ,
        centerTitle: false,


        actions: [
          IconButton(onPressed: () async {


            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductSearchScreen()),
            );

            if (result != null||result==null) {

              getCartCount();
              getWalletPoints();
              getWalletBalanceAndPoints();

            }

          }, icon: Icon(Icons.search_rounded,color: Color(0xff0B7D97),)),


          Stack(
            children: [

              Align(
                alignment: FractionalOffset.center,
                child:GestureDetector(

                  child: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

                    child: Icon(Icons.shopping_cart,color: Color(0xff0B7D97),size: ResponsiveInfo.isMobile(context)?20:25,),

                  ),
                  onTap: () async {

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );

                    if (result != null||result==null) {

                      getCartCount();
                      getWalletPoints();
                      getWalletBalanceAndPoints();

                    }
                  },
                ) ,
              ),
              (cartcount.compareTo("0")!=0)?  Align(alignment: FractionalOffset.topCenter,

                  child: GestureDetector(

                    child:

                    Padding(padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?10:15,ResponsiveInfo.isMobile(context)?5:6,0,0),

                      child:CircleAvatar(
                        radius: ResponsiveInfo.isMobile(context)?8:10,
                        backgroundColor: Colors.red,
                        child: Text(cartcount,style: TextStyle(color: Colors.white,fontSize: ResponsiveInfo.isMobile(context)?12:14),),
                      )


                      ,) ,

                    onTap: () async {




                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );

                      if (result != null||result==null) {

                        getCartCount();
                        getWalletPoints();
                        getWalletBalanceAndPoints();

                      }



                    },

                  )

              ) : Container(),
            ],

          )



        ],

      ),
      body:RefreshIndicator(

    onRefresh: _handleRefresh,




    child:  SingleChildScrollView(

      child:Column(children: [

        (bannersdata.length>0)? Slidbar(bannersdata) : Container(
          width: double.infinity,
          height: ResponsiveInfo.isMobile(context)?150:200,
          child: Center(

            child: CircularProgressIndicator(),
          ),

        ),
        SizedBox(
          height:ResponsiveInfo.isMobile(context)? 20:25,
        ),

        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Wallet Balance

                GestureDetector(
                  onTap: (){          Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context) =>
                          WalletTransaction()
                      )
                  );},

                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Savekart Wallet Balance", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.account_balance_wallet, color: Colors.green, size: 24),
                          SizedBox(width: 8),
                          Text(""+walletbalance.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                        ],
                      ),
                    ],
                  ) ,
                )
                ,

                // Reward Points

                GestureDetector(

                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Purchase Points", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 24),
                          SizedBox(width: 8),
                          Text(walletpoints.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                        ],
                      ),
                    ],
                  ) ,
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            PurchasePoints()
                        )
                    );

                  },
                )



                ,
              ],
            ),
          ),
        ),

        (categorydata!.length>0)? Container(
          width: double.infinity,
          height: 75*((categorydata.length/4)*2),
          child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              children: List.generate(categorydata!.length, (index) {
                return GestureDetector(

                    onTap: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProductsByCategoryScreen(categoryId: categorydata[index].id.toString(),categoryname: categorydata[index].categoryName.toString(),),
                      //   ),
                      // );

                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AllProductsByCategory(categoryId: categorydata[index].id.toString(),categoryname: categorydata[index].categoryName.toString(),)),
                      );

                      if (result != null||result==null) {

                        getCartCount();
                        getWalletPoints();
                        getWalletBalanceAndPoints();

                      }




                    },



                    child:  Container(


                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                            width: ResponsiveInfo.isMobile(context)? 50:70,
                            height: ResponsiveInfo.isMobile(context)? 50:70,
                            child: Center(
                              child:Image.network(EcommerceApiHelper.categoryimageurl+ categorydata[index].image.toString(),width: ResponsiveInfo.isMobile(context)?50:60,
                                height: ResponsiveInfo.isMobile(context)?50:60, loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child; // Image loaded successfully
                                  return Center(child: CircularProgressIndicator()); // Show loader while loading
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
                                },) ,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                          ),


                          Text(categorydata[index].categoryName.toString(),maxLines: 3,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 10:13,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ) );
              }
              )
          ),
        ) : Container(
          width: double.infinity,
          height: ResponsiveInfo.isMobile(context)?150:200,
          child: Center(

            child: CircularProgressIndicator(),
          ),

        ),



        // (data.length>0)?  Trendingbrands(data):Container(),
        //
        //
        // (subcategorydata!.length>0)? Padding(padding: EdgeInsets.all(10),
        //
        // child: Text("Your Favourites",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
        // ) : Container(),
        //
        // (subcategorydata!.length>0)? Container(
        //   width: double.infinity,
        //   height: MediaQuery.of(context).size.width/1.6,
        //   child: GridView.count(
        //       crossAxisCount: 4,
        //       crossAxisSpacing: 4.0,
        //       mainAxisSpacing: 8.0,
        //       childAspectRatio: 0.7,
        //       shrinkWrap: true,
        //       primary: false,
        //       children: List.generate(subcategorydata!.length, (index) {
        //         return Container(
        //
        //
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //
        //               Container(
        //                 width: ResponsiveInfo.isMobile(context)? 50:70,
        //                 height: ResponsiveInfo.isMobile(context)? 50:70,
        //                 child: Center(
        //                   child:Image.network(EcommerceApiHelper.categoryimageurl+ subcategorydata[index].image.toString(),width: ResponsiveInfo.isMobile(context)?50:60,
        //                     height: ResponsiveInfo.isMobile(context)?50:60,) ,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   shape: BoxShape.circle,
        //                   color: Colors.transparent,
        //                 ),
        //               ),
        //
        //
        //               Text(subcategorydata[index].subCategoryName.toString(),maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 10:13,fontWeight: FontWeight.bold),
        //                 textAlign: TextAlign.center,
        //               ),
        //
        //             ],
        //           ),
        //         );
        //       }
        //       )
        //   ),
        // ) : Container(),


        (productbycategorydata.length>0)? ListView.builder(
            itemCount: productbycategorydata.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {

              List<ProductSubCategoryDataData> data =
              productbycategorydata[index].data!;

              List<List<ProductSubCategoryDataData>> chunkedList = [];
              int chunkSize = 5;

              if(productbycategorydata[index].data!.length>5) {
                for (int i = 0; i < data.length; i += chunkSize) {
                  int end = (i + chunkSize < data.length) ? i + chunkSize : data
                      .length;
                  chunkedList.add(data.sublist(i, end));
                }
              }

              return (productbycategorydata[index].data!.length<=5)?Container(
                  width: double.infinity,
                  height: ResponsiveInfo.isMobile(context)? 270 :320,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Padding(padding: EdgeInsets.all(10),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                          Expanded(child:  Text( productbycategorydata[index].category!.subCategoryName.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: ResponsiveInfo.isMobile(context)?15:17),),flex: 3,),

              Expanded(child:    TextButton(onPressed: () async {

                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProductsByCategoryScreen(categoryId: productbycategorydata[index].category!.subCategoryId.toString(),categoryname: productbycategorydata[index].category!.subCategoryName.toString(),)),
                                );

                                if (result != null||result==null) {

                                  getCartCount();
                                  getWalletPoints();
                                  getWalletBalanceAndPoints();

                                }


                              }, child: Text("View All",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?15:18,color: Color(0xff0B7D97)),)),flex: 1,)

                            ],

                          )



                      ),

                      Padding(padding: EdgeInsets.all(10),

                        child: Container(
                            width: double.infinity,
                            height: ResponsiveInfo.isMobile(context)? 180 :210,
                            child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: productbycategorydata[index].data!.length,
                              itemBuilder: (BuildContext context, int i) => GestureDetector(

                                child:Padding(padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?5:10, 0, ResponsiveInfo.isMobile(context)?5:10, 0),

                                  child:  Container(

                                      width: ResponsiveInfo.isMobile(context)? 140:173,
                                      height: ResponsiveInfo.isMobile(context)? 170 :195,

                                      child: Card(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            Expanded(child:Stack(

                                              children: [
                                                Align(
                                                  alignment: FractionalOffset.center,
                                                  child: Image.network(EcommerceApiHelper.productimageurl+data[i].primeImage.toString(),width: ResponsiveInfo.isMobile(context)?100:120,
                                                    height: ResponsiveInfo.isMobile(context)?100:120,fit: BoxFit.fill,loadingBuilder: (context, child, loadingProgress) {
                                                      if (loadingProgress == null) return child; // Image loaded successfully
                                                      return Center(child: CircularProgressIndicator()); // Show loader while loading
                                                    },
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
                                                    },) ,

                                                ),


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
                                                  Text(data[i].productName.toString(),maxLines: 3,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13:15,fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  // Text("200 x 100 x 150",maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 11:13,fontWeight: FontWeight.bold,color: Colors.black26),
                                                  //   textAlign: TextAlign.center,
                                                  //
                                                  // ),

                                                  //Price area commented by antony

                                                  // Row(
                                                  //   children: [
                                                  //     Expanded(child:     Text("150 Rs",maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13:15,fontWeight: FontWeight.bold),
                                                  //       textAlign: TextAlign.center,
                                                  //     ),flex: 1,),
                                                  //     Expanded(child: Container(
                                                  //
                                                  //       child: Icon(Icons.add_box_rounded,color: Colors.green,size: ResponsiveInfo.isMobile(context)?18:23,),
                                                  //
                                                  //     ),flex: 1,)
                                                  //   ],
                                                  // )


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
                                onTap: () async {




                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ProductDetails(data[i])),
                                  );

                                  if (result != null||result==null) {

                                    getCartCount();
                                    getWalletPoints();
                                    getWalletBalanceAndPoints();

                                  }


                                },
                              ),
                            ) ) ,
                      )

                    ],
                  )




              ) :
              Container(
                width: double.infinity,
                height: ResponsiveInfo.isMobile(context)? (220*(productbycategorydata[index].data!.length / 5).ceil())+10 :(250*(productbycategorydata[index].data!.length / 5).ceil())+20,


                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Padding(padding: EdgeInsets.all(10),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Expanded(child: Text( productbycategorydata[index].category!.subCategoryName.toString(),overflow: TextOverflow.ellipsis,maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: ResponsiveInfo.isMobile(context)?15:17),),flex: 3,)

                          ,

              Expanded(child:  TextButton(onPressed: () async {

                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductsByCategoryScreen(categoryId: productbycategorydata[index].category!.subCategoryId.toString(),categoryname: productbycategorydata[index].category!.subCategoryName.toString(),)),
                            );

                            if (result != null||result==null) {

                              getCartCount();
                              getWalletPoints();
                              getWalletBalanceAndPoints();

                            }


                          }, child: Text("View All",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?15:18,color: Color(0xff0B7D97)),)),flex: 1,)

                        ],

                      )



                                         ),
                    Padding(padding: EdgeInsets.only(left: 10),
                      child: Container(
                          width: double.infinity,
                          height: ResponsiveInfo.isMobile(context)? (190.0*(productbycategorydata[index].data!.length / 5).ceil()) :(220.0*(productbycategorydata[index].data!.length / 5).ceil()),

                          child: ListView.builder(
                          itemCount: chunkedList.length,
                            physics: NeverScrollableScrollPhysics(),


              itemBuilder: (context, chunkIndex) {
              List<ProductSubCategoryDataData> sublist = chunkedList[chunkIndex];

              return Padding(padding: EdgeInsets.only(left: 10,top: 5),
                  child:Container(
                  width: double.infinity,
                  height:
                  ResponsiveInfo.isMobile(context)? 180:210,

                  child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                itemCount: sublist.length,
                itemBuilder: (BuildContext context, int i) => GestureDetector(

                  child:Padding(padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?5:10, 0, ResponsiveInfo.isMobile(context)?5:10, 0),

                    child:  Container(

                        width: ResponsiveInfo.isMobile(context)? 140:173,
                        height: ResponsiveInfo.isMobile(context)? 170 :195,

                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Expanded(child:Stack(

                                children: [
                                  Align(
                                    alignment: FractionalOffset.center,
                                    child: Image.network(EcommerceApiHelper.productimageurl+sublist[i].primeImage.toString(),width: ResponsiveInfo.isMobile(context)?100:120,
                                      height: ResponsiveInfo.isMobile(context)?100:120,fit: BoxFit.fill,loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child; // Image loaded successfully
                                        return Center(child: CircularProgressIndicator()); // Show loader while loading
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
                                      },) ,

                                  ),


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
                                    Text(sublist[i].productName.toString(),maxLines: 3,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13:15,fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),


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
                  onTap: () async {




                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetails(sublist[i])),
                    );

                    if (result != null||result==null) {

                      getCartCount();
                      getWalletPoints();
                      getWalletBalanceAndPoints();

                    }


                  },
                ),
              ) ) );
              },
              )









                      ) ,
                    ),


                  ],
                )



              );
            }) : Container(
          width: double.infinity,
          height: ResponsiveInfo.isMobile(context)?150:200,
          child: Center(

            child: CircularProgressIndicator(),
          ),

        )


        // Trendingproducts(),
        // Todaysbulkdetails(),
        // Image.asset("assets/homecategory/hirenow.png",width: double.infinity,height: MediaQuery.of(context).size.width/1.75,),
        // TodaysSpecialOffer(),
        // Image.asset("assets/homecategory/rewardpoints.png",width: double.infinity,height: MediaQuery.of(context).size.width/1.75,),
        //
        // FastingMovingItems(),
        // Image.asset("assets/homecategory/lastposter.png",width: double.infinity,height: MediaQuery.of(context).size.width/1.75,),
        //











      ],) ,
    ) )







      ,
    );
  }


  getAppUpdates()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();


    String version = packageInfo.version;


    EcommerceApiHelper apihelper=new EcommerceApiHelper();
    var t=EcommerceApiHelper.getTimeStamp();
    var response1= await  apihelper.get(Apimethodes.getCartUpdate+"?q="+t.toString());
    AppVersionEntity appversion=AppVersionEntity.fromJson(jsonDecode(response1));
    if(appversion.status==1) {

      double currentversion=double.parse(version);
      String versionfromserver=appversion.data!.version.toString();
      double appversionfromserver=double.parse(versionfromserver);

     if (appversionfromserver>currentversion) {
       showDialog(
         context: context,
         barrierDismissible: false,
         builder: (context) =>
             AlertDialog(
               title: Text("App Version"),

               content: Text("New version: $versionfromserver is available"),
               actions: [
                 (appversionfromserver > currentversion) ? TextButton(
                   onPressed: () async {
                     final Uri url = Uri.parse(
                         "https://play.google.com/store/apps/details?id=com.integra.savekart"); // Change URL based on platform

                     if (await canLaunchUrl(url)) {
                       await launchUrl(
                           url, mode: LaunchMode.externalApplication);
                     } else {
                       throw "Could not launch $url";
                     }
                   },
                   child: Text("Update"),
                 ) : Container(),

               ],
             ),
       );
     }
    }

  }


  getCartCount()async
  {
    // ResponsiveInfo.ShowProgressDialog(context);

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getCartDataCount+"?q="+t.toString());

    var js= jsonDecode( response) ;

    if(js['status']==1)
    {

      String c=js['data'].toString();
      if (mounted) {
        setState(() {
          cartcount = c;
        });
      }

    }



  }

  getWalletBalanceAndPoints()
  async {
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.calculateWalletBallence+"?q="+t.toString());

    var js= jsonDecode( response) ;
    print(js);

    WalletBalanceEntity entity=WalletBalanceEntity.fromJson(js);

    if(entity!=null)
    {

      setState(() {

        walletbalance=double.parse(entity.data!.balance.toString());
      });


    }



  }

  getWalletPoints()
  async {
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();
    var response1= await  apihelper.get(Apimethodes.getWalletPoints+"?q="+t.toString());
    var js1= jsonDecode( response1) ;
    setState(()  {
      walletpoints=int.parse(js1['data'].toString());

      AppStorage.setString(AppStorage.walletpoint, walletpoints.toString());
      // String? currentWalletPoints=await AppStorage.getString(AppStorage.current_wallet_point);


      AppStorage.setString(
          AppStorage.current_wallet_point, walletpoints.toString());

    });



  }

  getBanners()async{

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getBanners+"?q="+t.toString());

    var js= jsonDecode(response) ;

    CartBannersEntity entity=CartBannersEntity.fromJson(js);

    if(entity.status==1)
      {
        entity.data?.sort((a, b) =>
            int.parse(a.orderNumber ?? '0').compareTo(int.parse(b.orderNumber ?? '0')));

        setState(() {
          bannersdata.clear();

          bannersdata?.addAll(entity.data!);
        });


      }



  }

  getCategories()async
  {
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getCategories+"?q="+t.toString());

    var js= jsonDecode(response) ;

    CategoryEntity categoryEntity=CategoryEntity.fromJson(js);

    if(categoryEntity.status==1)
      {

        setState(() {
          categorydata.clear();
          for(int i=0;i<categoryEntity.data!.length;i++)
            {
              if(categoryEntity.data![i].status.toString().compareTo("0")==0)
                {
                  categorydata!.add(categoryEntity.data![i]);
                }

            }



        });

      }


  }

  getBrands() async{

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getBrands+"?q="+t.toString());

    var js= jsonDecode(response) ;

    BrandEntity brandEntity=BrandEntity.fromJson(js);

    if(brandEntity.data!.length>0)
      {
        setState(() {

          data.clear();
          data.addAll(brandEntity.data!);
        });
      }

  }

  getSubCategoriess() async{

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getSubCategories+"?q="+t.toString());

    var js= jsonDecode(response) ;

    SubCategoryEntity brandEntity=SubCategoryEntity.fromJson(js);

    if(brandEntity.data!.length>0)
    {
      setState(() {

        subcategorydata.clear();
        subcategorydata.addAll(brandEntity.data!);
      });
    }

  }


  getProductWithSubcategory()async {

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getProductWithCategories+"?q="+t.toString());

    var js= jsonDecode(response) ;

    ProductSubCategoryEntity brandEntity=ProductSubCategoryEntity.fromJson(js);

    if(brandEntity.data!.length>0)
    {
      setState(() {
        productbycategorydata.clear();
        productbycategorydata.addAll(brandEntity.data!);

      });
    }
  }
}