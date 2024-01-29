class OrderResponse {
  int? status;
  City? city;
  List<Order>? orders;

  OrderResponse({this.status, this.city, this.orders});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;
  int? deliverPrice;
  String? createdAt;
  String? updatedAt;

  City({this.id, this.name, this.deliverPrice, this.createdAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deliverPrice = json['deliver_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['deliver_price'] = deliverPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

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
    final Map<String, dynamic> data = Map<String, dynamic>();
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