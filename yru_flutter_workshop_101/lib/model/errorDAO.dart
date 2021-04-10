class ErrorDAO {
  String error;
  int code;

  ErrorDAO({this.error, this.code});

  ErrorDAO.fromJson(Map<String, dynamic> json) {
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
