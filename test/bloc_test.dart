import 'package:assignment_address_form/bloc/select_address_cubit.dart';
import 'package:assignment_address_form/bloc/select_province/select_province_bloc.dart';
import 'package:assignment_address_form/model/address.dart';
import 'package:assignment_address_form/model/province.dart';
import 'package:assignment_address_form/repository/address_data_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  group('SelectProvinceBloc', () {
    final AddressDataRepository addressDataRepository =
        AddressDataRepository(httpClient: http.Client());
    blocTest(
      'emits [SelectProvinceNoResultState] when SelectProvinceSearch event is added with no matching provinces',
      build: () => SelectProvinceBloc(addressDataRepository),
      act: (bloc) => bloc.add(const SelectProvinceSearch('random word')),
      wait: const Duration(seconds: 1),
      expect: () => [isA<SelectProvinceNoResultState>()],
    );

    blocTest<SelectProvinceBloc, SelectProvinceState>(
      'emits [SelectProvinceSearchResultState] with ["กรุงเทพมหานคร"] when SelectProvinceSearch event is added with "กรุงเทพ"',
      build: () => SelectProvinceBloc(addressDataRepository),
      act: (bloc) => bloc.add(const SelectProvinceSearch('กรุงเทพ')),
      wait: const Duration(seconds: 1),
      expect: () => [isA<SelectProvinceSearchResultState>()],
      verify: (bloc) {
        final state = bloc.state as SelectProvinceSearchResultState;
        expect(state.results, [const Province(1, 'กรุงเทพมหานคร')]);
      },
    );

    blocTest<SelectProvinceBloc, SelectProvinceState>(
      'emits [SelectProvinceSearchResultState] with all provinces when SelectProvinceSearch event is added with empty string',
      build: () => SelectProvinceBloc(addressDataRepository),
      act: (bloc) => bloc.add(const SelectProvinceSearch('')),
      wait: const Duration(seconds: 1),
      expect: () => [isA<SelectProvinceSearchResultState>()],
      verify: (bloc) {
        final state = bloc.state as SelectProvinceSearchResultState;
        expect(state.results.length, 77);
      },
    );
  });

  group('SelectAddressCubit', () {
    test(
        'initial state should be ["กรุงเทพมหานคร", "เขตพระนคร", "พระบรมมหาราชวัง"]',
        () {
      final cubit = SelectAddressCubit();
      expect(cubit.state,
          const Address('กรุงเทพมหานคร', 'เขตพระนคร', 'พระบรมมหาราชวัง'));
    });

    blocTest(
      'emits new address when setAddress is called',
      build: () => SelectAddressCubit(),
      act: (cubit) => cubit.setAddress(
          const Address('สมุทรสาคร', 'เมืองสมุทรสาคร', 'บางน้ำจืด')),
      expect: () => [
        const Address('สมุทรสาคร', 'เมืองสมุทรสาคร', 'บางน้ำจืด'),
      ],
    );
  });
}
