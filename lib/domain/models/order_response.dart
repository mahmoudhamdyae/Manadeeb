class OrderResponse {
  int? status;
  List<City>? cities;
  List<Order>? orders;
  int? orderPrice;
  int? deliveryPrice;
  int? allPrice;

  OrderResponse({this.status, this.cities, this.orders, this.orderPrice, this.deliveryPrice, this.allPrice});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['cities'] != null) {
      cities = <City>[];
      json['cities'].forEach((v) {
        cities!.add(City.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
    orderPrice = json['orderPrice'];
    deliveryPrice = json['deliveryPrice'];
    allPrice = json['allPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
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

  City(
      {this.id, this.name, this.deliverPrice, this.createdAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deliverPrice = json['deliver_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  int? payType;
  int? payStatus;
  dynamic payId;
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
        this.payType,
        this.payStatus,
        this.payId,
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
    payType = json['pay_type'];
    payStatus = json['pay_status'];
    payId = json['pay_id'];
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
    data['pay_type'] = payType;
    data['pay_status'] = payStatus;
    data['pay_id'] = payId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}