import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserDetails {

  String? contactNumber;
  String? emergencyContactNumber;
  String? emergencyContactName;
  String? seaBookNumber;
  String? gender;
  String? dob;
  String? nationality;
  String? language;
  String? passportNumber;
  String? placeOfIssue;
  String? userType;

  UserDetails({
    this.contactNumber,
    this.emergencyContactNumber,
    this.emergencyContactName,
    this.seaBookNumber,
    this.gender,
    this.dob,
    this.nationality,
    this.language,
    this.passportNumber,
    this.placeOfIssue,
    this.userType,
  });
}


abstract class BaseBlogsController extends GetxController {
  Map<String, dynamic> get blogData;
}
