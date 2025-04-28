import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_aroma_body.g.dart';

@JsonSerializable()
class UpdateAromaBody {
  final String id;
  final String name;
  final AromaType type;

  UpdateAromaBody({required this.id, required this.name, required this.type});

  factory UpdateAromaBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateAromaBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAromaBodyToJson(this);
}
