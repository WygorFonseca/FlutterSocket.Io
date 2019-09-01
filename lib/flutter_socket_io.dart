library flutter_socket_io;

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

/// Socket Instance
class SocketIo {
  /// Initialize socket connection
  List<dynamic> connect(String hostname, int port) {
    return [hostname, port];
  }
}