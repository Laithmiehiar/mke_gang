import 'package:mke_gang/models/request.dart';

class Account {
  String accountId;
  String balance;
  String owe;
  String limit;
  List<Request> requests;

  Account(this.accountId, this.balance, this.owe, this.limit, this.requests);
}
