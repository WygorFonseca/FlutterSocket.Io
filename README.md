[![Build Status](https://travis-ci.org/dart-lang/http.svg?branch=master)](https://travis-ci.org/dart-lang/http)

# flutter_socket_io

Esta biblioteca foi desenvolvida para ser usada na comunicação com [Socket.Io][]: https://socket.io/

## Como usar

```dart
import 'package:flutter_socket_io/flutter_socket_io.dart';

final socket = new SocketIo();

// Escuta eventos no socket
socket.on('nomeDoEvento', (data){
  print(data);
});

// Envia evento para o servidor
socket.emit('nomeDoEvento', [{ 'nome': 'Joãozinho' }]);

```