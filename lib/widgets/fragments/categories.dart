import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/app_version_entity.dart';
import '../../domain/category_entity.dart';
import '../../domain/product_sub_category_entity.dart';
import '../../domain/products_entity.dart';
import '../../web/apimethodes.dart';
import '../../web/ecommerce_api_helper.dart';
import '../product_details.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen>
    with SingleTickerProviderStateMixin {
  static const Color primaryTeal = Color(0xFF0B7D97);
  static const Color surfaceBg = Color(0xFFF6F8FA);

  TabController? _tabController;
  final List<CategoryData> categories = [];
  final List<ProductsData> products = [];
  bool isLoading = true;
  bool isCategoriesLoading = true;
  int _lastFetchedTabIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    getAppUpdates();
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    final controller = _tabController;
    if (controller == null || controller.indexIsChanging) return;
    if (controller.index != _lastFetchedTabIndex &&
        controller.index < categories.length) {
      _lastFetchedTabIndex = controller.index;
      fetchProducts(categories[controller.index].id.toString());
    }
  }

  Future<void> getAppUpdates() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = double.tryParse(packageInfo.version) ?? 0.0;

      final apiHelper = EcommerceApiHelper();
      final t = EcommerceApiHelper.getTimeStamp();
      final response1 =
      await apiHelper.get("${Apimethodes.getCartUpdate}?q=$t");
      final appVersion = AppVersionEntity.fromJson(jsonDecode(response1));

      if (!mounted || appVersion.status != 1 || appVersion.data == null) {
        return;
      }

      final versionFromServer = appVersion.data!.version.toString();
      final appVersionFromServer = double.tryParse(versionFromServer) ?? 0.0;

      if (appVersionFromServer > currentVersion && mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "Update Available",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text("A new version ($versionFromServer) is available."),
            actions: [
              TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse(
                    "https://play.google.com/store/apps/details?id=com.integra.savekart",
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    throw "Could not launch $url";
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(
                    color: primaryTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (_) {
      // Keep UI running if version check fails.
    }
  }

  Future<void> fetchCategories() async {
    setState(() => isCategoriesLoading = true);
    try {
      final apiHelper = EcommerceApiHelper();
      final response = await apiHelper.get(Apimethodes.getCategories);
      final js = jsonDecode(response);
      final categoryEntity = CategoryEntity.fromJson(js);

      if (!mounted) return;

      final activeCategories = <CategoryData>[];
      if (categoryEntity.status == 1 && categoryEntity.data != null) {
        for (final item in categoryEntity.data!) {
          if (item.status.toString() == "0") {
            activeCategories.add(item);
          }
        }
      }

      _tabController?.removeListener(_handleTabChange);
      _tabController?.dispose();
      _tabController = null;

      setState(() {
        categories
          ..clear()
          ..addAll(activeCategories);
        if (categories.isNotEmpty) {
          _tabController = TabController(
            length: categories.length,
            vsync: this,
          )..addListener(_handleTabChange);
        }
        isCategoriesLoading = false;
      });

      if (categories.isNotEmpty) {
        _lastFetchedTabIndex = 0;
        await fetchProducts(categories.first.id.toString());
      } else if (mounted) {
        setState(() => isLoading = false);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        isCategoriesLoading = false;
        isLoading = false;
      });
    }
  }

  Future<void> fetchProducts(String categoryId) async {
    if (!mounted) return;
    setState(() => isLoading = true);
    try {
      final apiHelper = EcommerceApiHelper();
      final t = EcommerceApiHelper.getTimeStamp();
      final response = await apiHelper
          .get("${Apimethodes.getProductsByCategory}?id=$categoryId&q=$t");
      final js = jsonDecode(response);
      final productEntity = ProductsEntity.fromJson(js);

      if (!mounted) return;

      final activeProducts = <ProductsData>[];
      if (productEntity.status == 1 && productEntity.data != null) {
        for (final item in productEntity.data!) {
          if (item.status.toString() == "0") {
            activeProducts.add(item);
          }
        }
      }

      setState(() {
        products
          ..clear()
          ..addAll(activeProducts);
        isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
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
        title: Text(
          "Categories",
          style: TextStyle(
            color: const Color(0xFF1A1D1F),
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 16 : 19,
          ),
        ),
      ),
      body: isCategoriesLoading
          ? const Center(child: CircularProgressIndicator(color: primaryTeal))
          : categories.isEmpty || _tabController == null
          ? const Center(
        child: Text(
          "No categories available",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      )
          : Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: primaryTeal,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: primaryTeal,
              unselectedLabelColor: Colors.grey.shade600,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              tabs: categories
                  .map(
                    (category) => Tab(
                  text: category.categoryName.toString(),
                ),
              )
                  .toList(),
              onTap: (index) {
                if (index != _lastFetchedTabIndex) {
                  _lastFetchedTabIndex = index;
                  fetchProducts(categories[index].id.toString());
                }
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: primaryTeal,
              ),
            )
                : products.isEmpty
                ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 44,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "No products found",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                MediaQuery.of(context).size.width < 600
                    ? 2
                    : 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.78,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  ProductCard(products[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductsData product;

  const ProductCard(this.product, {super.key});

  ProductSubCategoryDataData _toSubCategoryProduct(ProductsData pb) {
    final pbc = ProductSubCategoryDataData();
    pbc.id = pb.id;
    pbc.primeImage = pb.primeImage;
    pbc.productName = pb.productName;
    pbc.status = pb.status;
    pbc.productSpec = pb.productSpec;
    pbc.productDescription = pb.productDescription;
    pbc.sideImage4 = pb.sideImage4;
    pbc.sideImage3 = pb.sideImage3;
    pbc.sideImage2 = pb.sideImage2;
    pbc.sideImage1 = pb.sideImage1;
    pbc.categoryId = pb.categoryId;
    pbc.color = pb.color;
    pbc.colorEnabled = pb.colorEnabled;
    pbc.size = pb.size;
    pbc.sizeEnabled = pb.sizeEnabled;
    pbc.subCategoryId = pb.subCategoryId;
    pbc.unitId = pb.unitId;
    pbc.vendorId = pb.vendorId;
    return pbc;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetails(_toSubCategoryProduct(product)),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F8FA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    EcommerceApiHelper.productimageurl +
                        product.primeImage.toString(),
                    fit: BoxFit.contain,
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF0B7D97),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 44,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.productName.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1D1F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}