class Error2Dao {
  Error error;
  int code;

  Error2Dao({this.error, this.code});

  Error2Dao.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Error {
  List<String> password;

  Error({this.password});

  Error.fromJson(Map<String, dynamic> json) {
    password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    return data;
  }
}
