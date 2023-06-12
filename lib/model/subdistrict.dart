import 'package:json_annotation/json_annotation.dart';
part 'subdistrict.g.dart';

@JsonSerializable()
class Subdistrict {
  final int id;
  // ignore: non_constant_identifier_names
  final int amphure_id;
  // ignore: non_constant_identifier_names
  final String name_th;
  
  const Subdistrict(this.id, this.amphure_id, this.name_th);

  factory Subdistrict.fromJson(Map<String, dynamic> json) =>
      _$SubdistrictFromJson(json);

  Map<String, dynamic> toJson() => _$SubdistrictToJson(this);
}
