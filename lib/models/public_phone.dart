class PublicPhone {
  int id;
  String title;
  String phone;
  
  PublicPhone({required this.id, required this.title, required this.phone});

  
  factory PublicPhone.fromJson(Map<String, dynamic> json) {
    return PublicPhone(
      id: json['public_phone_id'],
      title: json['title'],
      phone: json['phone'],
    );
  }
}