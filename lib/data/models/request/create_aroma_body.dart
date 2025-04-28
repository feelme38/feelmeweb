import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_aroma_body.g.dart';

@JsonSerializable()
class CreateAromaBody {
  final String name;
  final AromaType type;

  CreateAromaBody({required this.name, required this.type});

  factory CreateAromaBody.fromJson(Map<String, dynamic> json) =>
      _$CreateAromaBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAromaBodyToJson(this);
}
