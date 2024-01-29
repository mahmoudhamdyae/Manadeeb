class City {
  int? id;
  String? name;
  String? deliverPrice;

  City({
    this.id,
    this.name,
    this.deliverPrice,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deliverPrice = json['deliver_price'];
  }
}