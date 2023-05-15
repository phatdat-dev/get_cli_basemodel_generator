// ignore_for_file: camel_case_types

import '../../interface/sample_interface.dart';

class Wwww3qDatz_users_model_Sample extends Sample {
  Wwww3qDatz_users_model_Sample() : super('lib/app/models/users_model.dart', overwrite: true);

  @override
  String get content =>
      '''
import '../core/base/base_model.dart';

class UsersModel extends BaseModel<UsersModel> with BaseSelectedModel {
  int? id;
  String? username;
  String? email;
  String? password;
  String? avatar;
  String? token;

  UsersModel({
    this.id,
    this.username,
    this.email,
    this.password,
    this.avatar,
    this.token,
  });

  @override
  UsersModel fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
      token: token ?? json['token'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (username != null) {
      data['username'] = username;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (password != null) {
      data['password'] = password;
    }
    if (avatar != null) {
      data['avatar'] = avatar;
    }

    if (token != null) {
      data['token'] = token;
    }

    return data;
  }

  UsersModel copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? avatar,
    String? token,
  }) =>
      UsersModel(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        avatar: avatar ?? this.avatar,
        token: token ?? this.token,
      );
}
''';
}
