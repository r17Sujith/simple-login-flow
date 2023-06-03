class LoginResponse {
  LoginResponse({
      bool? status, 
      String? response, 
      String? requestId,}){
    _status = status;
    _response = response;
    _requestId = requestId;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json['status'];
    _response = json['response'];
    _requestId = json['request_id'];
  }
  bool? _status;
  String? _response;
  String? _requestId;

  bool? get status => _status;
  String? get response => _response;
  String? get requestId => _requestId;
}