import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/domain/cart_data_exist_entity.dart';
import 'package:savekart/domain/product_count_entity.dart';
import 'package:savekart/domain/product_stock_entity.dart';
import 'package:savekart/domain/product_sub_category_entity.dart';
import 'package:savekart/domain/return_policy_entity.dart';
import 'package:savekart/domain/soldcount_entity.dart';
import 'package:savekart/domain/wishlistcheck_entity.dart';
import 'package:savekart/web/apimethodes.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';
import 'package:savekart/widgets/cartscreen.dart';
import 'package:savekart/widgets/zoomimage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatefulWidget {
  final ProductSubCategoryDataData productByCategoryDataData;

  const ProductDetails(this.productByCategoryDataData, {super.key});

  @override
  _ProductDetailsState createState() =>
      _ProductDetailsState(productByCategoryDataData);
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  static const Color primaryTeal = Color(0xFF0B7D97);
  static const Color surfaceBg = Color(0xFFF6F8FA);

  ProductSubCategoryDataData productByCategoryDataData;
  ProductStockEntity productStockEntity = ProductStockEntity();

  _ProductDetailsState(this.productByCategoryDataData);

  final List<Widget> Adsimages = [];
  int AdsCurrentIndex = 0;
  String wishlist_id = "0";
  int selectedindex = 0;

  bool iswishlist = false;
  String description = "",
      price_details = "",
      returnpolicies = "No Data Found",
      cartcount = "0",
      product_stockid = "0";
  bool ispointredeemeed = false;
  double tempwalletpoints = 0;
  int stockquantity = 0;

  late TabController _tabController;
  final List<String> images = [];
  int count = 0;
  final List<ProductSubCategoryDataData> pcdata = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getProductCount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveInfo.isMobile(context);
    final hasItemsInCart = cartcount != "0" && cartcount.isNotEmpty;

    return Scaffold(
      backgroundColor: surfaceBg,
      appBar: AppBar(
        backgroundColor: primaryTeal,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: isMobile ? 20 : 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          productByCategoryDataData.productName.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isMobile ? 15 : 17,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
              if (mounted) {
                getCartCount();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: 10,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: isMobile ? 22 : 26,
                  ),
                  if (hasItemsInCart)
                    Positioned(
                      top: -6,
                      right: -8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          cartcount,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: count == 0
          ? const Center(child: CircularProgressIndicator(color: primaryTeal))
          : Column(
        children: [
          Expanded(
            flex: count > 1 ? 5 : 4,
            child: _buildMediaAndVariantsCard(isMobile),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 5,
            child: _buildDetailsAndActionCard(isMobile),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaAndVariantsCard(bool isMobile) {
    return Container(
      margin: EdgeInsets.fromLTRB(isMobile ? 12 : 16, 12, isMobile ? 12 : 16, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Adsimages.isEmpty
          ? Center(
        child: Image.asset(
          "assets/web-error.png",
          fit: BoxFit.contain,
        ),
      )
          : Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                color: iswishlist ? const Color(0xFFFFF1F2) : surfaceBg,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    if (!iswishlist) {
                      addProductToWishlist();
                    } else {
                      deleteProductFromWishlist();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      iswishlist
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: iswishlist
                          ? Colors.redAccent
                          : Colors.grey.shade700,
                      size: isMobile ? 20 : 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration:
                const Duration(milliseconds: 600),
                autoPlayInterval: const Duration(seconds: 3),
                autoPlay: Adsimages.length > 1,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
                onPageChanged: (index, reason) {
                  if (mounted) {
                    setState(() => AdsCurrentIndex = index);
                  }
                },
              ),
              items: Adsimages,
            ),
          ),
          const SizedBox(height: 6),
          AnimatedSmoothIndicator(
            activeIndex: AdsCurrentIndex,
            count: Adsimages.length,
            effect: const WormEffect(
              dotWidth: 9,
              dotHeight: 9,
              spacing: 6,
              dotColor: Colors.black26,
              activeDotColor: primaryTeal,
            ),
          ),
          if (count > 1 && pcdata.isNotEmpty) ...[
            const SizedBox(height: 10),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: pcdata.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = selectedindex == index;
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      setState(() {
                        selectedindex = index;
                        productByCategoryDataData = pcdata[selectedindex];
                        setupProductImages();
                        getReturnPolicies(
                          productByCategoryDataData.id.toString(),
                        );
                        getProductStock();
                        getCartCount();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? primaryTeal : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primaryTeal, width: 1),
                      ),
                      child: Text(
                        pcdata[index].size.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : primaryTeal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsAndActionCard(bool isMobile) {
    final qtyStr = productStockEntity.data?.currentQty?.toString() ?? "";
    final hasStock = stockquantity > 0 &&
        productStockEntity.status == 1 &&
        qtyStr.isNotEmpty &&
        qtyStr != "0";

    return Container(
      margin: EdgeInsets.fromLTRB(isMobile ? 12 : 16, 0, isMobile ? 12 : 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: primaryTeal,
            unselectedLabelColor: Colors.grey.shade600,
            indicatorColor: primaryTeal,
            indicatorWeight: 2.5,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.5,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.5,
            ),
            tabs: const [
              Tab(text: "Price"),
              Tab(text: "Description"),
              Tab(text: "Return Policy"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent(0, isMobile),
                _buildTabContent(1, isMobile),
                _buildTabContent(2, isMobile),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            child: hasStock
                ? SizedBox(
              width: double.infinity,
              height: isMobile ? 46 : 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryTeal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _onAddToCartPressed,
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: isMobile ? 14.5 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
                : Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1F2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "No Stock Available",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w700,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onAddToCartPressed() async {
    final currentWalletPoints = await calculateWalletPoints();
    if (!mounted) return;

    final redemptionStr = productStockEntity.data?.ppRedemption?.toString();
    final ppRedemption =
    (redemptionStr != null && redemptionStr.isNotEmpty)
        ? (double.tryParse(redemptionStr) ?? 0.0)
        : 0.0;

    if (ppRedemption > 0 && currentWalletPoints >= ppRedemption) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Savekart",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Your wallet point is $currentWalletPoints. So you are eligible to redeem points. Do you want to redeem now?",
          ),
          actions: [
            TextButton(
              child: const Text("No", style: TextStyle(color: Colors.grey)),
              onPressed: () {
                ispointredeemeed = false;
                Navigator.pop(dialogContext);
                getProductExistsinCart();
              },
            ),
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(color: primaryTeal, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                tempwalletpoints = currentWalletPoints - ppRedemption;
                ispointredeemeed = true;
                Navigator.pop(dialogContext);
                getProductExistsinCart();
              },
            ),
          ],
        ),
      );
    } else {
      getProductExistsinCart();
    }
  }

  Future<void> getProductCount() async {
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();

    final response = await apiHelper.get(
      "${Apimethodes.getProductCountByName}?id=${productByCategoryDataData.id}&name=${productByCategoryDataData.productName}&q=$t",
    );

    final js = jsonDecode(response);
    final entity = ProductCountEntity.fromJson(js);
    if (!mounted) return;

    if (entity.status == 1 && entity.data != null && entity.data!.isNotEmpty) {
      setState(() {
        count = entity.data!.length;
        if (count == 1) {
          setupProductImages();
          getReturnPolicies(productByCategoryDataData.id.toString());
          getProductStock();
          getCartCount();
        } else if (count > 1) {
          pcdata.clear();
          for (final pb in entity.data!) {
            final pbc = ProductSubCategoryDataData()
              ..id = pb.id
              ..primeImage = pb.primeImage
              ..productName = pb.productName
              ..status = pb.status
              ..productSpec = pb.productSpec
              ..productDescription = pb.productDescription
              ..sideImage4 = pb.sideImage4
              ..sideImage3 = pb.sideImage3
              ..sideImage2 = pb.sideImage2
              ..sideImage1 = pb.sideImage1
              ..categoryId = pb.categoryId
              ..color = pb.color
              ..colorEnabled = pb.colorEnabled
              ..size = pb.size
              ..sizeEnabled = pb.sizeEnabled
              ..subCategoryId = pb.subCategoryId
              ..unitId = pb.unitId
              ..vendorId = pb.vendorId
              ..returnDays = pb.returnDays
              ..productCode = pb.productCode;
            pcdata.add(pbc);
          }

          productByCategoryDataData = pcdata[selectedindex];
          setupProductImages();
          getReturnPolicies(productByCategoryDataData.id.toString());
          getProductStock();
          getCartCount();
        }
      });
    } else {
      setState(() {
        if (entity.message.toString().contains("values less than one")) {
          count = 1;
          setupProductImages();
          getReturnPolicies(productByCategoryDataData.id.toString());
          getProductStock();
          getCartCount();
        }
      });
    }
  }

  Widget _buildTabContent(int index, bool isMobile) {
    final content = index == 0
        ? price_details
        : index == 1
        ? description
        : returnpolicies;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 14 : 18),
      child: Text(
        content.trim().isEmpty ? "No details available." : content.trim(),
        style: TextStyle(
          fontSize: isMobile ? 14 : 15.5,
          height: 1.5,
          color: const Color(0xFF1A1D1F),
        ),
      ),
    );
  }

  Future<void> getProductStock() async {
    if (mounted) {
      setState(() {
        productStockEntity = ProductStockEntity();
        stockquantity = 0;
      });
    }

    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();

    final response = await apiHelper.get(
      "${Apimethodes.getProductStock}?product_id=${productByCategoryDataData.id}&q=$t",
    );

    final js = jsonDecode(response);
    productStockEntity = ProductStockEntity.fromJson(js);
    if (!mounted) return;

    getProductExistsinWishlist();

    final stockData = productStockEntity.data;
    final currentQtyStr = stockData?.currentQty?.toString() ?? "";

    if (stockData != null && currentQtyStr.isNotEmpty && currentQtyStr != "0") {
      product_stockid = stockData.id.toString();
      setState(() {
        price_details = "";
        description = "";
        stockquantity = int.tryParse(currentQtyStr) ?? 0;

        if (productStockEntity.status == 1 &&
            stockData.id != null &&
            stockData.id!.isNotEmpty) {
          if (productStockEntity.status.toString() != "0") {
            if (productByCategoryDataData.productCode != null &&
                productByCategoryDataData.productCode.toString().isNotEmpty) {
              price_details =
              "${price_details}Product Code : ${productByCategoryDataData.productCode}\n\n";
            }
            if (stockData.mrp != null && stockData.mrp.toString().isNotEmpty) {
              price_details = "${price_details}MRP : ${stockData.mrp}\n\n";
            }
            if (stockData.savecartPrice != null &&
                stockData.savecartPrice.toString().isNotEmpty) {
              price_details =
              "${price_details}Save Kart Price : ${stockData.savecartPrice}\n\n";
            }
            if (stockData.ppRedemption != null &&
                stockData.ppRedemption.toString().isNotEmpty) {
              price_details =
              "${price_details}PP Redeem : ${stockData.ppRedemption}\n\n";
            }
            if (stockData.priceSales != null &&
                stockData.priceSales.toString().isNotEmpty) {
              price_details =
              "${price_details}Your Price : ${stockData.priceSales} (GST included)\n\n";
            }
            if (stockData.savecartPrice != null &&
                stockData.savecartPrice.toString().isNotEmpty &&
                stockData.mrp != null &&
                stockData.mrp.toString().isNotEmpty &&
                stockData.priceSales != null &&
                stockData.priceSales.toString().isNotEmpty) {
              final mrp = double.tryParse(stockData.mrp.toString()) ?? 0;
              final sales = double.tryParse(stockData.priceSales.toString()) ?? 0;
              final savedPrice = mrp - sales;
              price_details = "${price_details}You saved : $savedPrice\n\n";
            } else {
              price_details = "${price_details}You saved : 0.0\n\n";
            }
            price_details = "${price_details}Free Delivery";
          }

          if (productByCategoryDataData.sizeEnabled.toString() != "1" &&
              productByCategoryDataData.size != null &&
              productByCategoryDataData.size.toString().isNotEmpty) {
            description =
            "${description}Size : ${productByCategoryDataData.size}\n\n";
          }
          if (productByCategoryDataData.colorEnabled.toString() != "1" &&
              productByCategoryDataData.color != null &&
              productByCategoryDataData.color.toString().isNotEmpty) {
            description =
            "${description}Colour : ${productByCategoryDataData.color}\n\n";
          }
          if (productByCategoryDataData.productDescription != null &&
              productByCategoryDataData.productDescription.toString().isNotEmpty) {
            description =
            "$description${productByCategoryDataData.productDescription}";
          }
          if (productByCategoryDataData.productSpec != null &&
              productByCategoryDataData.productSpec.toString().isNotEmpty) {
            description =
            "$description\n\nSpecifications :\n\n${productByCategoryDataData.productSpec}";
          }
        } else {
          price_details = "No Data Found";
        }
      });
    } else {
      ResponsiveInfo.showAlertDialog(context, "", "Product is out of stock");
      if (!mounted) return;
      setState(() {
        stockquantity = 0;
        price_details = "No Data Found";
      });
    }
  }

  Future<void> getReturnPolicies(String product_id) async {
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();

    final response = await apiHelper.get(
      "${Apimethodes.getReturnPolicyData}?q=$t&product_id=$product_id",
    );

    final js = jsonDecode(response);
    final entity = ReturnPolicyEntity.fromJson(js);
    if (!mounted) return;

    if (entity.status == 1 && entity.data != null) {
      setState(() {
        returnpolicies =
        "${entity.data!.policy}\n\nReturn Period : ${productByCategoryDataData.returnDays} Days";
      });
    } else {
      setState(() {
        if (productByCategoryDataData.returnDays != null &&
            productByCategoryDataData.returnDays.toString().isNotEmpty) {
          returnpolicies =
          "Return Period : ${productByCategoryDataData.returnDays} Days";
        } else {
          returnpolicies = "Non Returnable Product";
        }
      });
    }
  }

  void setupProductImages() {
    final rawImages = <String?>[
      productByCategoryDataData.primeImage,
      productByCategoryDataData.sideImage1,
      productByCategoryDataData.sideImage2,
      productByCategoryDataData.sideImage3,
      productByCategoryDataData.sideImage4,
    ];

    images.clear();
    Adsimages.clear();
    AdsCurrentIndex = 0;

    for (final img in rawImages) {
      if (img != null && img.toString().isNotEmpty) {
        final fullUrl = EcommerceApiHelper.productimageurl + img.toString();
        images.add(fullUrl);
        Adsimages.add(
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZoomableImageScreen(fullUrl, images),
                ),
              );
            },
            child: Image.network(
              fullUrl,
              fit: BoxFit.contain,
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: primaryTeal,
                  ),
                );
              },
              errorBuilder: (_, __, ___) => const Icon(
                Icons.image_outlined,
                size: 50,
                color: Colors.black26,
              ),
            ),
          ),
        );
      }
    }
  }

  Future<double> calculateWalletPoints() async {
    ResponsiveInfo.showLoaderDialog(context);
    double walletpoints = 0;
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();
    final response1 =
    await apiHelper.get("${Apimethodes.getWalletPoints}?q=$t");
    if (mounted) {
      Navigator.pop(context);
    }
    final js1 = jsonDecode(response1);
    walletpoints = double.tryParse(js1['data'].toString()) ?? 0.0;
    return walletpoints;
  }

  Future<void> addToCart() async {
    ResponsiveInfo.ShowProgressDialog(context);
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();

    final Map<String, String> mp = HashMap();
    mp['product_id'] = productByCategoryDataData.id.toString();
    mp['quantity'] = "1";
    mp['stockid'] = product_stockid;
    mp['points_redeemed'] = ispointredeemeed ? "1" : "0";

    await apiHelper.post(
      "${Apimethodes.addProductToCart}?q=$t",
      formDataPayload: mp,
    );

    if (!mounted) return;
    Navigator.pop(context);
    getCartCount();
    ResponsiveInfo.showAlertDialog(
      context,
      "SaveKart",
      "Product added to cart successfully",
    );
  }

  Future<void> getProductExistsinCart() async {
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();

    if (productByCategoryDataData.id.toString() == "432") {
      ResponsiveInfo.ShowProgressDialog(context);
      final response =
      await apiHelper.get("${Apimethodes.checkAutopoolCount}?q=$t");
      final js = jsonDecode(response);
      if (!mounted) return;
      Navigator.pop(context);

      final soldcountEntity = SoldcountEntity.fromJson(js);
      if (soldcountEntity.status == 1) {
        if (soldcountEntity.availableCount == -1 ||
            (soldcountEntity.availableCount ?? 0) > 0) {
          ResponsiveInfo.ShowProgressDialog(context);
          final checkResponse = await apiHelper.get(
            "${Apimethodes.checkProductExistsCart}?q=$t&product_id=${productByCategoryDataData.id}",
          );
          final checkJs = jsonDecode(checkResponse);
          if (!mounted) return;
          Navigator.pop(context);

          final exist = CartDataExistEntity.fromJson(checkJs);
          if ((exist.data?.length ?? 0) > 0) {
            ResponsiveInfo.showAlertDialog(context, "", "Already added to cart");
          } else {
            addToCart();
          }
        } else {
          ResponsiveInfo.showAlertDialog(
            context,
            "",
            "Your SAVE APP PRO stock capacity exceeds. Please sale the stock to increase your purchasing power",
          );
        }
      }
    } else {
      ResponsiveInfo.ShowProgressDialog(context);
      final response = await apiHelper.get(
        "${Apimethodes.checkProductExistsCart}?q=$t&product_id=${productByCategoryDataData.id}",
      );
      final js = jsonDecode(response);
      if (!mounted) return;
      Navigator.pop(context);

      final exist = CartDataExistEntity.fromJson(js);
      if ((exist.data?.length ?? 0) > 0) {
        ResponsiveInfo.showAlertDialog(context, "", "Already added to cart");
      } else {
        addToCart();
      }
    }
  }

  Future<void> addProductToWishlist() async {
    ResponsiveInfo.ShowProgressDialog(context);
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();
    final Map<String, String> mp = HashMap();
    mp['product_id'] = productStockEntity.data!.productId.toString();
    mp['stock_id'] = productStockEntity.data!.id.toString();

    final response = await apiHelper.post(
      "${Apimethodes.addProductToWishlist}?q=$t",
      formDataPayload: mp,
    );

    String fullString = response.toString();
    if (fullString.startsWith("\"") && fullString.endsWith("\"")) {
      fullString = fullString
          .substring(1, fullString.length - 1)
          .replaceAll("\\\"", "\"");
    }
    final js = jsonDecode(fullString);
    if (!mounted) return;
    Navigator.pop(context);

    if (js['status'] == 1) {
      setState(() => iswishlist = true);
    } else {
      ResponsiveInfo.showAlertDialog(context, "", "Something went wrong");
    }
  }

  Future<void> deleteProductFromWishlist() async {
    ResponsiveInfo.ShowProgressDialog(context);
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();
    final Map<String, String> mp = HashMap();
    mp['id'] = wishlist_id;

    final response = await apiHelper.post(
      "${Apimethodes.deleteFromWishlist}?q=$t",
      formDataPayload: mp,
    );

    String fullString = response.toString();
    if (fullString.startsWith("\"") && fullString.endsWith("\"")) {
      fullString = fullString
          .substring(1, fullString.length - 1)
          .replaceAll("\\\"", "\"");
    }
    final js = jsonDecode(fullString);
    if (!mounted) return;
    Navigator.pop(context);

    if (js['status'] == 1) {
      setState(() => iswishlist = false);
    } else {
      ResponsiveInfo.showAlertDialog(context, "", "Something went wrong");
    }
  }

  Future<void> getProductExistsinWishlist() async {
    final stockData = productStockEntity.data;
    if (stockData == null) return;

    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();

    final response = await apiHelper.get(
      "${Apimethodes.checkProductExistsWishlist}?q=$t&product_id=${stockData.productId}&stock_id=${stockData.id}",
    );

    final js = jsonDecode(response);
    final entity = WishlistcheckEntity.fromJson(js);
    if (!mounted) return;

    if (entity.status == 1 && (entity.data?.length ?? 0) > 0) {
      setState(() {
        wishlist_id = entity.data![0]!.id.toString();
        iswishlist = true;
      });
    }
  }

  Future<void> getCartCount() async {
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();

    final response =
    await apiHelper.get("${Apimethodes.getCartDataCount}?q=$t");
    final js = jsonDecode(response);
    if (!mounted) return;

    if (js['status'] == 1) {
      setState(() {
        cartcount = js['data'].toString();
      });
    }
  }
}