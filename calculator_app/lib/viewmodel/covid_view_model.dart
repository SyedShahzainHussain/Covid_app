import 'package:calculator_app/data/response/api_response.dart';
import 'package:calculator_app/model/all.dart';
import 'package:calculator_app/repository/covidall_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CovidViewModel with ChangeNotifier {
  final _covidRepo = CovidAllRepository();
  ApiResponse<CovidAll> apiResponse = ApiResponse.loading();

  setApiResponse(ApiResponse<CovidAll> apiResponse) {
    this.apiResponse = apiResponse;
    notifyListeners();
  }

  Future<void> getData() async {
    setApiResponse(ApiResponse.loading());
    _covidRepo.getData().then((value) {
      setApiResponse(ApiResponse.complete(value));
      if (kDebugMode) {
        print(value.active);
      }
    }).onError(
      (error, stackTrace) {
        setApiResponse(ApiResponse.error(error.toString()));
      },
    );
  }
  
}
