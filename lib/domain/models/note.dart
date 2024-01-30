class Note {

  int id;
  String name;
  int teacherId;
  String stage;
  String classroom;
  int quantity;
  double teacherRatio;
  int bookPrice;
  String termType;
  int active;
  String pdf;
  String createdAt;
  String updatedAt;

  Note(
      this.id,
      this.name,
      this.teacherId,
      this.stage,
      this.classroom,
      this.quantity,
      this.teacherRatio,
      this.bookPrice,
      this.termType,
      this.active,
      this.pdf,
      this.createdAt,
      this.updatedAt);

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      json['id'] as int? ?? 0,
      json['name'] as String? ?? '',
      json['techer_id'] as int? ?? 0,
      json['stage'] as String? ?? '',
      json['classroom'] as String? ?? '',
      json['quantity'] as int? ?? 0,
      json['Teacher_ratio'] as double? ?? 0.0,
      json['book_price'] as int? ?? 0,
      json['term_type'] as String? ?? '',
      json['active'] as int? ?? 0,
      json['pdf'] as String? ?? '',
      json['created_at'] as String? ?? '',
      json['updated_at'] as String? ?? '',
    );
  }
}