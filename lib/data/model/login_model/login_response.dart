/// status : 200
/// msg : "Login Successful"
/// enterprise_id : 80
/// img : "Enterprise_logo/download_PeVTpVu.jpg"
/// email : "nakorex937@exoacre.com"
/// username : "Aryan Man"

class Login_response {
  Login_response({
      int? status, 
      String? msg}){
    _status = status;
    _msg = msg;
}

  Login_response.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
  }
  int? _status;
  String? _msg;

  int? get status => _status;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    return map;
  }

}