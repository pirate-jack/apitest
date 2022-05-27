class ResponseModel {
  String message;

  ResponseModel(this.message);

  ResponseModel.FromJason(Map<String, dynamic> map) {
    message = map['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map();
    map['message'] = this.message;
    return map;
  }
}
