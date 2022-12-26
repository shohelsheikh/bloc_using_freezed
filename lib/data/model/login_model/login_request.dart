/// email : "harsh07503@gmail.com"
/// password : "d1234567dddQw"

class LoginRequest {
  LoginRequest({
      String? email, 
      String? password,
        String? token,}){
    _email = email;
    _password = password;
    _token = token;
}

  LoginRequest.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
    _token= json['token'];
  }
  String? _email;
  String? _password;
  String? _token;


  set email(String value) {
    _email = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    map['token'] = _token;
    return map;
  }

  set password(String value) {
    _password = value;
  }
  set token(String value) {
    _token = value;
  }

  String get token => _token.toString();

  String get password => _password.toString();

  String get email => _email.toString();
}