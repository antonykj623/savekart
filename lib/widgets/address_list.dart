import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/domain/user_address_data_entity.dart';

import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  static const Color primaryTeal = Color(0xFF0B7D97);
  static const Color surfaceBg = Color(0xFFF6F8FA);

  final List<UserAddressDataData> _addresses = [];
  String selected_addressid = "0";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllAddress();
  }

  Future<void> getAllAddress() async {
    if (mounted) {
      setState(() => isLoading = true);
    }
    try {
      final apiHelper = EcommerceApiHelper();
      final t = EcommerceApiHelper.getTimeStamp();
      final response =
      await apiHelper.get("${Apimethodes.getAddressList}?q=$t");
      final js = jsonDecode(response);
      final entity = UserAddressDataEntity.fromJson(js);

      if (!mounted) return;
      setState(() {
        _addresses.clear();
        if (entity.status == 1 &&
            entity.data != null &&
            entity.data!.isNotEmpty) {
          _addresses.addAll(entity.data!);
          final stillExists = _addresses
              .any((a) => a.id.toString() == selected_addressid);
          if (!stillExists) {
            selected_addressid = _addresses[0].id.toString();
          }
        } else {
          selected_addressid = "0";
        }
        isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  void _popWithSelection() {
    Navigator.of(context).pop({
      'added': "1",
      'id': selected_addressid,
    });
  }

  Future<bool> _onWillPop() async {
    _popWithSelection();
    return false;
  }

  Future<void> _openAddAddressDialog() async {
    final result = await showDialog(
    context: context,
    builder: (_) => InputDialog(UserAddressDataData()),
    );

    if (result == null) return;

    final Map<String, String> mp = HashMap();
    mp['name'] = result['name'] ?? '';
    mp['house'] = result['house'] ?? '';
    mp['flatno'] = result['flatno'] ?? '';
    mp['landmark'] = result['landmark'] ?? '';
    mp['district'] = result['district'] ?? '';
    mp['place'] = result['place'] ?? '';
    mp['phone'] = result['phone'] ?? '';
    mp['pincode'] = result['pincode'] ?? '';
    mp['state'] = result['state'] ?? '';

    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();
    await apiHelper.post(
      "${Apimethodes.addAddress}?q=$t",
      formDataPayload: mp,
    );
    await getAllAddress();
  }

  Future<void> _openEditAddressDialog(UserAddressDataData address) async {
    final result = await showDialog(
    context: context,
    builder: (_) => InputDialog(address),
    );

    if (result == null) return;

    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();

    if (result.containsKey("delete") && result['delete'] == "1") {
      final Map<String, String> mp = HashMap();
      mp['id'] = address.id.toString();
      await apiHelper.post(
        "${Apimethodes.deleteAddress}?q=$t",
        formDataPayload: mp,
      );
      await getAllAddress();
      return;
    }

    final Map<String, String> mp = HashMap();
    mp['name'] = result['name'] ?? '';
    mp['house'] = result['house'] ?? '';
    mp['flatno'] = result['flatno'] ?? '';
    mp['landmark'] = result['landmark'] ?? '';
    mp['district'] = result['district'] ?? '';
    mp['place'] = result['place'] ?? '';
    mp['phone'] = result['phone'] ?? '';
    mp['pincode'] = result['pincode'] ?? '';
    mp['state'] = result['state'] ?? '';
    mp['id'] = address.id.toString();

    await apiHelper.post(
      "${Apimethodes.updateAddress}?q=$t",
      formDataPayload: mp,
    );
    await getAllAddress();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveInfo.isMobile(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: surfaceBg,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: primaryTeal,
              size: isMobile ? 22 : 26,
            ),
            onPressed: _popWithSelection,
          ),
          title: Text(
            'Delivery Addresses',
            style: TextStyle(
              color: const Color(0xFF1A1D1F),
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 16 : 19,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton.icon(
                onPressed: _openAddAddressDialog,
                icon: const Icon(
                  Icons.add_location_alt_outlined,
                  size: 18,
                  color: primaryTeal,
                ),
                label: Text(
                  "Add New",
                  style: TextStyle(
                    color: primaryTeal,
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 13.5 : 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(
          child: CircularProgressIndicator(color: primaryTeal),
        )
            : _addresses.isEmpty
            ? _buildEmptyState(isMobile)
            : ListView.separated(
          padding: EdgeInsets.all(isMobile ? 12 : 16),
          itemCount: _addresses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _buildAddressCard(_addresses[index], isMobile),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isMobile) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryTeal.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_off_outlined,
                size: 40,
                color: primaryTeal,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              "No Saved Addresses",
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1D1F),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Add a delivery address to proceed with your order.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryTeal,
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _openAddAddressDialog,
              icon: const Icon(Icons.add, size: 18),
              label: const Text(
                "Add New Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(UserAddressDataData address, bool isMobile) {
    final isSelected = address.id.toString() == selected_addressid;

    final line1 = [
      address.housename?.toString() ?? '',
      if ((address.flatno?.toString() ?? '').isNotEmpty &&
          address.flatno.toString() != 'null')
        address.flatno.toString(),
    ].where((s) => s.isNotEmpty).join(', ');

    final line2 = [
      address.landmark?.toString() ?? '',
      address.place?.toString() ?? '',
    ].where((s) => s.isNotEmpty && s != 'null').join(', ');

    final line3 = [
      address.district?.toString() ?? '',
      address.state?.toString() ?? '',
      if ((address.pincode?.toString() ?? '').isNotEmpty &&
          address.pincode.toString() != 'null')
        address.pincode.toString(),
    ].where((s) => s.isNotEmpty && s != 'null').join(', ');

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            selected_addressid = address.id.toString();
          });
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? primaryTeal : Colors.grey.shade200,
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: isSelected ? primaryTeal : Colors.grey.shade400,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      address.name.toString(),
                      style: TextStyle(
                        fontSize: isMobile ? 15 : 16.5,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1D1F),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () => _openEditAddressDialog(address),
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: primaryTeal,
                    ),
                    label: const Text(
                      "Edit",
                      style: TextStyle(
                        color: primaryTeal,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (line1.isNotEmpty)
                      Text(
                        line1,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 14,
                          color: const Color(0xFF2B2F33),
                        ),
                      ),
                    if (line2.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        line2,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 14,
                          color: const Color(0xFF2B2F33),
                        ),
                      ),
                    ],
                    if (line3.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        line3,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: surfaceBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 14,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            address.phone.toString(),
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected) ...[
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: isMobile ? 44 : 50,
                  child: ElevatedButton(
                    onPressed: _popWithSelection,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryTeal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Deliver to this Address",
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 15.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class InputDialog extends StatefulWidget {
  final UserAddressDataData userAddressDataData;

  const InputDialog(this.userAddressDataData, {super.key});

  @override
  _InputDialogState createState() =>
      _InputDialogState(userAddressDataData);
}

class _InputDialogState extends State<InputDialog> {
  static const Color primaryTeal = Color(0xFF0B7D97);
  static const Color surfaceBg = Color(0xFFF6F8FA);

  final _nameController = TextEditingController();
  final _houseflatnameController = TextEditingController();
  final _houseflatnoController = TextEditingController();
  final _placenameController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _districtController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pincodecontroller = TextEditingController();

  final List<String> countries = ['India'];

  final List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi (National Capital Territory)',
    'Jammu and Kashmir',
    'Ladakh',
    'Lakshadweep',
    'Puducherry',
  ];

  String selectedCountry = "India";
  String selectedState = "Kerala";

  UserAddressDataData userAddressDataData;
  _InputDialogState(this.userAddressDataData);

  String _cleanText(dynamic value) {
    final str = value?.toString() ?? '';
    return str == 'null' ? '' : str;
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = _cleanText(userAddressDataData.name);
    _phoneController.text = _cleanText(userAddressDataData.phone);
    _houseflatnameController.text = _cleanText(userAddressDataData.housename);
    _houseflatnoController.text = _cleanText(userAddressDataData.flatno);
    _placenameController.text = _cleanText(userAddressDataData.place);
    _landmarkController.text = _cleanText(userAddressDataData.landmark);
    _districtController.text = _cleanText(userAddressDataData.district);
    _pincodecontroller.text = _cleanText(userAddressDataData.pincode);

    final incomingState = _cleanText(userAddressDataData.state);
    if (incomingState.isNotEmpty && states.contains(incomingState)) {
      selectedState = incomingState;
    } else {
      selectedState = "Kerala";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _houseflatnameController.dispose();
    _houseflatnoController.dispose();
    _placenameController.dispose();
    _landmarkController.dispose();
    _districtController.dispose();
    _phoneController.dispose();
    _pincodecontroller.dispose();
    super.dispose();
  }

  void _submitData() {
    if (_nameController.text.trim().isEmpty) {
      ResponsiveInfo.showAlertDialog(context, "", "Enter name");
      return;
    }
    if (_houseflatnameController.text.trim().isEmpty) {
      ResponsiveInfo.showAlertDialog(context, "", "Enter House or Flat name");
      return;
    }
    if (_landmarkController.text.trim().isEmpty) {
      ResponsiveInfo.showAlertDialog(context, "", "Enter Landmark");
      return;
    }
    if (_placenameController.text.trim().isEmpty) {
      ResponsiveInfo.showAlertDialog(context, "", "Enter Place name");
      return;
    }
    if (_districtController.text.trim().isEmpty) {
      ResponsiveInfo.showAlertDialog(context, "", "Enter District");
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      ResponsiveInfo.showAlertDialog(context, "", "Enter Phone number");
      return;
    }
    if (_pincodecontroller.text.trim().isEmpty) {
      ResponsiveInfo.showAlertDialog(context, "", "Enter Pincode");
      return;
    }

    Navigator.of(context).pop({
      'name': _nameController.text.trim(),
      'house': _houseflatnameController.text.trim(),
      'flatno': _houseflatnoController.text.trim(),
      'landmark': _landmarkController.text.trim(),
      'place': _placenameController.text.trim(),
      'district': _districtController.text.trim(),
      'state': selectedState,
      'phone': _phoneController.text.trim(),
      'pincode': _pincodecontroller.text.trim(),
    });
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: surfaceBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryTeal, width: 1.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _cleanText(userAddressDataData.id).isNotEmpty;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Text(
        isEditing ? "Edit Address" : "Add Delivery Address",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A1D1F),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: _fieldDecoration("Full Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _houseflatnameController,
                decoration: _fieldDecoration("House / Flat Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _houseflatnoController,
                decoration: _fieldDecoration("Flat No. (optional)"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _landmarkController,
                decoration: _fieldDecoration("Landmark"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _placenameController,
                decoration: _fieldDecoration("Place / City"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _districtController,
                decoration: _fieldDecoration("District"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: _fieldDecoration("Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _pincodecontroller,
                decoration: _fieldDecoration("Pin Code"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: selectedState,
                decoration: _fieldDecoration("State"),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => selectedState = newValue);
                  }
                },
                items: states
                    .map(
                      (state) => DropdownMenuItem<String>(
                    value: state,
                    child: Text(
                      state,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                    .toList(),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: selectedCountry,
                decoration: _fieldDecoration("Country"),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => selectedCountry = newValue);
                  }
                },
                items: countries
                    .map(
                      (country) => DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  ),
                )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryTeal,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: _submitData,
          child: const Text(
            "Save Address",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}