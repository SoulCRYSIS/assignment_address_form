import 'package:json_annotation/json_annotation.dart';
part 'district.g.dart';

@JsonSerializable()
class District {
  final int id;
  // ignore: non_constant_identifier_names
  final int province_id;
  // ignore: non_constant_identifier_names
  final String name_th;
  
  const District(this.id, this.province_id, this.name_th);

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
