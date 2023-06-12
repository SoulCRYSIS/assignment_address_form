part of 'select_subdistrict_bloc.dart';

abstract class SelectSubdistrictState extends Equatable {
  const SelectSubdistrictState();
}

class SelectSubdistrictInitial extends SelectSubdistrictState {
  @override
  List<Object> get props => [];
}

class SelectSubdistrictNoResultState extends SelectSubdistrictState {
  @override
  List<Object> get props => [];
}

class SelectSubdistrictSearchResultState extends SelectSubdistrictState {
  final List<Subdistrict> results;
  const SelectSubdistrictSearchResultState(this.results);
  
  @override
  List<Object> get props => [results];
}
