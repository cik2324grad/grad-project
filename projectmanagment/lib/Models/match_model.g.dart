// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => MatchModel(
      matchID: json['matchID'] as String?,
      matchingStatus: json['matchingStatus'] as String?,
      receivedUser: json['receivedUser'] as String?,
      senderUser: json['senderUser'] as String?,
    );

Map<String, dynamic> _$MatchModelToJson(MatchModel instance) =>
    <String, dynamic>{
      'matchID': instance.matchID,
      'matchingStatus': instance.matchingStatus,
      'receivedUser': instance.receivedUser,
      'senderUser': instance.senderUser,
    };
