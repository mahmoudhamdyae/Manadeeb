class NotesAndPackages {
  int? status;
  List<Books>? books;
  List<Packages>? packages;

  NotesAndPackages({this.status, this.books, this.packages});

  NotesAndPackages.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) { books!.add(Books.fromJson(v)); });
    }
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) { packages!.add(Packages.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
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

  Books({this.id, this.name, this.techerId, this.stage, this.classroom, this.quantity, this.teacherRatio, this.bookPrice, this.termType, this.active, this.pdf, this.createdAt, this.updatedAt});

  Books.fromJson(Map<String, dynamic> json) {
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

class Packages {
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

  Packages({this.id, this.name, this.description, this.stage, this.class1, this.price, this.expiryDate, this.isActive, this.createdAt, this.updatedAt});

  Packages.fromJson(Map<String, dynamic> json) {
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