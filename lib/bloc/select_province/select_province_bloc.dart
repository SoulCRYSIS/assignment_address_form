import 'package:assignment_address_form/model/province.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/address_data_repository.dart';

part 'select_province_event.dart';
part 'select_province_state.dart';

class SelectProvinceBloc
    extends Bloc<SelectProvinceEvent, SelectProvinceState> {
  final AddressDataRepository addressDataRepository;
  SelectProvinceBloc(this.addressDataRepository)
      : super(SelectProvinceInitial()) {
    on<SelectProvinceSearch>((event, emit) async {
      final provinces = await addressDataRepository.searchProvinces(event.text);
      if (provinces.isEmpty) {
        emit(SelectProvinceNoResultState());
      } else {
        emit(SelectProvinceSearchResultState(provinces));
      }
    });
  }
}
