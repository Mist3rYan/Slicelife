class UserModel{
  final String? email;
  final String? password;
  String? uid;

  UserModel({this.email, this.password, this.uid});
  set setUid(value) => uid = value;


  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'uid': uid,
  };
}