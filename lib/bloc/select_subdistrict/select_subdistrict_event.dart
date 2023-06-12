part of 'select_subdistrict_bloc.dart';

abstract class SelectSubdistrictEvent extends Equatable {
  const SelectSubdistrictEvent();

  @override
  List<Object> get props => [];
}

class SelectSubdistrictSearch extends SelectSubdistrictEvent {
  final String text;
  const SelectSubdistrictSearch(this.text);
}
