import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String province;
  final String district;
  final String subdistrict;

  const Address(this.province, this.district, this.subdistrict);

  @override
  List<Object?> get props => [province, district, subdistrict];
}
