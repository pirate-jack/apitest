
class CarModel {
  List<CarResponseModel> data;

  CarModel(this.data);

  CarModel.fromJson(Map<String, dynamic> map) {
    data = [];
    if (map['data'] != null) {
      map['data'].forEach((v) {
        data.add(CarResponseModel.FromJason(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map();
    map['data'] = [];
    if (data != null) {
      map['data'] = data.map((e) => e.toJson()).toList();
    }
    return map;
  }
}


class CarResponseModel {
  String name;
  String description;
  String price;
  String image;

  CarResponseModel(this.name,this.description,this.price,this.image);

  CarResponseModel.FromJason(Map<String, dynamic> map) {
    name = map['name'];
    description = map['description'];
    price = map['price'];
    image = map['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map();
    map['name'] = this.name;
    map['description'] = this.description;
    map['price'] = this.price;
    map['image'] = this.image;
    return map;
  }
}
