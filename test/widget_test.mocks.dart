// Mocks generated by Mockito 5.4.1 from annotations
// in assignment_address_form/test/widget_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:assignment_address_form/model/district.dart' as _i6;
import 'package:assignment_address_form/model/province.dart' as _i5;
import 'package:assignment_address_form/model/subdistrict.dart' as _i7;
import 'package:assignment_address_form/repository/address_data_repository.dart'
    as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AddressDataRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddressDataRepository extends _i1.Mock
    implements _i3.AddressDataRepository {
  MockAddressDataRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get httpClient => (super.noSuchMethod(
        Invocation.getter(#httpClient),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#httpClient),
        ),
      ) as _i2.Client);
  @override
  _i4.Future<List<_i5.Province>> searchProvinces(String? searchWord) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchProvinces,
          [searchWord],
        ),
        returnValue: _i4.Future<List<_i5.Province>>.value(<_i5.Province>[]),
      ) as _i4.Future<List<_i5.Province>>);
  @override
  _i4.Future<List<_i6.District>> searchDistricts(
    String? searchWord,
    int? provinceId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchDistricts,
          [
            searchWord,
            provinceId,
          ],
        ),
        returnValue: _i4.Future<List<_i6.District>>.value(<_i6.District>[]),
      ) as _i4.Future<List<_i6.District>>);
  @override
  _i4.Future<List<_i7.Subdistrict>> searchSubdistricts(
    String? searchWord,
    int? districtId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchSubdistricts,
          [
            searchWord,
            districtId,
          ],
        ),
        returnValue:
            _i4.Future<List<_i7.Subdistrict>>.value(<_i7.Subdistrict>[]),
      ) as _i4.Future<List<_i7.Subdistrict>>);
}
