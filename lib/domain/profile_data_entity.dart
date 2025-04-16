import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/profile_data_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/profile_data_entity.g.dart';

@JsonSerializable()
class ProfileDataEntity {
	int? status = 0;
	ProfileDataData? data=new ProfileDataData();
	String? message = '';

	ProfileDataEntity();

	factory ProfileDataEntity.fromJson(Map<String, dynamic> json) => $ProfileDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProfileDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProfileDataData {
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
	dynamic pwd;
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

	ProfileDataData();

	factory ProfileDataData.fromJson(Map<String, dynamic> json) => $ProfileDataDataFromJson(json);

	Map<String, dynamic> toJson() => $ProfileDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}