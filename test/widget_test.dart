import 'package:assignment_address_form/bloc/select_address_cubit.dart';
import 'package:assignment_address_form/model/district.dart';
import 'package:assignment_address_form/model/province.dart';
import 'package:assignment_address_form/model/subdistrict.dart';
import 'package:assignment_address_form/repository/address_data_repository.dart';
import 'package:assignment_address_form/screen/home_screen.dart';
import 'package:assignment_address_form/screen/province_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([AddressDataRepository])
void main() {
  final mockRepository = MockAddressDataRepository();
  when(mockRepository.searchProvinces(''))
      .thenAnswer((_) async => const [Province(1, 'กรุงเทพมหานคร')]);
  when(mockRepository.searchDistricts('', 1))
      .thenAnswer((_) async => const [District(1001, 1, 'เขตพระนคร')]);
  when(mockRepository.searchSubdistricts('', 1001)).thenAnswer(
      (_) async => const [Subdistrict(100101, 1001, 'พระบรมมหาราชวัง')]);

  group('Home screen', () {
    testWidgets('Initial value for address', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => SelectAddressCubit(),
          child: MaterialApp(
            home: HomeScreen(mockRepository),
          ),
        ),
      );

      expect(find.text('กรุงเทพมหานคร'), findsOneWidget);
      expect(find.text('เขตพระนคร'), findsOneWidget);
      expect(find.text('พระบรมมหาราชวัง'), findsOneWidget);
      expect(find.text('ที่อยู่ติดต่อได้'), findsOneWidget);
    });

    testWidgets('Go to province select when tap', (tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => SelectAddressCubit(),
          child: MaterialApp(
            home: HomeScreen(mockRepository),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('editAddress')));
      await tester.pumpAndSettle();

      expect(find.text('Select Province'), findsOneWidget);
    });
  });

  group('Province screen', () {
    testWidgets('search with result', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ProvinceScreen(mockRepository),
      ));

      final searchField = find.byKey(const Key('searchBox'));
      expect(searchField, findsOneWidget);

      when(mockRepository.searchProvinces('สมุทรสา'))
          .thenAnswer((_) async => const [Province(59, 'สมุทรสาคร')]);

      await tester.enterText(searchField, 'สมุทรสา');
      await tester.pump();
      expect(find.text('สมุทรสา'), findsOneWidget);
      expect(find.text('สมุทรสาคร'), findsOneWidget);
    });

    testWidgets('search no result', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ProvinceScreen(mockRepository),
      ));

      final searchField = find.byKey(const Key('searchBox'));
      expect(searchField, findsOneWidget);

      when(mockRepository.searchProvinces('random text'))
          .thenAnswer((_) async => const []);

      await tester.enterText(searchField, 'random text');
      await tester.pump();
      expect(find.text('random text'), findsOneWidget);
      expect(find.text('ไม่พบคำที่คุณค้นหา'), findsOneWidget);
    });

    testWidgets('clear button', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ProvinceScreen(mockRepository),
      ));

      final searchField = find.byKey(const Key('searchBox'));
      expect(searchField, findsOneWidget);

      when(mockRepository.searchProvinces('random text'))
          .thenAnswer((_) async => const []);

      await tester.enterText(searchField, 'random text');
      await tester.pump();

      final clearButton = find.byKey(const Key('clearButton'));
      expect(clearButton, findsOneWidget);
      await tester.tap(clearButton);
      await tester.pump();

      expect(find.text('random text'), findsNothing);
      expect(find.text('ไม่พบคำที่คุณค้นหา'), findsNothing);
    });

    testWidgets('Go to district select when tap', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ProvinceScreen(mockRepository),
      ));

      await tester.pumpAndSettle();

      final provinceButton = find.text('กรุงเทพมหานคร');
      expect(provinceButton, findsOneWidget);
      await tester.tap(provinceButton);
      await tester.pumpAndSettle();

      expect(find.text('Select District'), findsOneWidget);
    });
  });
}
