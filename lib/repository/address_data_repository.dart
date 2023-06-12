import 'dart:convert';
import 'package:assignment_address_form/model/district.dart';
import 'package:assignment_address_form/model/subdistrict.dart';
import 'package:http/http.dart' as http;
import 'package:assignment_address_form/model/province.dart';

class AddressDataRepository {
  final http.Client httpClient;

  AddressDataRepository({required this.httpClient});

  Future<List<Province>> searchProvinces(String searchWord) async {
    const String url =
        'https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_province.json';
    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load');
    }

    final List rawData = jsonDecode(response.body);
    return rawData
        .map<Province>((e) => Province.fromJson(e))
        .where((element) => element.name_th.contains(searchWord))
        .toList();
  }

  Future<List<District>> searchDistricts(String searchWord, int provinceId) async {
    const String url =
          'https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_amphure.json';
      final response = await httpClient.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to load');
      }

      final List rawData = jsonDecode(response.body);
      return rawData
          .map((e) => District.fromJson(e))
          .where((element) =>
              element.province_id == provinceId &&
              element.name_th.contains(searchWord))
          .toList();
  }

  Future<List<Subdistrict>> searchSubdistricts(String searchWord, int districtId) async {
    const String url =
          'https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_tambon.json';
      final response = await httpClient.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception('Failed to load');
      }

      final List rawData = jsonDecode(response.body);
      return rawData
          .map((e) => Subdistrict.fromJson(e))
          .where((element) =>
              element.amphure_id == districtId &&
              element.name_th.contains(searchWord))
          .toList();
  }
}