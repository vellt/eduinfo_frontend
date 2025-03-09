class InstitutionCategory {
  int id;
  String category;
  
  InstitutionCategory({required this.id,required this.category});

  factory InstitutionCategory.fromJson(Map<String, dynamic> json) {
    return InstitutionCategory(
      id: json['category_id'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': id,
      'category': category,
    };
  }
}