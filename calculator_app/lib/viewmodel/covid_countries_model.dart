import 'package:calculator_app/data/response/api_response.dart';
import 'package:calculator_app/model/countries.dart';

import 'package:calculator_app/repository/covidcountries-repository.dart';
import 'package:flutter/foundation.dart';

class CovidCountriesViewModel with ChangeNotifier {
  final _covidRepo = CovidCountriesRepository();
  ApiResponse<List<CovidCountries>> apiResponse = ApiResponse.loading();

  setApiResponse(ApiResponse<List<CovidCountries>> apiResponse) {
    this.apiResponse = apiResponse;
    notifyListeners();
  }


  Future<void> getDataCountries() async {
    setApiResponse(ApiResponse.loading());
    _covidRepo.getDataCountries().then((value) {
      setApiResponse(ApiResponse.complete(value));
   
    }).onError(
      (error, stackTrace) {
        if (kDebugMode) {
        print(error.toString());
      }
        setApiResponse(ApiResponse.error(error.toString()));
      },
    );
  }
}
