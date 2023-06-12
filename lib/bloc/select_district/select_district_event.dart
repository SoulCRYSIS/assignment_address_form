part of 'select_district_bloc.dart';

abstract class SelectDistrictEvent extends Equatable {
  const SelectDistrictEvent();

  @override
  List<Object> get props => [];
}

class SelectDistrictSearch extends SelectDistrictEvent {
  final String text;
  const SelectDistrictSearch(this.text);
}
