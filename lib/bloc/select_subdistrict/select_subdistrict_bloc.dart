import 'package:assignment_address_form/model/subdistrict.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/address_data_repository.dart';

part 'select_subdistrict_event.dart';
part 'select_subdistrict_state.dart';

class SelectSubdistrictBloc
    extends Bloc<SelectSubdistrictEvent, SelectSubdistrictState> {
  final int districtId;
  final AddressDataRepository addressDataRepository;
  SelectSubdistrictBloc(this.districtId, this.addressDataRepository)
      : super(SelectSubdistrictInitial()) {
    on<SelectSubdistrictSearch>((event, emit) async {
      final subdistricts = await addressDataRepository.searchSubdistricts(
          event.text, districtId);
      if (subdistricts.isEmpty) {
        emit(SelectSubdistrictNoResultState());
      } else {
        emit(SelectSubdistrictSearchResultState(subdistricts));
      }
    });
  }
}
