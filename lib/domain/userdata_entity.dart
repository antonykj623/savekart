import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/userdata_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/userdata_entity.g.dart';

@JsonSerializable()
class UserdataEntity {
	String? message = '';
	String? status = '';
	List<UserdataData>? data = [];

	UserdataEntity();

	factory UserdataEntity.fromJson(Map<String, dynamic> json) => $UserdataEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserdataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UserdataData {
	String? id = '';
	@JSONField(name: "full_name")
	String? fullName = '';
	@JSONField(name: "reg_code")
	String? regCode = '';
	@JSONField(name: "country_id")
	String? countryId = '';
	@JSONField(name: "state_id")
	String? stateId = '';
	String? mobile = '';
	@JSONField(name: "profile_image")
	String? profileImage = '';
	@JSONField(name: "email_id")
	String? emailId = '';
	String? currency = '';
	@JSONField(name: "join_date")
	String? joinDate = '';
	@JSONField(name: "activation_date")
	String? activationDate = '';
	@JSONField(name: "activation_key")
	dynamic activationKey;
	@JSONField(name: "join_source")
	String? joinSource = '';
	@JSONField(name: "used_link_for_registration")
	String? usedLinkForRegistration = '';
	@JSONField(name: "sp_reg_id")
	String? spRegId = '';
	@JSONField(name: "device_id")
	String? deviceId = '';
	@JSONField(name: "w_device_id")
	String? wDeviceId = '';
	@JSONField(name: "w_platform")
	String? wPlatform = '';
	@JSONField(name: "sp_reg_code")
	String? spRegCode = '';
	@JSONField(name: "default_lang")
	String? defaultLang = '';
	String? username = '';
	@JSONField(name: "encr_password")
	String? encrPassword = '';
	String? pwd = '';
	@JSONField(name: "gdrive_fileid")
	String? gdriveFileid = '';
	@JSONField(name: "unique_deviceId")
	String? uniqueDeviceid = '';
	@JSONField(name: "member_status")
	String? memberStatus = '';
	@JSONField(name: "reselling_partner")
	String? resellingPartner = '';
	String? coupon = '';
	@JSONField(name: "coup_stus")
	String? coupStus = '';
	@JSONField(name: "current_app_version")
	String? currentAppVersion = '';
	@JSONField(name: "phone_type")
	String? phoneType = '';
	@JSONField(name: "drive_mailId")
	String? driveMailid = '';
	@JSONField(name: "serverbackup_fileid")
	String? serverbackupFileid = '';
	@JSONField(name: "maths_trial_number")
	String? mathsTrialNumber = '';
	@JSONField(name: "maths_trial_status")
	String? mathsTrialStatus = '';
	@JSONField(name: "link_active")
	String? linkActive = '';
	@JSONField(name: "w_total_pts")
	String? wTotalPts = '';
	@JSONField(name: "w_redeemed_pts")
	String? wRedeemedPts = '';
	@JSONField(name: "w_balance_pts")
	String? wBalancePts = '';
	@JSONField(name: "cart_withdraw_pts")
	String? cartWithdrawPts = '';
	@JSONField(name: "save_premium")
	String? savePremium = '';
	@JSONField(name: "save_premium_initialdate")
	String? savePremiumInitialdate = '';
	@JSONField(name: "save_premium_trial_days")
	String? savePremiumTrialDays = '';
	@JSONField(name: "save_premium_reason")
	String? savePremiumReason = '';
	@JSONField(name: "save_premium_date")
	dynamic savePremiumDate;
	@JSONField(name: "save_premium_enddate")
	dynamic savePremiumEnddate;
	@JSONField(name: "mobile_change_req")
	String? mobileChangeReq = '';
	@JSONField(name: "family_id")
	String? familyId = '';

	UserdataData();

	factory UserdataData.fromJson(Map<String, dynamic> json) => $UserdataDataFromJson(json);

	Map<String, dynamic> toJson() => $UserdataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}