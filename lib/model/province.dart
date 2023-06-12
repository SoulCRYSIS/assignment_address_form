import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'province.g.dart';

@JsonSerializable()
class Province extends Equatable {
  final int id;
  // ignore: non_constant_identifier_names
  final String name_th;
  const Province(this.id, this.name_th);

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);

  @override
  List<Object?> get props => [id, name_th];
}
