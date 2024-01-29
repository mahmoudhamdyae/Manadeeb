class OrderDetailsResponse {
  int? status;
  List<Orderdetails>? orderdetails;

  OrderDetailsResponse({this.status, this.orderdetails});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orderdetails'] != null) {
      orderdetails = <Orderdetails>[];
      json['orderdetails'].forEach((v) {
        orderdetails!.add(Orderdetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (orderdetails != null) {
      data['orderdetails'] = orderdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orderdetails {
  int? id;
  String? sessionId;
  int? bookId;
  int? packageId;
  int? orderId;
  int? quantity;
  String? price;
  String? createdAt;
  String? updatedAt;
  Map<String, dynamic>? package;
  Book? book;

  Orderdetails(
      {this.id,
        this.sessionId,
        this.bookId,
        this.packageId,
        this.orderId,
        this.quantity,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.package,
        this.book});

  Orderdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    bookId = json['book_id'];
    packageId = json['package_id'];
    orderId = json['order_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    package = json['package'];
    book = json['book'] != null ? Book.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['session_id'] = sessionId;
    data['book_id'] = bookId;
    data['package_id'] = packageId;
    data['order_id'] = orderId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['package'] = package;
    if (book != null) {
      data['book'] = book!.toJson();
    }
    return data;
  }
}

class Book {
  int? id;
  String? name;
  int? techerId;
  String? stage;
  String? classroom;
  int? quantity;
  double? teacherRatio;
  int? bookPrice;
  String? termType;
  int? active;
  String? pdf;
  String? createdAt;
  String? updatedAt;

  Book(
      {this.id,
        this.name,
        this.techerId,
        this.stage,
        this.classroom,
        this.quantity,
        this.teacherRatio,
        this.bookPrice,
        this.termType,
        this.active,
        this.pdf,
        this.createdAt,
        this.updatedAt});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    techerId = json['techer_id'];
    stage = json['stage'];
    classroom = json['classroom'];
    quantity = json['quantity'];
    teacherRatio = json['Teacher_ratio'];
    bookPrice = json['book_price'];
    termType = json['term_type'];
    active = json['active'];
    pdf = json['pdf'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['techer_id'] = techerId;
    data['stage'] = stage;
    data['classroom'] = classroom;
    data['quantity'] = quantity;
    data['Teacher_ratio'] = teacherRatio;
    data['book_price'] = bookPrice;
    data['term_type'] = termType;
    data['active'] = active;
    data['pdf'] = pdf;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

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