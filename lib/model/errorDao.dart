class ErrorDao {
  String error;
  int code;

  ErrorDao({this.error, this.code});

  ErrorDao.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['code'] = this.code;
    return data;
  }
}
