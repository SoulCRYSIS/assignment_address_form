part of 'select_district_bloc.dart';

abstract class SelectDistrictState extends Equatable {
  const SelectDistrictState();
}

class SelectDistrictInitial extends SelectDistrictState {
  @override
  List<Object> get props => [];
}

class SelectDistrictNoResultState extends SelectDistrictState {
  @override
  List<Object> get props => [];
}

class SelectDistrictSearchResultState extends SelectDistrictState {
  final List<District> results;
  const SelectDistrictSearchResultState(this.results);
  
  @override
  List<Object> get props => [results];
}
