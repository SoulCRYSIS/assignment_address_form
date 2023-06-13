import 'package:assignment_address_form/model/district.dart';
import 'package:assignment_address_form/model/subdistrict.dart';
import 'package:http/http.dart' as http;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:assignment_address_form/model/province.dart';

class AddressDataRepository {
  final http.Client httpClient;

  AddressDataRepository({required this.httpClient});

  Future<List<Province>> searchProvinces(String searchWord) async {
    try {
      final HttpLink httpLink = HttpLink(
        "https://better-prong-railway.glitch.me/province",
      );
      final graphqlClient = GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      );

      final getAllProvinceQuery = searchWord.trim().isEmpty
          ? """
query {
	province{
		id
		name_th
		name_en
	}
}
"""
          : """
query {
	province(name: "$searchWord"){
		id
		name_th
		name_en
	}
}
""";

      QueryResult result = await graphqlClient
          .query(QueryOptions(document: gql(getAllProvinceQuery)));

      if (result.hasException) {
        throw result.exception.toString();
      }

      // print(result.data);
      List data = result.data!["province"];
      List<Province> provinces = [];

      data.forEach((e) {
        provinces.add(
          Province(
            int.parse(e["id"]),
            e['name_th'],
          ),
        );
      });
      return provinces;
    } catch (e) {
      throw Exception('Failed to load');
    }
  }

  Future<List<District>> searchDistricts(
      String searchWord, int provinceId) async {
    try {
      final HttpLink httpLink = HttpLink(
        "https://better-prong-railway.glitch.me/district",
      );
      final graphqlClient = GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      );

      final getAllDistrictsQuery = searchWord.trim().isEmpty
          ? """
query {
  district(province_id: "$provinceId") {
    id
    name_th
  }
}
"""
          : """
query {
	district(province_id: "$provinceId", name: "$searchWord"){
		id
		name_th
	}
}
""";

      QueryResult result = await graphqlClient
          .query(QueryOptions(document: gql(getAllDistrictsQuery)));

      if (result.hasException) {
        throw result.exception.toString();
      }

      // print(result.data);
      List data = result.data!["district"];
      List<District> districts = [];

      data.forEach((e) {
        districts.add(
          District(
            int.parse(e["id"]),
            provinceId,
            e['name_th'],
          ),
        );
      });
      return districts;
    } catch (e) {
      print(e);
      throw Exception('Failed to load');
    }
  }

  Future<List<Subdistrict>> searchSubdistricts(
      String searchWord, int districtId) async {
    try {
      final HttpLink httpLink = HttpLink(
        "https://better-prong-railway.glitch.me/subdistrict",
      );
      final graphqlClient = GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      );

      final getAllSubdistrictsQuery = """
query {
  subdistrict(amphure_id: "$districtId") {
    id
    name_th
  }
}
""";

      QueryResult result = await graphqlClient
          .query(QueryOptions(document: gql(getAllSubdistrictsQuery)));

      if (result.hasException) {
        throw result.exception.toString();
      }

      // print(result.data);
      List data = result.data!["subdistrict"];
      List<Subdistrict> subdistricts = [];

      data.forEach((e) {
        if (searchWord.trim().isNotEmpty) {
          if (e['name_th'].contains(searchWord)) {
            subdistricts.add(
              Subdistrict(
                int.parse(e["id"]),
                districtId,
                e['name_th'],
              ),
            );
          }
        } else {
          subdistricts.add(
            Subdistrict(
              int.parse(e["id"]),
              districtId,
              e['name_th'],
            ),
          );
        }
      });
      return subdistricts;
    } catch (e) {
      print(e);
      throw Exception('Failed to load');
    }
  }
}
