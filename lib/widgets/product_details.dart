import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/domain/product_count_entity.dart';
import 'package:savekart/domain/product_stock_entity.dart';
import 'package:savekart/domain/wishlistcheck_entity.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';
import 'package:savekart/widgets/cartscreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:savekart/widgets/zoomimage.dart';
import '../domain/cart_data_exist_entity.dart';
import '../domain/cart_products_entity.dart';
import '../domain/product_by_category_entity.dart';
import '../domain/product_sub_category_entity.dart';
import '../domain/return_policy_entity.dart';
import '../web/AppStorage.dart';
import '../web/apimethodes.dart';
import 'Slidbarscreen.dart';

class ProductDetails extends StatefulWidget {

  ProductSubCategoryDataData productByCategoryDataData;
   ProductDetails(this.productByCategoryDataData) ;

  @override
  _ProductDetailsState createState() => _ProductDetailsState(this.productByCategoryDataData);
}

class _ProductDetailsState extends State<ProductDetails> with SingleTickerProviderStateMixin {

  ProductSubCategoryDataData productByCategoryDataData;
  ProductStockEntity productStockEntity = new ProductStockEntity();

  _ProductDetailsState(this.productByCategoryDataData);

  List<Widget> Adsimages = [
  ];
  int AdsCurrentIndex = 0;
  String wishlist_id = "0";
  int selectedindex=0;

  bool iswishlist = false;

  String description = "",price_details="",returnpolicies="No Data Found",
      cartcount = "0",
      product_stockid = "0";
  bool ispointredeemeed = false;
  double tempwalletpoints = 0;
  int stockquantity=0;

late TabController   _tabController ;

List<String>images=[];

int count=0;

List<ProductSubCategoryDataData>pcdata=[];

