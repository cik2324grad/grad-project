class UserModel2 {
  String? uid;
  String? userName;
  String? userAdditionalInformation;
  int? userAge;
  bool? sharePhoneNumber;
  String? userPicture;
  String? phoneNumber;
  String? userMail;
  List<dynamic>? acceptingMatching;
  List<dynamic>? rejectingMatching;
  List<dynamic>? waitingMatching;
  List<dynamic>? inComingMatchRequests;
  Map<String, dynamic>? userCategoryList;
  double? weight;

  UserModel2({
    this.uid,
    this.userName,
    this.userAdditionalInformation,
    this.userAge,
    this.sharePhoneNumber,
    this.userPicture,
    this.phoneNumber,
    this.userMail,
    this.acceptingMatching,
    this.rejectingMatching,
    this.waitingMatching,
    this.inComingMatchRequests,
    this.userCategoryList,
    this.weight,
  });

  factory UserModel2.fromJson(Map<String, dynamic> data) {
    return UserModel2(
      uid: data['uid'],
      userName: data['userName'],
      userAdditionalInformation: data['userAdditionalInformation'],
      userAge: data['userAge'],
      sharePhoneNumber: data['sharePhoneNumber'],
      userPicture: data['userPicture'],
      phoneNumber: data['phoneNumber'],
      userMail: data['userMail'],
      acceptingMatching: data['acceptingMatching'] != null
          ? List<dynamic>.from(data['acceptingMatching'])
          : null,
      rejectingMatching: data['rejectingMatching'] != null
          ? List<dynamic>.from(data['rejectingMatching'])
          : null,
      waitingMatching: data['waitingMatching'] != null
          ? List<dynamic>.from(data['waitingMatching'])
          : null,
      inComingMatchRequests: data['inComingMatchRequests'] != null
          ? List<dynamic>.from(data['inComingMatchRequests'])
          : null,
      userCategoryList: data['userCategoryList'] != null
          ? Map<String, dynamic>.from(data['userCategoryList'])
          : null,
      weight: data['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'userAdditionalInformation': userAdditionalInformation,
      'userAge': userAge,
      'sharePhoneNumber': sharePhoneNumber,
      'userPicture': userPicture,
      'phoneNumber': phoneNumber,
      'userMail': userMail,
      'acceptingMatching': acceptingMatching,
      'rejectingMatching': rejectingMatching,
      'waitingMatching': waitingMatching,
      'inComingMatchRequests': inComingMatchRequests,
      'userCategoryList': userCategoryList,
      'weight': weight,
    };
  }
}

//user difflerini kaydetmek için

class UserDifference {
  final UserModel2 user;
  final Map<String, int> differences;

  UserDifference({
    required this.user,
    required this.differences,
  });
}
