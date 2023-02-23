class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  late String _host;
  String get host => _host;
  late int _port;
  int get port => _port;

  void init({required String host, required int port}) {
    _host = host;
    _port = port;
  }
}
