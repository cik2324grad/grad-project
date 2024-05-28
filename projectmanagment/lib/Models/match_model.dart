import 'package:json_annotation/json_annotation.dart';

part 'match_model.g.dart';

@JsonSerializable()
final class MatchModel {
  final String? matchID;
  final String? matchingStatus;
  final String? receivedUser;
  final String? senderUser;

  MatchModel(
      {required this.matchID,
      required this.matchingStatus,
      required this.receivedUser,
      required this.senderUser});

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchModelToJson(this);
}
