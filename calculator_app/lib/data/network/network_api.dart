import 'dart:convert';
import 'dart:io';

import 'package:calculator_app/data/network/base_api.dart';
import 'package:calculator_app/data/response/app_exception.dart';
import 'package:http/http.dart';

class NetworkApi extends BaseApiService {
  @override
  Future getApi(String url) async {
    dynamic responseJson;
    try {
      final response =
          await get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = ReturnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return responseJson;
  }

  @override
  Future postApi(String url, body) async {
    dynamic responseJson;
    try {
      final response = await post(Uri.parse(url), body: body)
          .timeout(const Duration(seconds: 10));
      responseJson = ReturnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return responseJson;
  }
}

dynamic ReturnResponse(Response response) {
  switch (response.statusCode) {
    case (200):
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;

    case 400:
      throw BadRequestException(response.body.toString());
    case 500:
      throw BadRequestException(response.body.toString());
    case 404:
      throw UnauthorizedException(response.body.toString());
    default:
      throw FetchDataException(
          'Error occured while communicate with serverwith status code${response.statusCode}');
  }
}
