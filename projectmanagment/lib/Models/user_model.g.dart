// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uniqueUserID: json['uniqueUserID'] as String?,
      userName: json['userName'] as String?,
      userAdditionalInformation: json['userAdditionalInformation'] as String?,
      universityDepartmant: json['universityDepartmant'] as String?,
      categories: json['categories'] as List<dynamic>?,
      age: json['age'] as int?,
      profilePircture: json['profilePircture'] as String?,
      acceptingMatching: json['acceptingMatching'] as List<dynamic>?,
      rejectingMatching: json['rejectingMatching'] as List<dynamic>?,
      waitingMatching: json['waitingMatching'] as List<dynamic>?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uniqueUserID': instance.uniqueUserID,
      'userName': instance.userName,
      'userAdditionalInformation': instance.userAdditionalInformation,
      'universityDepartmant': instance.universityDepartmant,
      'categories': instance.categories,
      'age': instance.age,
      'profilePircture': instance.profilePircture,
      'acceptingMatching': instance.acceptingMatching,
      'rejectingMatching': instance.rejectingMatching,
      'waitingMatching': instance.waitingMatching,
    };