 late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
   getProductCount();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text(
        productByCategoryDataData.productName.toString(),maxLines: 2 ,style: TextStyle(
          fontSize: ResponsiveInfo.isMobile(context) ? 15 : 17,

          color: Colors.white),),
        leading: GestureDetector(

          child: Icon(Icons.arrow_back, color: Colors.white,
            size: ResponsiveInfo.isMobile(context) ? 20 : 25,),

          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff0B7D97),
        actions: [

          Stack(
            children: [

              Align(
                alignment: FractionalOffset.center,
                child: GestureDetector(

                  child: Padding(padding: EdgeInsets.all(
                      ResponsiveInfo.isMobile(context) ? 10 : 15),

                    child: Icon(Icons.shopping_cart, color: Colors.white,
                      size: ResponsiveInfo.isMobile(context) ? 20 : 25,),

                  ),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );

                    if (result != null||result==null) {

                      getCartCount();


                    }
                  },
                ),
              ),
              (cartcount.compareTo("0") != 0) ? Align(
                  alignment: FractionalOffset.topCenter,

                  child: Padding(padding: EdgeInsets.fromLTRB(
                      ResponsiveInfo.isMobile(context) ? 10 : 15,
                      ResponsiveInfo.isMobile(context) ? 3 : 5, 0, 0),

                    child: CircleAvatar(
                      radius: ResponsiveInfo.isMobile(context) ? 8 : 10,
                      backgroundColor: Colors.red,
                      child: Text(cartcount, style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveInfo.isMobile(context)
                              ? 12
                              : 14),),
                    )


                    ,)

              ) : Container(),
            ],

          )


        ]

        ,),

      body:(count==1)? Column(

        children: [

          Expanded(child: (Adsimages.length > 0) ? Padding(
            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),

            child: Column(
              children: [

                Stack(
                  children: [

                    Align(
                        alignment: FractionalOffset.topRight,
                        child: GestureDetector(

                          child: (!iswishlist) ? Padding(padding: EdgeInsets
                              .all(5),
                            child: Icon(
                              Icons.favorite_border, color: Colors.black,
                              size: ResponsiveInfo.isMobile(context)
                                  ? 20
                                  : 25,),
                          ) : Padding(padding: EdgeInsets.all(5),
                            child: Icon(Icons.favorite, color: Colors.redAccent,
                              size: ResponsiveInfo.isMobile(context)
                                  ? 20
                                  : 25,),
                          ),
                          onTap: () {
                            if (!iswishlist) {
                              addProductToWishlist();
                            }
                            else {
                              deleteProductFromWishlist();
                            }
                          },
                        )


                    )
                  ],
                ),
                CarouselSlider(options: CarouselOptions(
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: Duration(microseconds: 800),
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlay: true,
                  //  height: 200,
                  enlargeCenterPage: true,
                  aspectRatio: 2.3,
                  onPageChanged: (index, reason) {
                    setState(() {
                      AdsCurrentIndex = index;
                    });
                  },
                ),
                  items: Adsimages,
                ),
                Padding(padding: EdgeInsets.all(5),

                  child: AnimatedSmoothIndicator(activeIndex: AdsCurrentIndex,
                    count: Adsimages.length,
                    effect:
                    WormEffect(
                        dotWidth: 12,
                        dotHeight: 12,
                        dotColor: Colors.grey,
                        // spacing: 2,
                        activeDotColor: Colors.black,
                        paintStyle: PaintingStyle.fill
                    ),
                  ),
                )

              ],
            ),
          )


              : Image.asset("assets/web-error.png"), flex: 1,),

          Expanded(child: Column(
            children: [

              Expanded(child: Column(

                children: [

                  TabBar(
                    labelColor: Color(0xff0B7D97), // Color of the selected tab
                    unselectedLabelColor: Colors.grey, // Color of unselected tabs
                    indicatorColor: Color(0xff0B7D97), // Underline color of the selected tab
                    indicatorWeight: 2.0, //
                    controller: _tabController,


                    tabs: [
                      Tab(text: "Price"),
                      Tab(text: "Description"),
                      Tab(text: "Return Policy"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(

                      controller: _tabController,
                      children: [
                        _buildTabContent(0),
                        _buildTabContent(1),
                        _buildTabContent(2),
                      ],
                    ),
                  ),

                ],


              ), flex: 2,),


              Expanded(child: Stack(

                children: [
                  (stockquantity>0) ?  Align(
                    alignment: FractionalOffset.center,
                    child:
                    (productStockEntity.data!.currentQty.toString().isNotEmpty &&
                        productStockEntity.data!.currentQty.toString().compareTo("0")!=0)?
                    Padding(
                      padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                          ? 15
                          : 20),
                      child: Container(
                        width: double.infinity,
                        height: ResponsiveInfo.isMobile(context) ? 50 : 70,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff0B7D97), // background
                            foregroundColor: Colors.white, // foreground
                          ),
                          onPressed: () async {
                            double current_walletpoints = await calculateWalletPoints();
                            double ppredemption = 0;


                            if (current_walletpoints != null) {

                              if (productStockEntity != null) {
                                if (productStockEntity.data!.ppRedemption !=
                                    null) {
                                  ppredemption = double.parse(
                                      productStockEntity.data!.ppRedemption
                                          .toString());

                                  if (current_walletpoints > ppredemption) {
                                    Widget okButton = TextButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        tempwalletpoints =
                                            current_walletpoints - ppredemption;
                                        // AppStorage.setString(AppStorage.current_wallet_point, tempwalletpoints.toString());
                                        ispointredeemeed = true;
                                        getProductExistsinCart();

                                        Navigator.pop(context);
                                      },
                                    );

                                    Widget noButton = TextButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        ispointredeemeed = false;
                                        getProductExistsinCart();

                                        Navigator.pop(context);
                                      },
                                    );

                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      title: Text("Savekart"),
                                      content: Text("Your wallet point is " +
                                          current_walletpoints.toString() +
                                          ".So you are eligible to redeem points.Do you want to redeem now ?"),
                                      actions: [
                                        okButton,
                                        noButton
                                      ],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  }
                                  else {
                                    getProductExistsinCart();
                                  }
                                }
                              }
                            }
                            else {
                              getProductExistsinCart();
                            }
                          },
                          child: Text('Add to cart', style: TextStyle(
                              fontSize: ResponsiveInfo.isMobile(context)
                                  ? 14
                                  : 17),),
                        ),
                      ),) : Text("No Stock Available",style: TextStyle(color: Color(0xff0B7D97),fontSize: ResponsiveInfo.isMobile(context)?14:17,),
                  ) ) : Container()

                ],
              )





                ,
                flex: 1,)


            ],
          ), flex: 2,)


        ],
      ):((count>1)? Column(

        children: [

          Expanded(child: (Adsimages.length > 0) ? Padding(
            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),

            child: Column(
              children: [

                Stack(
                  children: [

                    Align(
                        alignment: FractionalOffset.topRight,
                        child: GestureDetector(

                          child: (!iswishlist) ? Padding(padding: EdgeInsets
                              .all(5),
                            child: Icon(
                              Icons.favorite_border, color: Colors.black,
                              size: ResponsiveInfo.isMobile(context)
                                  ? 20
                                  : 25,),
                          ) : Padding(padding: EdgeInsets.all(5),
                            child: Icon(Icons.favorite, color: Colors.redAccent,
                              size: ResponsiveInfo.isMobile(context)
                                  ? 20
                                  : 25,),
                          ),
                          onTap: () {
                            if (!iswishlist) {
                              addProductToWishlist();
                            }
                            else {
                              deleteProductFromWishlist();
                            }
                          },
                        )


                    )
                  ],
                ),
                CarouselSlider(options: CarouselOptions(
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: Duration(microseconds: 800),
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlay: true,
                  //  height: 200,
                  enlargeCenterPage: true,
                  aspectRatio: 2.6,
                  onPageChanged: (index, reason) {
                    setState(() {
                      AdsCurrentIndex = index;
                    });
                  },
                ),
                  items: Adsimages,
                ),
                Padding(padding: EdgeInsets.all(5),

                  child: AnimatedSmoothIndicator(activeIndex: AdsCurrentIndex,
                    count: Adsimages.length,
                    effect:
                    WormEffect(
                        dotWidth: 12,
                        dotHeight: 12,
                        dotColor: Colors.grey,
                        // spacing: 2,
                        activeDotColor: Colors.black,
                        paintStyle: PaintingStyle.fill
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.all(5),

                child: SizedBox(
                  height: 75, // Fixed height for ListView
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 5 : 10),
                    itemCount: pcdata.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveInfo.isMobile(context) ? 4 : 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2.5, // Adjust to control width/height ratio
                    ),
                    itemBuilder: (context, index) {
                      bool isSelected = selectedindex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedindex = index;
                            productByCategoryDataData = pcdata[selectedindex];
                            setupProductImages();
                            getReturnPolicies(productByCategoryDataData.id.toString());

                            getProductStock();
                            getCartCount();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Color(0xff0B7D97) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected
                                ? null
                                : Border.all(
                              color: Color(0xff0B7D97),
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            pcdata[index].size.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? Colors.white : Color(0xff0B7D97),
                            ),
                          ),
                        ),
                      );
                    },
                  )

                ),
                )



              ],
            ),
          )


              : Image.asset("assets/web-error.png"), flex: 2,),

          Expanded(child: Column(
            children: [

              Expanded(child: Column(

                children: [

                  TabBar(
                    labelColor: Color(0xff0B7D97), // Color of the selected tab
                    unselectedLabelColor: Colors.grey, // Color of unselected tabs
                    indicatorColor: Color(0xff0B7D97), // Underline color of the selected tab
                    indicatorWeight: 2.0, //
                    controller: _tabController,


                    tabs: [
                      Tab(text: "Price"),
                      Tab(text: "Description"),
                      Tab(text: "Return Policy"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(

                      controller: _tabController,
                      children: [
                        _buildTabContent(0),
                        _buildTabContent(1),
                        _buildTabContent(2),
                      ],
                    ),
                  ),

                ],


              ), flex: 2,),


              Expanded(child: Column(

                children: [
                  Stack(

                    children: [
                      (productStockEntity.status==1) ?   Align(
                        alignment: FractionalOffset.center,
                        child:  (productStockEntity.data!.currentQty.toString().isNotEmpty &&
                            productStockEntity.data!.currentQty.toString().compareTo("0")!=0)? Padding(
                          padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)
                              ? 15
                              : 20),
                          child: Container(
                            width: double.infinity,
                            height: ResponsiveInfo.isMobile(context) ? 50 : 70,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff0B7D97), // background
                                foregroundColor: Colors.white, // foreground
                              ),
                              onPressed: () async {
                                double current_walletpoints = await calculateWalletPoints();
                                double ppredemption = 0;


                                if (current_walletpoints != null) {

                                  if (productStockEntity != null) {
                                    if (productStockEntity.data!.ppRedemption !=
                                        null) {
                                      ppredemption = double.parse(
                                          productStockEntity.data!.ppRedemption
                                              .toString());

                                      if (current_walletpoints > ppredemption) {
                                        Widget okButton = TextButton(
                                          child: Text("Yes"),
                                          onPressed: () {
                                            tempwalletpoints =
                                                current_walletpoints - ppredemption;
                                            // AppStorage.setString(AppStorage.current_wallet_point, tempwalletpoints.toString());
                                            ispointredeemeed = true;
                                            getProductExistsinCart();

                                            Navigator.pop(context);
                                          },
                                        );

                                        Widget noButton = TextButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            ispointredeemeed = false;
                                            getProductExistsinCart();

                                            Navigator.pop(context);
                                          },
                                        );

                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          title: Text("Savekart"),
                                          content: Text("Your wallet point is " +
                                              current_walletpoints.toString() +
                                              ".So you are eligible to redeem points.Do you want to redeem now ?"),
                                          actions: [
                                            okButton,
                                            noButton
                                          ],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      }
                                      else {
                                        getProductExistsinCart();
                                      }
                                    }
                                  }
                                }
                                else {
                                  getProductExistsinCart();
                                }
                              },
                              child: Text('Add to cart', style: TextStyle(
                                  fontSize: ResponsiveInfo.isMobile(context)
                                      ? 14
                                      : 17),),
                            ),
                          ),) :
                        Text("No Stock Available",style: TextStyle(color: Color(0xff0B7D97),fontSize: ResponsiveInfo.isMobile(context)?14:17,),
                        )
                        ,
                      ) : Container()
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              )








                ,
                flex: 1,)


            ],
          ), flex: 3,)


        ],
      ):
      Container(width: double.infinity,
      height: double.infinity,
        child: Stack(

          children: [

            Align(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(),
            )
          ],
        ),

      )),


    );
  }

  getProductCount()async{
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t = EcommerceApiHelper.getTimeStamp();

    var response = await apihelper.get(
        Apimethodes.getProductCountByName + "?id=" +
            productByCategoryDataData.id.toString()+"&name="+productByCategoryDataData.productName.toString() + "&q=" + t.toString());

    var js = jsonDecode(response);
    ProductCountEntity entity=ProductCountEntity.fromJson(js);

    if(entity.status==1)
      {

        if(entity.data!.length>0)
          {

            setState(() {
              count=entity.data!.length;
              if(count==1)
                {
                  setupProductImages();
                  getReturnPolicies(productByCategoryDataData.id.toString());
                  getProductStock();
                  getCartCount();
                }
              else if(count>1)
                {
                  for(int i=0;i<entity.data!.length;i++)
                    {
                      ProductCountData pb=entity.data![i];
                      ProductSubCategoryDataData pbc=new ProductSubCategoryDataData();
                      pbc.id=pb.id;
                      pbc.primeImage=pb.primeImage;
                      pbc.productName=pb.productName;
                      pbc.status=pb.status;
                      pbc.productSpec=pb.productSpec;
                      pbc.productDescription=pb.productDescription;
                      pbc.sideImage4=pb.sideImage4;
                      pbc.sideImage3=pb.sideImage3;
                      pbc.sideImage2=pb.sideImage2;
                      pbc.sideImage1=pb.sideImage1;
                      pbc.categoryId=pb.categoryId;
                      pbc.color=pb.color;
                      pbc.colorEnabled=pb.colorEnabled;
                      pbc.size=pb.size;
                      pbc.sizeEnabled=pb.sizeEnabled;
                      pbc.subCategoryId=pb.subCategoryId;
                      pbc.unitId=pb.unitId;
                      pbc.vendorId=pb.vendorId;
                      pbc.returnDays=pb.returnDays;
                      pbc.productCode=pb.productCode;
                      pcdata.add(pbc);
                    }

                  productByCategoryDataData=pcdata[selectedindex];
                  setupProductImages();
                  getReturnPolicies(productByCategoryDataData.id.toString());
                  getProductStock();
                  getCartCount();

                }


            });

          }

      }
    else{

      setState(() {

        if(entity.message.toString().contains("values less than one")) {
          count = 1;
          setupProductImages();
          getReturnPolicies(productByCategoryDataData.id.toString());
          getProductStock();
          getCartCount();
        }
      });


    }



    print(js);
  }

  _buildTabContent(int index)
  {
    if(index==0) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
              ResponsiveInfo.isMobile(context) ? 10 : 15),
          child: Text(
            price_details, style: TextStyle(fontSize: ResponsiveInfo
              .isMobile(context) ? 15 : 17, color: Colors.black),),

        ),
      )


        ;
    }
    else if(index==1)
      {
        return SingleChildScrollView(
          child:Padding(
            padding: EdgeInsets.all(
                ResponsiveInfo.isMobile(context) ? 10 : 15),
            child: Text(
              description, style: TextStyle(fontSize: ResponsiveInfo
                .isMobile(context) ? 15 : 17, color: Colors.black),),

          ) ,
        )


          ;
      }
    else{
      return SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.all(
              ResponsiveInfo.isMobile(context) ? 10 : 15),
          child: Text(
            returnpolicies, style: TextStyle(fontSize: ResponsiveInfo
              .isMobile(context) ? 15 : 17, color: Colors.black),),

        ),
      )


        ;
    }

  }

  getProductStock() async {

    setState(() {
      productStockEntity=new ProductStockEntity();
    });


    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t = EcommerceApiHelper.getTimeStamp();

    var response = await apihelper.get(
        Apimethodes.getProductStock + "?product_id=" +
            productByCategoryDataData.id.toString() + "&q=" + t.toString());

    var js = jsonDecode(response);

    productStockEntity = ProductStockEntity.fromJson(js);
    getProductExistsinWishlist();
    if (productStockEntity.data!=null&&productStockEntity.data!.currentQty.toString().compareTo("0") != 0) {
      product_stockid = productStockEntity.data!.id.toString();
      setState(() {
        price_details="";
        description="";
        stockquantity=int.parse(productStockEntity.data!.currentQty.toString());
        if(productStockEntity.status==1&&productStockEntity.data!=null&&productStockEntity.data!.id!.isNotEmpty)
        {
          if (productStockEntity.status.toString().compareTo("0") != 0) {


            if (productStockEntity.data!.mrp != null && productStockEntity.data!
                .mrp
                .toString()
                .isNotEmpty) {
              price_details = "\n" + price_details +
                  "Product Code : " + productByCategoryDataData.productCode.toString() + "\n\n";
            }

            if (productStockEntity.data!.mrp != null && productStockEntity.data!
                .mrp
                .toString()
                .isNotEmpty) {
              price_details = "\n" + price_details +
                  "MRP : " + productStockEntity.data!.mrp.toString() + "\n\n";
            }
            if (productStockEntity.data!.savecartPrice != null &&
                productStockEntity.data!
                    .savecartPrice
                    .toString()
                    .isNotEmpty) {
              price_details = price_details +
                  "Save Kart Price : " +
                  productStockEntity.data!.savecartPrice.toString() + "\n\n";
            }

            if (productStockEntity.data!.ppRedemption != null &&
                productStockEntity.data!
                    .ppRedemption
                    .toString()
                    .isNotEmpty) {
              price_details = price_details +
                  "PP Redeem  : " +
                  productStockEntity.data!.ppRedemption.toString() + "\n\n";
            }
            if (productStockEntity.data!.priceSales != null &&
                productStockEntity.data!
                    .priceSales
                    .toString()
                    .isNotEmpty) {
              price_details = price_details + "Your Price : " +
                  productStockEntity.data!.priceSales.toString() + " (GST included)\n\n";
            }
            // if(productStockEntity.data!.margin!=null && productStockEntity.data!.margin.toString().isNotEmpty)
            // {
            //   description = description +
            //       "SV : "+productStockEntity.data!.margin.toString()+"\n";
            //
            // }

            if (productStockEntity.data!.savecartPrice != null &&
                productStockEntity.data!
                    .savecartPrice
                    .toString()
                    .isNotEmpty) {
              if (productStockEntity.data!.mrp != null &&
                  productStockEntity.data!
                      .mrp
                      .toString()
                      .isNotEmpty) {
                double mrp = double.parse(
                    productStockEntity.data!.mrp.toString());
                double savecartprice = double.parse(
                    productStockEntity.data!.priceSales.toString());
                double savedprice = mrp - savecartprice;
                price_details = price_details +
                    "You saved : " + savedprice.toString() + "  \n";
              }
            }
            else {
              price_details = price_details +
                  "You saved : 0.0  \n";
            }


            price_details = price_details +"\nFree Delivery\n";
          }


          if (productByCategoryDataData.sizeEnabled.toString().compareTo("1") !=
              0 && productByCategoryDataData.size != null &&
              productByCategoryDataData.size
                  .toString()
                  .isNotEmpty) {
            description = "\n" + description +
                "Size : " + productByCategoryDataData.size.toString() + " \n";
          }

          if (productByCategoryDataData.colorEnabled.toString().compareTo(
              "1") != 0 && productByCategoryDataData.color != null &&
              productByCategoryDataData.color
                  .toString()
                  .isNotEmpty) {
            description = description +
                "Colour : " + productByCategoryDataData.color.toString() +
                " \n\n";
          }

          if (productByCategoryDataData.productDescription != null &&
              productByCategoryDataData.productDescription
                  .toString()
                  .isNotEmpty) {
            description = description +
                productByCategoryDataData.productDescription.toString();
          }

          if (productByCategoryDataData.productSpec != null &&
              productByCategoryDataData.productSpec
                  .toString()
                  .isNotEmpty) {
            description = description + "\n\n Specifications : \n\n" +
                productByCategoryDataData.productSpec.toString();
          }
        }
        else{
          price_details="\n\n\n No Data Found \n\n\n";
        }
      });
    }

    else {
      ResponsiveInfo.showAlertDialog(
          context, "", "Product is out of stock");
      setState(() {
        productStockEntity = ProductStockEntity();
        productStockEntity.status=1;
        productStockEntity.data!.currentQty="0";
      });

    }
  }

  getReturnPolicies(String product_id) async {

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getReturnPolicyData+"?q="+t.toString()+"&product_id="+product_id);




    var js= jsonDecode( response) ;
    ReturnPolicyEntity entity=ReturnPolicyEntity.fromJson(js);

    if(entity.status==1)
    {

setState(() {
  returnpolicies=entity.data!.policy.toString()+"\n Return Period : "+productByCategoryDataData.returnDays.toString()+" Days";
});


    }
    else{

      setState(() {

        if(productByCategoryDataData.returnDays!=null&&productByCategoryDataData.returnDays.toString().isNotEmpty)
          {
            returnpolicies = "\n\n\n \t\t\t Return Period : "+productByCategoryDataData.returnDays.toString()+" Days";
          }
        else {
          returnpolicies = "\n\n\n \t\t\t Non Returnable Product";
        }
      });

      // ResponsiveInfo.showAlertDialog(context, "", "Error while fetching Return Policy of this product");
    }




  }


  setupProductImages() async {
    if (productByCategoryDataData.primeImage != null &&
        productByCategoryDataData.primeImage
            .toString()
            .isNotEmpty) {
      setState(() {
        Adsimages.clear();
        images.add(EcommerceApiHelper.productimageurl +
            productByCategoryDataData.primeImage.toString());
        Adsimages.add( GestureDetector(

          child:Image.network(EcommerceApiHelper.productimageurl +
              productByCategoryDataData.primeImage.toString(),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // Image loaded successfully
              return Center(child: CircularProgressIndicator()); // Show loader while loading
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
            },

          ) ,

          onTap: (){

            Navigator.push(context,
                MaterialPageRoute(builder:
                    (context) =>
                    ZoomableImageScreen(EcommerceApiHelper.productimageurl +
                        productByCategoryDataData.primeImage.toString(),images)
                )
            );
          },
        )



            );
      });
    }

    if (productByCategoryDataData.sideImage1 != null &&
        productByCategoryDataData.sideImage1
            .toString()
            .isNotEmpty) {


      setState(() {
        images.add(EcommerceApiHelper.productimageurl +
            productByCategoryDataData.sideImage1.toString());
        Adsimages.add(GestureDetector(



          child:  Image.network(EcommerceApiHelper.productimageurl +
            productByCategoryDataData.sideImage1.toString(), loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child; // Image loaded successfully
            return Center(child: CircularProgressIndicator()); // Show loader while loading
          },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
            },),

        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder:
                  (context) =>
                  ZoomableImageScreen(EcommerceApiHelper.productimageurl +
                      productByCategoryDataData.sideImage1.toString(),images)
              )
          );
        },

        ));
      });
    }

    if (productByCategoryDataData.sideImage2 != null &&
        productByCategoryDataData.sideImage2
            .toString()
            .isNotEmpty) {
      setState(() {
        images.add(EcommerceApiHelper.productimageurl +
            productByCategoryDataData.sideImage2.toString());
        Adsimages.add(
            GestureDetector(

          child:  Image.network(EcommerceApiHelper.productimageurl +
            productByCategoryDataData.sideImage2.toString(), loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child; // Image loaded successfully
            return Center(child: CircularProgressIndicator()); // Show loader while loading
          },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
            },),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder:
                      (context) =>
                      ZoomableImageScreen(EcommerceApiHelper.productimageurl +
                          productByCategoryDataData.sideImage2.toString(),images)
                  )
              );
            },

            ));
      });
    }

    if (productByCategoryDataData.sideImage3 != null &&
        productByCategoryDataData.sideImage3
            .toString()
            .isNotEmpty) {
      setState(() {
        images.add(EcommerceApiHelper.productimageurl +
            productByCategoryDataData.sideImage3.toString());
        Adsimages.add( GestureDetector(



          child:  Image.network(EcommerceApiHelper.productimageurl +
            productByCategoryDataData.sideImage3.toString(), loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child; // Image loaded successfully
            return Center(child: CircularProgressIndicator()); // Show loader while loading
          },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
            },),

        onTap: (){

          Navigator.push(context,
              MaterialPageRoute(builder:
                  (context) =>
                  ZoomableImageScreen(EcommerceApiHelper.productimageurl +
                      productByCategoryDataData.sideImage3.toString(),images)
              )
          );
        },

        ));
      });
    }

    if (productByCategoryDataData.sideImage4 != null &&
        productByCategoryDataData.sideImage4
            .toString()
            .isNotEmpty) {
      setState(() {
        images.add(EcommerceApiHelper.productimageurl +
            productByCategoryDataData.sideImage4.toString());
        Adsimages.add( GestureDetector(

            child: Image.network(EcommerceApiHelper.productimageurl +
            productByCategoryDataData.sideImage4.toString(), loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // Image loaded successfully
              return Center(child: CircularProgressIndicator()); // Show loader while loading
            },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
              },),
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder:
                  (context) =>
                  ZoomableImageScreen(EcommerceApiHelper.productimageurl +
                      productByCategoryDataData.sideImage4.toString(),images)
              )
          );

        },

        ));
      });
    }
  }

  Future<double> calculateWalletPoints() async {
    ResponsiveInfo.showLoaderDialog(context);
    double walletpoints = 0;
    EcommerceApiHelper apihelper = new EcommerceApiHelper();
    var t=EcommerceApiHelper.getTimeStamp();
    var response1= await  apihelper.get(Apimethodes.getWalletPoints+"?q="+t.toString());

    Navigator.pop(context);
    var js1= jsonDecode( response1) ;
    walletpoints=double.parse(js1['data'].toString());

    return walletpoints;
  }


  addToCart()async {

    ResponsiveInfo.ShowProgressDialog(context);


    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    Map<String,String> mp=new HashMap();
    mp['product_id']=productByCategoryDataData.id.toString();
    mp['quantity']="1";
    mp['stockid']=product_stockid;
    if(ispointredeemeed)
      {
        mp['points_redeemed']="1";
      }
    else{

      mp['points_redeemed']="0";
    }


    var response= await  apihelper.post(Apimethodes.addProductToCart+"?q="+t.toString(),formDataPayload: mp);

    var js= jsonDecode( jsonEncode(response) ) ;

    Navigator.pop(context);

    // if(js['status']==1)
    //   {

    getCartCount();

        ResponsiveInfo.showAlertDialog(context, "SaveKart", "Product added to cart successfully");




  }

  getProductExistsinCart() async{

    ResponsiveInfo.ShowProgressDialog(context);

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.checkProductExistsCart+"?q="+t.toString()+"&product_id="+productByCategoryDataData.id.toString());

    var js= jsonDecode( response) ;

    Navigator.pop(context);

    CartDataExistEntity exist=CartDataExistEntity.fromJson(js);
     if(exist.data!.length>0)
       {

         ResponsiveInfo.showAlertDialog(context, "", "Already added to cart");
       }
     else{

       addToCart();
     }



  }

  addProductToWishlist()async {
    ResponsiveInfo.ShowProgressDialog(context);

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();
    Map<String,String>mp=new HashMap();
    mp['product_id']=productStockEntity.data!.productId.toString();
    mp['stock_id']=productStockEntity.data!.id.toString();

    var response= await  apihelper.post(Apimethodes.addProductToWishlist+"?q="+t.toString(),formDataPayload: mp);

    String fullString=response.toString();
    if (fullString.startsWith("\"") && fullString.endsWith("\"")) {
      fullString = fullString.substring(1, fullString.length - 1)
          .replaceAll("\\\"", "\"");
    }
    var js= jsonDecode( fullString) ;
    Navigator.pop(context);

    if(js['status']==1)
      {

        setState(() {
          iswishlist=true;
        });
      }
    else{
      ResponsiveInfo.showAlertDialog(context, "", "Something went wrong");
    }




  }

  deleteProductFromWishlist()async {
    ResponsiveInfo.ShowProgressDialog(context);

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();
    Map<String,String>mp=new HashMap();
    mp['id']=wishlist_id;


    var response= await  apihelper.post(Apimethodes.deleteFromWishlist+"?q="+t.toString(),formDataPayload: mp);

    String fullString=response.toString();
    if (fullString.startsWith("\"") && fullString.endsWith("\"")) {
      fullString = fullString.substring(1, fullString.length - 1)
          .replaceAll("\\\"", "\"");
    }
    var js= jsonDecode( fullString) ;
    Navigator.pop(context);

    if(js['status']==1)
    {

      setState(() {
        iswishlist=false;
      });
    }
    else{
      ResponsiveInfo.showAlertDialog(context, "", "Something went wrong");
    }




  }

  getProductExistsinWishlist() async{

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.checkProductExistsWishlist+"?q="+t.toString()+"&product_id="+productStockEntity.data!.productId.toString()+"&stock_id="+productStockEntity.data!.id.toString());

    var js= jsonDecode( response) ;
    print(js);
    WishlistcheckEntity entity=WishlistcheckEntity.fromJson(js);


  if(entity.status==1)
    {
      if(entity.data!.length>0)
        {
          setState(() {

            wishlist_id=entity.data![0]!.id.toString();

            iswishlist=true;
          });
        }

    }





  }


  getCartCount()async {
    // ResponsiveInfo.ShowProgressDialog(context);
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getCartDataCount+"?q="+t.toString());

    var js= jsonDecode( response) ;

    if(js['status']==1)
    {

      String c=js['data'].toString();

      setState(() {
        cartcount=c;

      });

    }

  }




}
