import 'package:mke_gang/constants/enums.dart';

abstract class InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({required this.connectionType});
}

class InternetLoading extends InternetState {}

class InternetDisconnected extends InternetState {}
