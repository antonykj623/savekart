
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/domain/brand_entity.dart';
import 'package:savekart/domain/cart_banners_entity.dart';
import 'package:savekart/domain/category_entity.dart';
import 'package:savekart/domain/product_by_category_entity.dart';
import 'package:savekart/domain/sub_category_entity.dart';
import 'package:savekart/domain/wallet_points_entity.dart';
import 'package:savekart/web/AppStorage.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';
import 'package:savekart/widgets/product_details.dart';

import '../../design/ResponsiveInfo.dart';
import '../../domain/wallet_balance_entity.dart';
import '../../web/apimethodes.dart';
import '../Appbar_widget.dart';
import '../CategoryWidget.dart';
import '../Slidbarscreen.dart';
import '../fasting_moving_items.dart';
import '../productsbycategory.dart';
import '../todays_special_offer.dart';
import '../todaysbulkdetails.dart';
import '../trendingbrands.dart';
import '../trendingproducts.dart';



class Dashboard extends StatefulWidget {
   Dashboard();

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<CategoryData> categorydata = [];

  List<BrandData> data = [];

  List<SubCategoryData> subcategorydata=[];
  List<ProductByCategoryData> productbycategorydata = [];
  List<CartBannersData> bannersdata = [];
  double walletbalance=0.0;
  int walletpoints=0;

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
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Expanded(child: AppbarWidgett(),flex: 1,),

          Expanded(child: SingleChildScrollView(

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
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("Wallet Balance", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
    SizedBox(height: 5),
    Row(
    children: [
    Icon(Icons.account_balance_wallet, color: Colors.green, size: 24),
    SizedBox(width: 8),
    Text(""+walletbalance.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
    ],
    ),
    ],
    ),

    // Reward Points
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("Wallet Points", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
    SizedBox(height: 5),
    Row(
    children: [
    Icon(Icons.star, color: Colors.orange, size: 24),
    SizedBox(width: 8),
    Text(walletpoints.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
    ],
    ),
    ],
    ),
    ],
    ),
    ),
    ),

              (categorydata!.length>0)? Container(
                width: double.infinity,
                height: 90*((categorydata.length/4)*2),
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

                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsByCategoryScreen(categoryId: categorydata[index].id.toString(),categoryname: categorydata[index].categoryName.toString(),),
                            ),
                          );

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


                            Text(categorydata[index].categoryName.toString(),maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 10:13,fontWeight: FontWeight.bold),
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

                    List<ProductByCategoryDataData> data =
                    productbycategorydata[index].data!;

                    return Container(
                      width: double.infinity,
                      height: ResponsiveInfo.isMobile(context)? 250 :280,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Padding(padding: EdgeInsets.all(10),
                          child: Text( productbycategorydata[index].category!.categoryName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: ResponsiveInfo.isMobile(context)?15:17),),
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

                                              //offer commented by antony

                                              // Align(
                                              //   alignment: FractionalOffset.topRight,
                                              //   child: Padding(
                                              //
                                              //     padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:8),
                                              //     child: Container(
                                              //       width: ResponsiveInfo.isMobile(context)?40:50,
                                              //       padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?3:5),
                                              //       decoration: BoxDecoration(
                                              //           color: Colors.red,
                                              //           border: Border.all(
                                              //             color: Colors.red,
                                              //           ),
                                              //           borderRadius: BorderRadius.all(Radius.circular(5))
                                              //       ),
                                              //
                                              //       child:
                                              //       Text("-11%",textAlign: TextAlign.center,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?7:10,color: Colors.white),) ,
                                              //     ),
                                              //   )
                                              //
                                              //   ,
                                              // )
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
                                                Text(data[i].productName.toString(),maxLines: 2,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13:15,fontWeight: FontWeight.bold),
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
                              onTap: (){

                                Navigator.push(context,
                                    MaterialPageRoute(builder:
                                        (context) =>
                                        ProductDetails(data[i])
                                    )
                                );
                              },
                            ),
                          ) ),
                          )

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
          ),flex: 6,)

        ],
      )







      ,
    );
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
    print(js1);

    WalletPointsEntity entity=WalletPointsEntity.fromJson(js1);

    walletpoints=int.parse(entity.data!.balance.toString());

    AppStorage.setString(AppStorage.walletpoint, walletpoints.toString());
    // String? currentWalletPoints=await AppStorage.getString(AppStorage.current_wallet_point);


      AppStorage.setString(
          AppStorage.current_wallet_point, walletpoints.toString());



    setState(()  {
      if(entity.status==1)
        {
          walletpoints=int.parse(entity.data!.balance.toString());
        }
      else{
        walletpoints=0;
      }




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

    ProductByCategoryEntity brandEntity=ProductByCategoryEntity.fromJson(js);

    if(brandEntity.data!.length>0)
    {
      setState(() {

        productbycategorydata.addAll(brandEntity.data!);

      });
    }
  }
}