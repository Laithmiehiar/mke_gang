import 'package:mke_gang/models/account.dart';

class UserModel {
  String userId;
  String name;
  String address;
  String phone;
  String dob;
  String email;
  String accountId;
  List<Account> accounts;

  UserModel(this.userId, this.name, this.address, this.phone, this.dob,
      this.email, this.accountId, this.accounts);

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['userId'],
      map['name'],
      map['address'],
      map['phone'],
      map['dob'],
      map['email'],
      map['accountId'],
      map['accounts'],
    );
  }
}
