class VerifyOtpResponse {
  VerifyOtpResponse({
      this.status, 
      this.profileExists, 
      this.jwt,});

  VerifyOtpResponse.fromJson(dynamic json) {
    status = json['status'];
    profileExists = json['profile_exists'];
    jwt = json['jwt'];
  }
  bool? status;
  bool? profileExists;
  String? jwt;
}