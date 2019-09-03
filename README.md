[![Build Status](https://travis-ci.org/dart-lang/http.svg?branch=master)](https://travis-ci.org/dart-lang/http)

# flutter_socket_io

Esta biblioteca foi desenvolvida para ser usada na comunicação com [Socket.Io][]

[Socket.Io]: https://socket.io/

## Como usar

`connect({ hostname, port })`
* hostname (String) não deve conter protocolo (http, https, ws, etc..)
* port (Int), por padrão é 3000

```dart
import 'package:flutter_socket_io/flutter_socket_io.dart';

final socket = new SocketIo();

socket.connect(
  hostname: "127.0.0.1",
  port: 3000 // Default port is 3000
);

// Escuta eventos no socket
socket.on('eventp', (data){
  print(data);
});

// Envia evento para o servidor
socket.emit('nomeDoEvento', [{ 'nome': 'Joãozinho' }]);
```