class Request {
  String requestId;
  String type;
  String amount;
  String recipet; // image
  String state;
  String date;
  String divided;
  String memo;
  List<Members> members;

  Request(this.requestId, this.type, this.amount, this.recipet, this.state,
      this.date, this.divided, this.memo, this.members);
}

class Members {
  String userId;
  String accountId;
  String requestId;
  String valid;
  String name;
  String amount;

  Members(this.userId, this.accountId, this.requestId, this.valid, this.name,
      this.amount);
}
