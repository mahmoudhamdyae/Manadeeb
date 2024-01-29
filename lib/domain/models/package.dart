class Package {
  int? id;
  String? name;
  String? description;
  String? stage;

  String? class1;
  String? price;
  String? expiryDate;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Package({this.id, this.name, this.description, this.stage, this.class1, this.price, this.expiryDate, this.isActive, this.createdAt, this.updatedAt});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    stage = json['stage'];
    class1 = json['class'];
    price = json['price'];
    expiryDate = json['expiry_date'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['stage'] = stage;
    data['class'] = class1;
    data['price'] = price;
    data['expiry_date'] = expiryDate;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}