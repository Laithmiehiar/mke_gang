class WalletModel {
  String name;
  String wallet;
  String walletLogo;
  String walletNumber;

  WalletModel(this.name, this.wallet, this.walletLogo, this.walletNumber);
}

List<WalletModel> wallets = walletData
    .map((item) => WalletModel(item['name'] as String, item['wallet'] as String,
        item['walletLogo'] as String, item['walletNumber'] as String))
    .toList();

var walletData = [
  {
    "name": "Jack",
    "wallet": "Gopay",
    "walletLogo": 'assets/images/gopay_logo.png',
    "walletNumber": '+62*** **** 1932'
  },
  {
    "name": "Jenny",
    "wallet": "Ovo",
    "walletLogo": 'assets/images/ovo_logo.png',
    "walletNumber": '+62*** **** 2245'
  },
  {
    "name": "Jenny",
    "wallet": "Gopay",
    "walletLogo": 'assets/images/gopay_logo.png',
    "walletNumber": '+62*** **** 2245'
  },
  {
    "name": "Donna",
    "wallet": "Dana",
    "walletLogo": 'assets/images/dana_logo.png',
    "walletNumber": '+62*** **** 1932'
  }
];
