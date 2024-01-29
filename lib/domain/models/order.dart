class Order {
  int? id;
  String? buyer;
  String? phone;
  String? address;
  String? status;
  int? cityId;
  int? mandubId;
  String? priceAll;
  String? createdAt;
  String? updatedAt;

  Order(
      {this.id,
        this.buyer,
        this.phone,
        this.address,
        this.status,
        this.cityId,
        this.mandubId,
        this.priceAll,
        this.createdAt,
        this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buyer = json['buyer'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    cityId = json['city_id'];
    mandubId = json['mandub_id'];
    priceAll = json['price_all'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['buyer'] = buyer;
    data['phone'] = phone;
    data['address'] = address;
    data['status'] = status;
    data['city_id'] = cityId;
    data['mandub_id'] = mandubId;
    data['price_all'] = priceAll;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}