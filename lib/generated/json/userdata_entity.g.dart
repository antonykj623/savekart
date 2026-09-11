import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/userdata_entity.dart';

UserdataEntity $UserdataEntityFromJson(Map<String, dynamic> json) {
  final UserdataEntity userdataEntity = UserdataEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    userdataEntity.message = message;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    userdataEntity.status = status;
  }
  final List<UserdataData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<UserdataData>(e) as UserdataData).toList();
  if (data != null) {
    userdataEntity.data = data;
  }
  return userdataEntity;
}

Map<String, dynamic> $UserdataEntityToJson(UserdataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension UserdataEntityExtension on UserdataEntity {
  UserdataEntity copyWith({
    String? message,
    String? status,
    List<UserdataData>? data,
  }) {
    return UserdataEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

UserdataData $UserdataDataFromJson(Map<String, dynamic> json) {
  final UserdataData userdataData = UserdataData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    userdataData.id = id;
  }
  final String? fullName = jsonConvert.convert<String>(json['full_name']);
  if (fullName != null) {
    userdataData.fullName = fullName;
  }
  final String? regCode = jsonConvert.convert<String>(json['reg_code']);
  if (regCode != null) {
    userdataData.regCode = regCode;
  }
  final String? countryId = jsonConvert.convert<String>(json['country_id']);
  if (countryId != null) {
    userdataData.countryId = countryId;
  }
  final String? stateId = jsonConvert.convert<String>(json['state_id']);
  if (stateId != null) {
    userdataData.stateId = stateId;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    userdataData.mobile = mobile;
  }
  final String? profileImage = jsonConvert.convert<String>(
      json['profile_image']);
  if (profileImage != null) {
    userdataData.profileImage = profileImage;
  }
  final String? emailId = jsonConvert.convert<String>(json['email_id']);
  if (emailId != null) {
    userdataData.emailId = emailId;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    userdataData.currency = currency;
  }
  final String? joinDate = jsonConvert.convert<String>(json['join_date']);
  if (joinDate != null) {
    userdataData.joinDate = joinDate;
  }
  final String? activationDate = jsonConvert.convert<String>(
      json['activation_date']);
  if (activationDate != null) {
    userdataData.activationDate = activationDate;
  }
  final dynamic activationKey = json['activation_key'];
  if (activationKey != null) {
    userdataData.activationKey = activationKey;
  }
  final String? joinSource = jsonConvert.convert<String>(json['join_source']);
  if (joinSource != null) {
    userdataData.joinSource = joinSource;
  }
  final String? usedLinkForRegistration = jsonConvert.convert<String>(
      json['used_link_for_registration']);
  if (usedLinkForRegistration != null) {
    userdataData.usedLinkForRegistration = usedLinkForRegistration;
  }
  final String? spRegId = jsonConvert.convert<String>(json['sp_reg_id']);
  if (spRegId != null) {
    userdataData.spRegId = spRegId;
  }
  final String? deviceId = jsonConvert.convert<String>(json['device_id']);
  if (deviceId != null) {
    userdataData.deviceId = deviceId;
  }
  final String? wDeviceId = jsonConvert.convert<String>(json['w_device_id']);
  if (wDeviceId != null) {
    userdataData.wDeviceId = wDeviceId;
  }
  final String? wPlatform = jsonConvert.convert<String>(json['w_platform']);
  if (wPlatform != null) {
    userdataData.wPlatform = wPlatform;
  }
  final String? spRegCode = jsonConvert.convert<String>(json['sp_reg_code']);
  if (spRegCode != null) {
    userdataData.spRegCode = spRegCode;
  }
  final String? defaultLang = jsonConvert.convert<String>(json['default_lang']);
  if (defaultLang != null) {
    userdataData.defaultLang = defaultLang;
  }
  final String? username = jsonConvert.convert<String>(json['username']);
  if (username != null) {
    userdataData.username = username;
  }
  final String? encrPassword = jsonConvert.convert<String>(
      json['encr_password']);
  if (encrPassword != null) {
    userdataData.encrPassword = encrPassword;
  }
  final String? pwd = jsonConvert.convert<String>(json['pwd']);
  if (pwd != null) {
    userdataData.pwd = pwd;
  }
  final String? gdriveFileid = jsonConvert.convert<String>(
      json['gdrive_fileid']);
  if (gdriveFileid != null) {
    userdataData.gdriveFileid = gdriveFileid;
  }
  final String? uniqueDeviceid = jsonConvert.convert<String>(
      json['unique_deviceId']);
  if (uniqueDeviceid != null) {
    userdataData.uniqueDeviceid = uniqueDeviceid;
  }
  final String? memberStatus = jsonConvert.convert<String>(
      json['member_status']);
  if (memberStatus != null) {
    userdataData.memberStatus = memberStatus;
  }
  final String? resellingPartner = jsonConvert.convert<String>(
      json['reselling_partner']);
  if (resellingPartner != null) {
    userdataData.resellingPartner = resellingPartner;
  }
  final String? coupon = jsonConvert.convert<String>(json['coupon']);
  if (coupon != null) {
    userdataData.coupon = coupon;
  }
  final String? coupStus = jsonConvert.convert<String>(json['coup_stus']);
  if (coupStus != null) {
    userdataData.coupStus = coupStus;
  }
  final String? currentAppVersion = jsonConvert.convert<String>(
      json['current_app_version']);
  if (currentAppVersion != null) {
    userdataData.currentAppVersion = currentAppVersion;
  }
  final String? phoneType = jsonConvert.convert<String>(json['phone_type']);
  if (phoneType != null) {
    userdataData.phoneType = phoneType;
  }
  final String? driveMailid = jsonConvert.convert<String>(json['drive_mailId']);
  if (driveMailid != null) {
    userdataData.driveMailid = driveMailid;
  }
  final String? serverbackupFileid = jsonConvert.convert<String>(
      json['serverbackup_fileid']);
  if (serverbackupFileid != null) {
    userdataData.serverbackupFileid = serverbackupFileid;
  }
  final String? mathsTrialNumber = jsonConvert.convert<String>(
      json['maths_trial_number']);
  if (mathsTrialNumber != null) {
    userdataData.mathsTrialNumber = mathsTrialNumber;
  }
  final String? mathsTrialStatus = jsonConvert.convert<String>(
      json['maths_trial_status']);
  if (mathsTrialStatus != null) {
    userdataData.mathsTrialStatus = mathsTrialStatus;
  }
  final String? linkActive = jsonConvert.convert<String>(json['link_active']);
  if (linkActive != null) {
    userdataData.linkActive = linkActive;
  }
  final String? wTotalPts = jsonConvert.convert<String>(json['w_total_pts']);
  if (wTotalPts != null) {
    userdataData.wTotalPts = wTotalPts;
  }
  final String? wRedeemedPts = jsonConvert.convert<String>(
      json['w_redeemed_pts']);
  if (wRedeemedPts != null) {
    userdataData.wRedeemedPts = wRedeemedPts;
  }
  final String? wBalancePts = jsonConvert.convert<String>(
      json['w_balance_pts']);
  if (wBalancePts != null) {
    userdataData.wBalancePts = wBalancePts;
  }
  final String? cartWithdrawPts = jsonConvert.convert<String>(
      json['cart_withdraw_pts']);
  if (cartWithdrawPts != null) {
    userdataData.cartWithdrawPts = cartWithdrawPts;
  }
  final String? savePremium = jsonConvert.convert<String>(json['save_premium']);
  if (savePremium != null) {
    userdataData.savePremium = savePremium;
  }
  final String? savePremiumInitialdate = jsonConvert.convert<String>(
      json['save_premium_initialdate']);
  if (savePremiumInitialdate != null) {
    userdataData.savePremiumInitialdate = savePremiumInitialdate;
  }
  final String? savePremiumTrialDays = jsonConvert.convert<String>(
      json['save_premium_trial_days']);
  if (savePremiumTrialDays != null) {
    userdataData.savePremiumTrialDays = savePremiumTrialDays;
  }
  final String? savePremiumReason = jsonConvert.convert<String>(
      json['save_premium_reason']);
  if (savePremiumReason != null) {
    userdataData.savePremiumReason = savePremiumReason;
  }
  final dynamic savePremiumDate = json['save_premium_date'];
  if (savePremiumDate != null) {
    userdataData.savePremiumDate = savePremiumDate;
  }
  final dynamic savePremiumEnddate = json['save_premium_enddate'];
  if (savePremiumEnddate != null) {
    userdataData.savePremiumEnddate = savePremiumEnddate;
  }
  final String? mobileChangeReq = jsonConvert.convert<String>(
      json['mobile_change_req']);
  if (mobileChangeReq != null) {
    userdataData.mobileChangeReq = mobileChangeReq;
  }
  final String? familyId = jsonConvert.convert<String>(json['family_id']);
  if (familyId != null) {
    userdataData.familyId = familyId;
  }
  return userdataData;
}

Map<String, dynamic> $UserdataDataToJson(UserdataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['full_name'] = entity.fullName;
  data['reg_code'] = entity.regCode;
  data['country_id'] = entity.countryId;
  data['state_id'] = entity.stateId;
  data['mobile'] = entity.mobile;
  data['profile_image'] = entity.profileImage;
  data['email_id'] = entity.emailId;
  data['currency'] = entity.currency;
  data['join_date'] = entity.joinDate;
  data['activation_date'] = entity.activationDate;
  data['activation_key'] = entity.activationKey;
  data['join_source'] = entity.joinSource;
  data['used_link_for_registration'] = entity.usedLinkForRegistration;
  data['sp_reg_id'] = entity.spRegId;
  data['device_id'] = entity.deviceId;
  data['w_device_id'] = entity.wDeviceId;
  data['w_platform'] = entity.wPlatform;
  data['sp_reg_code'] = entity.spRegCode;
  data['default_lang'] = entity.defaultLang;
  data['username'] = entity.username;
  data['encr_password'] = entity.encrPassword;
  data['pwd'] = entity.pwd;
  data['gdrive_fileid'] = entity.gdriveFileid;
  data['unique_deviceId'] = entity.uniqueDeviceid;
  data['member_status'] = entity.memberStatus;
  data['reselling_partner'] = entity.resellingPartner;
  data['coupon'] = entity.coupon;
  data['coup_stus'] = entity.coupStus;
  data['current_app_version'] = entity.currentAppVersion;
  data['phone_type'] = entity.phoneType;
  data['drive_mailId'] = entity.driveMailid;
  data['serverbackup_fileid'] = entity.serverbackupFileid;
  data['maths_trial_number'] = entity.mathsTrialNumber;
  data['maths_trial_status'] = entity.mathsTrialStatus;
  data['link_active'] = entity.linkActive;
  data['w_total_pts'] = entity.wTotalPts;
  data['w_redeemed_pts'] = entity.wRedeemedPts;
  data['w_balance_pts'] = entity.wBalancePts;
  data['cart_withdraw_pts'] = entity.cartWithdrawPts;
  data['save_premium'] = entity.savePremium;
  data['save_premium_initialdate'] = entity.savePremiumInitialdate;
  data['save_premium_trial_days'] = entity.savePremiumTrialDays;
  data['save_premium_reason'] = entity.savePremiumReason;
  data['save_premium_date'] = entity.savePremiumDate;
  data['save_premium_enddate'] = entity.savePremiumEnddate;
  data['mobile_change_req'] = entity.mobileChangeReq;
  data['family_id'] = entity.familyId;
  return data;
}

extension UserdataDataExtension on UserdataData {
  UserdataData copyWith({
    String? id,
    String? fullName,
    String? regCode,
    String? countryId,
    String? stateId,
    String? mobile,
    String? profileImage,
    String? emailId,
    String? currency,
    String? joinDate,
    String? activationDate,
    dynamic activationKey,
    String? joinSource,
    String? usedLinkForRegistration,
    String? spRegId,
    String? deviceId,
    String? wDeviceId,
    String? wPlatform,
    String? spRegCode,
    String? defaultLang,
    String? username,
    String? encrPassword,
    String? pwd,
    String? gdriveFileid,
    String? uniqueDeviceid,
    String? memberStatus,
    String? resellingPartner,
    String? coupon,
    String? coupStus,
    String? currentAppVersion,
    String? phoneType,
    String? driveMailid,
    String? serverbackupFileid,
    String? mathsTrialNumber,
    String? mathsTrialStatus,
    String? linkActive,
    String? wTotalPts,
    String? wRedeemedPts,
    String? wBalancePts,
    String? cartWithdrawPts,
    String? savePremium,
    String? savePremiumInitialdate,
    String? savePremiumTrialDays,
    String? savePremiumReason,
    dynamic savePremiumDate,
    dynamic savePremiumEnddate,
    String? mobileChangeReq,
    String? familyId,
  }) {
    return UserdataData()
      ..id = id ?? this.id
      ..fullName = fullName ?? this.fullName
      ..regCode = regCode ?? this.regCode
      ..countryId = countryId ?? this.countryId
      ..stateId = stateId ?? this.stateId
      ..mobile = mobile ?? this.mobile
      ..profileImage = profileImage ?? this.profileImage
      ..emailId = emailId ?? this.emailId
      ..currency = currency ?? this.currency
      ..joinDate = joinDate ?? this.joinDate
      ..activationDate = activationDate ?? this.activationDate
      ..activationKey = activationKey ?? this.activationKey
      ..joinSource = joinSource ?? this.joinSource
      ..usedLinkForRegistration = usedLinkForRegistration ??
          this.usedLinkForRegistration
      ..spRegId = spRegId ?? this.spRegId
      ..deviceId = deviceId ?? this.deviceId
      ..wDeviceId = wDeviceId ?? this.wDeviceId
      ..wPlatform = wPlatform ?? this.wPlatform
      ..spRegCode = spRegCode ?? this.spRegCode
      ..defaultLang = defaultLang ?? this.defaultLang
      ..username = username ?? this.username
      ..encrPassword = encrPassword ?? this.encrPassword
      ..pwd = pwd ?? this.pwd
      ..gdriveFileid = gdriveFileid ?? this.gdriveFileid
      ..uniqueDeviceid = uniqueDeviceid ?? this.uniqueDeviceid
      ..memberStatus = memberStatus ?? this.memberStatus
      ..resellingPartner = resellingPartner ?? this.resellingPartner
      ..coupon = coupon ?? this.coupon
      ..coupStus = coupStus ?? this.coupStus
      ..currentAppVersion = currentAppVersion ?? this.currentAppVersion
      ..phoneType = phoneType ?? this.phoneType
      ..driveMailid = driveMailid ?? this.driveMailid
      ..serverbackupFileid = serverbackupFileid ?? this.serverbackupFileid
      ..mathsTrialNumber = mathsTrialNumber ?? this.mathsTrialNumber
      ..mathsTrialStatus = mathsTrialStatus ?? this.mathsTrialStatus
      ..linkActive = linkActive ?? this.linkActive
      ..wTotalPts = wTotalPts ?? this.wTotalPts
      ..wRedeemedPts = wRedeemedPts ?? this.wRedeemedPts
      ..wBalancePts = wBalancePts ?? this.wBalancePts
      ..cartWithdrawPts = cartWithdrawPts ?? this.cartWithdrawPts
      ..savePremium = savePremium ?? this.savePremium
      ..savePremiumInitialdate = savePremiumInitialdate ??
          this.savePremiumInitialdate
      ..savePremiumTrialDays = savePremiumTrialDays ?? this.savePremiumTrialDays
      ..savePremiumReason = savePremiumReason ?? this.savePremiumReason
      ..savePremiumDate = savePremiumDate ?? this.savePremiumDate
      ..savePremiumEnddate = savePremiumEnddate ?? this.savePremiumEnddate
      ..mobileChangeReq = mobileChangeReq ?? this.mobileChangeReq
      ..familyId = familyId ?? this.familyId;
  }
}