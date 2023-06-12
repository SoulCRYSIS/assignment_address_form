import 'package:assignment_address_form/model/address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAddressCubit extends Cubit<Address> {
  SelectAddressCubit()
      : super(const Address('กรุงเทพมหานคร', 'เขตพระนคร', 'พระบรมมหาราชวัง'));

  void setAddress(Address address) {
    emit(address);
  }
}
