import 'package:assignment_address_form/model/district.dart';
import 'package:assignment_address_form/repository/address_data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_district_event.dart';
part 'select_district_state.dart';

class SelectDistrictBloc
    extends Bloc<SelectDistrictEvent, SelectDistrictState> {
  final int provinceId;
  final AddressDataRepository addressDataRepository;
  SelectDistrictBloc(this.provinceId, this.addressDataRepository)
      : super(SelectDistrictInitial()) {
    on<SelectDistrictSearch>((event, emit) async {
      final districts =
          await addressDataRepository.searchDistricts(event.text, provinceId);
      if (districts.isEmpty) {
        emit(SelectDistrictNoResultState());
      } else {
        emit(SelectDistrictSearchResultState(districts));
      }
    });
  }
}
