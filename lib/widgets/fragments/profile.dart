import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:savekart/domain/app_version_entity.dart';
import 'package:savekart/domain/network_data_entity.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';
import 'package:savekart/widgets/address_list.dart';
import 'package:savekart/widgets/edit_profile.dart';
import 'package:savekart/widgets/returnrequests.dart';
import 'package:savekart/widgets/wallet_transaction.dart';
import 'package:savekart/widgets/wishlist_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../design/ResponsiveInfo.dart';
import '../../domain/profile_data_entity.dart';
import '../../domain/sliderShareImage.dart';
import '../../web/AppStorage.dart';
import '../../web/api_helper.dart';
import '../../web/apimethodes.dart';
import '../login_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const Color primaryTeal = Color(0xFF0B7D97);
  static const Color surfaceBg = Color(0xFFF6F8FA);

  final List<String> arricons = [
    'assets/icons/editprofile.png',
    'assets/icons/house-location.png',
    'assets/icons/wallet.png',
    'assets/icons/product-return.png',
    'assets/icons/update.png',
    'assets/icons/privacypolicy.png',
    'assets/icons/refer.png',
    'assets/icons/logout.png',
    'assets/icons/user.png',
  ];

  final List<String> arrmenus = [
    'Edit Profile',
    'My Address',
    'Savekart Wallet',
    'Return Requests',
    'App update',
    'Privacy Policy',
    'Refer now',
    'Logout',
    'Delete Account',
  ];

  String name = "";

  @override
  void initState() {
    super.initState();
    getProfile();
    getAppUpdates();
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
              "App Version",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text("New version: $versionFromServer is available"),
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
      // Keep profile screen active if version check fails.
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
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF1A1D1F),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home_outlined, color: primaryTeal),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(isMobile ? 12 : 18),
        children: [
          _buildHeaderCard(isMobile),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              "Account Settings",
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1D1F),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildMenuCard(isMobile),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 14 : 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: isMobile ? 24 : 28,
                backgroundColor: primaryTeal.withOpacity(0.12),
                child: Icon(
                  Icons.person_rounded,
                  color: primaryTeal,
                  size: isMobile ? 26 : 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hey",
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      name.isEmpty ? "Member" : name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isMobile ? 17 : 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1D1F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionTile(
                  label: "Wishlist",
                  icon: Icons.favorite_outline_rounded,
                  accentColor: Colors.redAccent,
                  bgColor: const Color(0xFFFFF1F2),
                  isMobile: isMobile,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WishlistPage()),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickActionTile(
                  label: "Help Desk",
                  icon: Icons.support_agent_rounded,
                  accentColor: primaryTeal,
                  bgColor: const Color(0xFFEBF7FA),
                  isMobile: isMobile,
                  onTap: () async {
                    final Uri url = Uri.parse('https://wa.me/919946109501');
                    if (!await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionTile({
    required String label,
    required IconData icon,
    required Color accentColor,
    required Color bgColor,
    required bool isMobile,
    required VoidCallback onTap,
  }) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: isMobile ? 46 : 54,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: accentColor, size: isMobile ? 19 : 22),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isMobile ? 13.5 : 15,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListView.separated(
        itemCount: arrmenus.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => Divider(
          height: 1,
          indent: 56,
          endIndent: 12,
          color: Colors.grey.shade100,
        ),
        itemBuilder: (context, index) {
          final isDelete = index == 8;
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: isMobile ? 2 : 6,
            ),
            leading: Container(
              width: isMobile ? 34 : 38,
              height: isMobile ? 34 : 38,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isDelete ? const Color(0xFFFFF1F2) : surfaceBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                arricons[index],
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              arrmenus[index],
              style: TextStyle(
                fontSize: isMobile ? 14.5 : 16,
                fontWeight: FontWeight.w600,
                color: isDelete ? Colors.red.shade700 : const Color(0xFF1A1D1F),
              ),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: isDelete ? Colors.red.shade300 : Colors.grey.shade400,
            ),
            onTap: () => _handleMenuTap(index),
          );
        },
      ),
    );
  }

  Future<void> _handleMenuTap(int index) async {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProfilePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddressList()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => WalletTransaction()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ReturnRequestsScreen()),
      );
    } else if (index == 4) {
      final packageInfo = await PackageInfo.fromPlatform();
      final version = packageInfo.version;
      if (!mounted) return;

      ResponsiveInfo.showLoaderDialog(context);
      final apiHelper = EcommerceApiHelper();
      final t = EcommerceApiHelper.getTimeStamp();
      final response1 =
      await apiHelper.get("${Apimethodes.getCartUpdate}?q=$t");
      if (!mounted) return;
      Navigator.pop(context);

      final appVersion = AppVersionEntity.fromJson(jsonDecode(response1));
      if (appVersion.status == 1 && appVersion.data != null && mounted) {
        final currentVersion = double.parse(version);
        final versionFromServer = appVersion.data!.version.toString();
        final appVersionFromServer = double.parse(versionFromServer);

        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "App Version",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text("Current Version: $version"),
            actions: [
              if (appVersionFromServer > currentVersion)
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
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: primaryTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("Close"),
              ),
            ],
          ),
        );
      }
    } else if (index == 5) {
      final Uri url = Uri.parse(
        'https://mysaving.in/IntegraAccount/privacypolicy.html?q=${EcommerceApiHelper.getTimeStamp()}',
      );
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    } else if (index == 6) {
      ResponsiveInfo.showLoaderDialog(context);
      final Map<String, String> m = HashMap();
      final apiHelper = ApiHelper();
      final response =
      await apiHelper.post(Apimethodes.getUserDetails, formDataPayload: m);
      if (!mounted) return;
      Navigator.pop(context);

      final js = jsonDecode(jsonDecode(response));
      final entity = ProfileDataEntity.fromJson(js);
      final phoneNumber = entity.data!.mobile.toString();

      ResponsiveInfo.showLoaderDialog(context);
      final response1 = await apiHelper.get(
        "${Apimethodes.showMemberDetails}?mobile=$phoneNumber&timestamp=${ResponsiveInfo.getRandomNumber()}",
      );
      if (!mounted) return;
      Navigator.pop(context);

      final networkDataEntity =
      NetworkDataEntity.fromJson(jsonDecode(response1));
      if (networkDataEntity.status == 1 && mounted) {
        ResponsiveInfo.showLoaderDialog(context);
        final response2 = await apiHelper.get(
          "${Apimethodes.getSettingsSlider}?mobile=$phoneNumber&timestamp=${ResponsiveInfo.getRandomNumber()}",
        );
        if (!mounted) return;
        Navigator.pop(context);
        showShareDialog(context, response2);
      }
    } else if (index == 7) {
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
          content: const Text("Do you want to logout from Savekart ?"),
          actions: [
            TextButton(
              child: const Text("No", style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: primaryTeal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                AppStorage.SaveToken(AppStorage.token, "");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
            ),
          ],
        ),
      );
    } else if (index == 8) {
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
          content: const Text(
            "Do you want to delete your account from Savekart ?",
          ),
          actions: [
            TextButton(
              child: const Text("No", style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            TextButton(
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                _showDeleteAccountDialog(context);
              },
            ),
          ],
        ),
      );
    }
  }

  Future<void> showShareDialog(BuildContext context, String data) async {
    try {
      final jsonObject = jsonDecode(data);

      if (jsonObject['status'] == 1) {
        final List<dynamic> jsonArray = jsonObject['data'];
        final List<SliderShareImage> sliderShareImages =
        jsonArray.map((e) => SliderShareImage.fromJson(e)).toList();

        final PageController pageController = PageController();
        int currentIndex = 0;
        final String? token = await AppStorage.getString(AppStorage.token);
        final String link =
            "https://mysaveapp.com/signup?sponserid=${token.toString()}";

        if (!context.mounted) return;

        showDialog(
          context: context,
          builder: (ctx) {
            return StatefulBuilder(
              builder: (context, setModalState) {
                return Dialog(
                  insetPadding: EdgeInsets.zero,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: sliderShareImages.length,
                            onPageChanged: (index) {
                              setModalState(() => currentIndex = index);
                            },
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      "https://mysaving.in/images/${sliderShareImages[index].image}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(sliderShareImages[index].description),
                                ],
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            sliderShareImages.length,
                                (index) => Container(
                              margin: const EdgeInsets.all(4),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == index
                                    ? primaryTeal
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          link,
                          style: const TextStyle(color: primaryTeal),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await Clipboard.setData(
                                  ClipboardData(text: link),
                                );
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Link copied to clipboard"),
                                  ),
                                );
                              },
                              child: const Text("Copy Link"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                ResponsiveInfo.showLoaderDialog(context);
                                try {
                                  final response = await http.get(
                                    Uri.parse(
                                      "https://mysaving.in/images/${sliderShareImages[currentIndex].image}",
                                    ),
                                  );
                                  final bytes = response.bodyBytes;
                                  final tempDir = await getTemporaryDirectory();
                                  final file = File(
                                    '${tempDir.path}/shared_image${ResponsiveInfo.getRandomNumber()}.jpg',
                                  );
                                  await file.writeAsBytes(bytes);

                                  await Share.shareXFiles(
                                    [XFile(file.path)],
                                    text:
                                    "${sliderShareImages[currentIndex].description}\n\n$link",
                                  );

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ResponsiveInfo.showAlertDialog(
                                      context,
                                      "Savekart",
                                      "Cannot fetch image from url",
                                    );
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: const Text("Share"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> getProfile() async {
    try {
      final Map<String, String> m = HashMap();
      final apiHelper = ApiHelper();
      final response =
      await apiHelper.post(Apimethodes.getUserDetails, formDataPayload: m);
      final js = jsonDecode(jsonDecode(response));
      final entity = ProfileDataEntity.fromJson(js);

      if (!mounted) return;
      if (entity.status == 1 && entity.data != null) {
        setState(() {
          final cleanedText = entity.data!.fullName
              .toString()
              .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
          name = cleanedText.trim();
        });
      }
    } catch (_) {
      // Keep UI usable if profile lookup fails.
    }
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final TextEditingController mobileController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Confirm Delete Account",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Enter Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mobile number is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Enter Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (mobileController.text.isNotEmpty) {
                  if (passwordController.text.isNotEmpty) {
                    ResponsiveInfo.showLoaderDialog(context);
                    final Map<String, String> m = HashMap();
                    m['uuid'] = "siuhdfid";
                    m['mobile'] = mobileController.text.toString();
                    m['password'] = passwordController.text.toString();
                    m['timestamp'] = ApiHelper.getTimeStamp();

                    final apiHelper = ApiHelper();
                    final response = await apiHelper.post(
                      Apimethodes.login,
                      formDataPayload: m,
                    );
                    if (!context.mounted) return;
                    Navigator.pop(context);

                    final js = jsonDecode(jsonDecode(response));
                    if (js['status'].toString() != "0") {
                      ResponsiveInfo.showLoaderDialog(context);
                      final response1 =
                      await apiHelper.get(Apimethodes.deleteAccount);
                      if (!context.mounted) return;
                      Navigator.pop(context);

                      final js1 = jsonDecode(jsonDecode(response1));
                      if (js1['status'].toString() != "0") {
                        AppStorage.SaveToken(AppStorage.token, "");
                        if (!context.mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                        );
                      } else if (context.mounted) {
                        ResponsiveInfo.showAlertDialog(
                          context,
                          "",
                          "Something went wrong",
                        );
                      }
                    } else if (context.mounted) {
                      ResponsiveInfo.showAlertDialog(
                        context,
                        "",
                        "This user account is not exist",
                      );
                    }
                  } else {
                    ResponsiveInfo.showAlertDialog(
                      context,
                      "",
                      "Please enter your account password",
                    );
                  }
                } else {
                  ResponsiveInfo.showAlertDialog(
                    context,
                    "",
                    "Please enter your registered mobile number",
                  );
                }
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}