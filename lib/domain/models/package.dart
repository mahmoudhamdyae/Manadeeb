class PackageResponse {
  int? status;
  List<Package>? packagedetails;

  PackageResponse({this.status, this.packagedetails});

  PackageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['packagedetails'] != null) {
      packagedetails = <Package>[];
      json['packagedetails'].forEach((v) {
        packagedetails!.add(Package.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (packagedetails != null) {
      data['packagedetails'] =
          packagedetails!.map((v) => v.toJson()).toList();
    }
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
  List<Book>? book;

  Package(
      {this.id,
        this.name,
        this.description,
        this.stage,
        this.class1,
        this.price,
        this.expiryDate,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.book});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    stage = json['stage'];
    class1 = json['class1'];
    price = json['price'];
    expiryDate = json['expiry_date'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['book'] != null) {
      book = <Book>[];
      json['book'].forEach((v) {
        book!.add(Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['stage'] = stage;
    data['class1'] = class1;
    data['price'] = price;
    data['expiry_date'] = expiryDate;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (book != null) {
      data['book'] = book!.map((v) => v.toJson()).toList();
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
  Pivot? pivot;

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
        this.updatedAt,
        this.pivot});

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
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
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
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? packageId;
  int? bookId;

  Pivot({this.packageId, this.bookId});

  Pivot.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    bookId = json['book_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_id'] = packageId;
    data['book_id'] = bookId;
    return data;
  }
}