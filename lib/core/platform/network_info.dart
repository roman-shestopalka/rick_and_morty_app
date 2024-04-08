import 'package:internet_connection_checker/internet_connection_checker.dart';

//реалізація перевірки зʼєднання пристрою з інтернетом за допомогою пакету "internet_connection_checker"

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
