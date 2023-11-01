import 'package:calculator_app/data/response/status.dart';

class ApiResponse<T> {

  T? data;
  String? message;
  Status? status;
  
  ApiResponse.loading() : status = Status.Loading;
  ApiResponse.complete(this.data) : status = Status.Complete;
  ApiResponse.error(this.message) : status = Status.Error;

  @override
  String toString() {
    return "Status:$status\n Message:$message \n Data:$data";
  }


}
