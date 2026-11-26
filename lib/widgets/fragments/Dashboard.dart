import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:savekart/domain/brand_entity.dart';
import 'package:savekart/domain/cart_banners_entity.dart';
import 'package:savekart/domain/category_entity.dart';
import 'package:savekart/domain/product_sub_category_entity.dart';
import 'package:savekart/domain/sub_category_entity.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';
import 'package:savekart/widgets/product_details.dart';
import 'package:savekart/widgets/purchase_points.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../design/ResponsiveInfo.dart';
import '../../domain/app_version_entity.dart';
import '../../domain/profile_data_entity.dart';
import '../../domain/wallet_balance_entity.dart';
import '../../web/AppStorage.dart';
import '../../web/api_helper.dart';
import '../../web/apimethodes.dart';
import '../Slidbarscreen.dart';
import '../all_products_by_category.dart';
import '../cartscreen.dart';
import '../productsbycategory.dart';
import '../s_s_m_ticket.dart';
import '../searchproduct.dart';
import '../wallet_transaction.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static const Color primaryTeal = Color(0xFF0B7D97);
  static const Color surfaceBg = Color(0xFFF6F8FA);

  List<CategoryData> categorydata = [];
  List<BrandData> data = [];
  List<SubCategoryData> subcategorydata = [];
  List<ProductSubCategoryData> productbycategorydata = [];
  List<CartBannersData> bannersdata = [];

  double walletbalance = 0.0;
  String cartcount = "0";
  int walletpoints = 0;
  String name = "", regid = "", mobile = "";

  final StreamController<SwipeRefreshState> _controller =
  StreamController<SwipeRefreshState>();
  Stream<SwipeRefreshState> get myRefreshStateStream => _controller.stream;

  @override
  void initState() {
    super.initState();
    _loadAllDashboardData();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _loadAllDashboardData() {
    getBanners();
    getCategories();
    getBrands();
    getSubCategoriess();
    getProductWithSubcategory();
    getWalletBalanceAndPoints();
    getWalletPoints();
    getCartCount();
    getAppUpdates();
    getProfile();
  }

  Future<void> _refreshAfterNav(Future<dynamic> navFuture) async {
    await navFuture;
    if (!mounted) return;
    getCartCount();
    getWalletPoints();
    getWalletBalanceAndPoints();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    _loadAllDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveInfo.isMobile(context);

    return Scaffold(
      backgroundColor: surfaceBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.white,
        centerTitle: false,
        title: Image.asset(
          "assets/appbaricon.jpeg",
          width: MediaQuery.sizeOf(context).width * 0.42,
          height: 38,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            onPressed: () => _refreshAfterNav(
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SSMTicket(mobile)),
              ),
            ),
            icon: const Icon(Icons.sticky_note_2_outlined, color: primaryTeal),
          ),
          IconButton(
            onPressed: () => _refreshAfterNav(
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductSearchScreen()),
              ),
            ),
            icon: const Icon(Icons.search_rounded, color: primaryTeal),
          ),
          _buildCartButton(isMobile),
          const SizedBox(width: 6),
        ],
      ),
      body: RefreshIndicator(
        color: primaryTeal,
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBannerSection(isMobile),
              const SizedBox(height: 14),
              _buildMemberWalletCard(),
              const SizedBox(height: 16),
              _buildCategoriesSection(isMobile),
              const SizedBox(height: 16),
              _buildSubCategorySections(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  getProfile()async{

    Map<String,String> m=new HashMap();


    ApiHelper apihelper = new ApiHelper();

    var response= await  apihelper.post(Apimethodes.getUserDetails,formDataPayload: m);



    var js= jsonDecode(jsonDecode(response)) ;

    print(js);

    ProfileDataEntity entity=ProfileDataEntity.fromJson(js);

    if(entity.status==1)
    {

      setState(() {
        name=entity.data!.fullName.toString();
        regid=entity.data!.regCode.toString();
        mobile=entity.data!.mobile.toString();



      });

    }

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
          builder: (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text("App Version"),
              content: Text("New version: $versionfromserver is available"),
              actions: [
                if (appversionfromserver > currentversion)
                  TextButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(
                        "https://play.google.com/store/apps/details?id=com.integra.savekart",
                      );

                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        throw "Could not launch $url";
                      }
                    },
                    child: const Text("Update"),
                  ),
              ],
            ),
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
        if (brandEntity.data != null) {
          productbycategorydata
            ..addAll(brandEntity.data!)
            ..shuffle();
        }

      });
    }
  }

  Widget _buildCartButton(bool isMobile) {
    final hasItems = cartcount != "0" && cartcount.isNotEmpty;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => _refreshAfterNav(
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CartScreen()),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: 8),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: primaryTeal,
              size: isMobile ? 24 : 26,
            ),
            if (hasItems)
              Positioned(
                top: -6,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
    );
  }

  Widget _buildBannerSection(bool isMobile) {
    if (bannersdata.isEmpty) {
      return SizedBox(
        height: isMobile ? 150 : 200,
        child: const Center(child: CircularProgressIndicator(color: primaryTeal)),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Slidbar(bannersdata),
      ),
    );
  }

  Widget _buildMemberWalletCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name.isEmpty ? "Welcome" : name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
                ),
                if (regid.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: surfaceBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "ID: $regid",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatTile(
                    label: "Savekart Wallet",
                    value: walletbalance.toString(),
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: Colors.green.shade700,
                    bgColor: const Color(0xFFEAF7EE),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WalletTransaction()),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatTile(
                    label: "Purchase Points",
                    value: walletpoints.toString(),
                    icon: Icons.stars_rounded,
                    iconColor: Colors.orange.shade700,
                    bgColor: const Color(0xFFFFF4E5),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PurchasePoints()),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1D1F),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(bool isMobile) {
    if (categorydata.isEmpty) {
      return SizedBox(
        height: isMobile ? 140 : 180,
        child: const Center(child: CircularProgressIndicator(color: primaryTeal)),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Shop by Category",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1D1F),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            itemCount: categorydata.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
              childAspectRatio: isMobile ? 0.78 : 0.85,
            ),
            itemBuilder: (context, index) {
              final cat = categorydata[index];
              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _refreshAfterNav(
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllProductsByCategory(
                        categoryId: cat.id.toString(),
                        categoryname: cat.categoryName.toString(),
                      ),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: isMobile ? 54 : 68,
                      height: isMobile ? 54 : 68,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Image.network(
                        EcommerceApiHelper.categoryimageurl + cat.image.toString(),
                        fit: BoxFit.contain,
                        loadingBuilder: (_, child, progress) => progress == null
                            ? child
                            : const Center(
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat.categoryName.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 11 : 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2B2F33),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategorySections(bool isMobile) {
    if (productbycategorydata.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: List.generate(productbycategorydata.length, (index) {
        final section = productbycategorydata[index];
        final rawItems = section.data ?? [];
        final items = rawItems.length > 15 ? rawItems.sublist(0, 15) : rawItems;
        if (items.isEmpty) return const SizedBox.shrink();

        final subCatName = section.category?.subCategoryName.toString() ?? "";
        final subCatId = section.category?.subCategoryId.toString() ?? "";

        final rows = <List<ProductSubCategoryDataData>>[];
        if (items.length <= 5) {
          rows.add(items);
        } else {
          for (int i = 0; i < items.length; i += 5) {
            rows.add(items.sublist(i, (i + 5 < items.length) ? i + 5 : items.length));
          }
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        subCatName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1D1F),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _refreshAfterNav(
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductsByCategoryScreen(
                              categoryId: subCatId,
                              categoryname: subCatName,
                            ),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "View All",
                            style: TextStyle(
                              color: primaryTeal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.chevron_right, size: 18, color: primaryTeal),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              ...rows.map(
                    (rowItems) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    height: isMobile ? 196 : 220,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: rowItems.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, i) =>
                          _buildProductCard(rowItems[i], isMobile),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProductCard(ProductSubCategoryDataData item, bool isMobile) {
    final isOutOfStock = item.currentQty.toString() == "0";
    final cardWidth = isMobile ? 142.0 : 172.0;
    final imgSize = isMobile ? 96.0 : 116.0;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _refreshAfterNav(
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetails(item)),
        ),
      ),
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.network(
                        EcommerceApiHelper.productimageurl +
                            item.primeImage.toString(),
                        width: imgSize,
                        height: imgSize,
                        fit: BoxFit.contain,
                        loadingBuilder: (_, child, progress) => progress == null
                            ? child
                            : const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.image_outlined,
                          size: 44,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.productName.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 12.5 : 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1D1F),
                    ),
                  ),
                ],
              ),
            ),
            if (isOutOfStock)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Out of stock",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }


}