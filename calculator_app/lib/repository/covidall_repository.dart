import 'package:calculator_app/data/network/base_api.dart';
import 'package:calculator_app/data/network/network_api.dart';
import 'package:calculator_app/model/all.dart';
import 'package:calculator_app/resources/app_url.dart';

class CovidAllRepository {
  BaseApiService baseApiService = NetworkApi();

  Future<CovidAll> getData() async {
    try {
      dynamic response = await baseApiService.getApi(AppUrl.all);
      return CovidAll.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
