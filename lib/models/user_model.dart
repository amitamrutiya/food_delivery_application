class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel({
    required this.email,
    required this.name,
    required this.id,
    required this.phone,
    required this.orderCount,
  });

  factory UserModel.formJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['f_name'],
      email: json['email'],
      phone: json['phone'],
      orderCount: json['order_count'],
    );
  }
}
