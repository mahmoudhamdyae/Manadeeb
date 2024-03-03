class NotesResponse {
  int? status;
  List<NamdubStore>? namdubStore;

  NotesResponse({this.status, this.namdubStore});

  NotesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['namdubStore'] != null) {
      namdubStore = <NamdubStore>[];
      json['namdubStore'].forEach((v) {
        namdubStore!.add(NamdubStore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (namdubStore != null) {
      data['namdubStore'] = namdubStore!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NamdubStore {
  int? id;
  String? name;
  String? phone;
  dynamic email;
  String? gender;
  dynamic grade;
  dynamic group;
  dynamic studentSubscrip;
  dynamic renew;
  String? userType;
  dynamic emailVerifiedAt;
  dynamic teacherRatioCourse;
  String? userPassword;
  String? createdAt;
  String? updatedAt;
  dynamic teacherDescription;
  String? fcmToken;
  dynamic image;
  List<MandubBooks>? mandubBooks;

  NamdubStore(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.gender,
        this.grade,
        this.group,
        this.studentSubscrip,
        this.renew,
        this.userType,
        this.emailVerifiedAt,
        this.teacherRatioCourse,
        this.userPassword,
        this.createdAt,
        this.updatedAt,
        this.teacherDescription,
        this.fcmToken,
        this.image,
        this.mandubBooks});

  NamdubStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    grade = json['grade'];
    group = json['group'];
    studentSubscrip = json['student_subscrip'];
    renew = json['renew'];
    userType = json['user_type'];
    emailVerifiedAt = json['email_verified_at'];
    teacherRatioCourse = json['Teacher_ratio_course'];
    userPassword = json['user_password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacherDescription = json['teacher_description'];
    fcmToken = json['fcm_token'];
    image = json['image'];
    if (json['mandub_books'] != null) {
      mandubBooks = <MandubBooks>[];
      json['mandub_books'].forEach((v) {
        mandubBooks!.add(MandubBooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['gender'] = gender;
    data['grade'] = grade;
    data['group'] = group;
    data['student_subscrip'] = studentSubscrip;
    data['renew'] = renew;
    data['user_type'] = userType;
    data['email_verified_at'] = emailVerifiedAt;
    data['Teacher_ratio_course'] = teacherRatioCourse;
    data['user_password'] = userPassword;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['teacher_description'] = teacherDescription;
    data['fcm_token'] = fcmToken;
    data['image'] = image;
    if (mandubBooks != null) {
      data['mandub_books'] = mandubBooks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MandubBooks {
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

  MandubBooks(
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

  MandubBooks.fromJson(Map<String, dynamic> json) {
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
  int? mandubId;
  int? bookId;
  int? mandubQuantity;
  int? minimum;
  int? station;
  int? distributorActive;
  int? mandubActive;
  int? mandubTarget;
  int? oldStation;
  String? createdAt;
  String? updatedAt;

  Pivot(
      {this.mandubId,
        this.bookId,
        this.mandubQuantity,
        this.minimum,
        this.station,
        this.distributorActive,
        this.mandubActive,
        this.mandubTarget,
        this.oldStation,
        this.createdAt,
        this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    mandubId = json['mandub_id'];
    bookId = json['book_id'];
    mandubQuantity = json['mandub_quantity'];
    minimum = json['minimum'];
    station = json['station'];
    distributorActive = json['distributor_active'];
    mandubActive = json['mandub_active'];
    mandubTarget = json['mandub_target'];
    oldStation = json['old_station'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mandub_id'] = mandubId;
    data['book_id'] = bookId;
    data['mandub_quantity'] = mandubQuantity;
    data['minimum'] = minimum;
    data['station'] = station;
    data['distributor_active'] = distributorActive;
    data['mandub_active'] = mandubActive;
    data['mandub_target'] = mandubTarget;
    data['old_station'] = oldStation;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}