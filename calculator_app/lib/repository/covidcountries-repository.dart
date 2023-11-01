import 'package:calculator_app/data/network/base_api.dart';
import 'package:calculator_app/data/network/network_api.dart';
import 'package:calculator_app/model/countries.dart';
import 'package:calculator_app/resources/app_url.dart';

class CovidCountriesRepository {
  BaseApiService baseApiService = NetworkApi();

  Future<List<CovidCountries>> getDataCountries() async {
    try {
      dynamic response = await baseApiService.getApi(AppUrl.countries);
      final data = response as List;
      return data.map((dynamic e) => CovidCountries.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
