class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? roles;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.roles,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    roles = json['roles'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'roles': roles,
      'token': token,
    };
  }
}
