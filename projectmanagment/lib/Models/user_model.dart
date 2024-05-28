
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
final class UserModel {
  final String? uniqueUserID;
  final String? userName;
  final String? userAdditionalInformation;
  final String? universityDepartmant;
  final List<dynamic>? categories;
  final int? age;
  final String? profilePircture;
  final List<dynamic>? acceptingMatching;
  final List<dynamic>? rejectingMatching;
  final List<dynamic>? waitingMatching;

  UserModel(
      {required this.uniqueUserID,
      required this.userName,
      required this.userAdditionalInformation,
      required this.universityDepartmant,
      required this.categories,
      required this.age,
      required this.profilePircture,
      required this.acceptingMatching,
      required this.rejectingMatching,
      required this.waitingMatching});

    factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
