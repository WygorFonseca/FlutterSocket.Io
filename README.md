[![Build Status](https://travis-ci.org/dart-lang/http.svg?branch=master)](https://travis-ci.org/dart-lang/http)

# flutter_socket_io

Esta biblioteca foi desenvolvida para ser usada na comunicação com [Socket.Io][]

[Socket.Io]: https://socket.io/

## Como usar

`SocketIo(hostname, port)`

Cria um novo gerenciador para o `hostname` especificado

* hostname (String) não deve conter protocolo (http, https, ws, etc..)
* port (Int), por padrão é 3000

> **Nota:** Ainda não é possível fazer conexões usando SSL.
> **Nota:** Se você estiver emulando o app em um dispositivo real e o servidor estiver hospedado localmente. localhost ou 127.0.0.1 não irá funcionar. Você deverá utilizar o endereço IPV4 do servidor.

```dart
import 'package:flutter_socket_io/flutter_socket_io.dart';

final socket = new SocketIo("127.0.0.1", 3000);

// Escuta eventos no socket
socket.on('evento', (data){
  print(data);
});

// Envia evento para o servidor
socket.emit('nomeDoEvento', [{ 'nome': 'Joãozinho' }]);
```

---

`socket.on(nomeDoEvento, callback)`

Registra um novo gerenciador para o evento.

* nomeDoEvento (String)
* callback Function
* **Returns** List<dynamic>

---

`socket.emit(nomeDoEvento, args)`

Emite um evento para o socket identificado por uma String `nomeDoEvento`.
Os argumentos `args` devem ser do tipo List<dynamic>

```dart
socket.emit('nomeDoEvento', { 'nome': 'Wygor' });

socket.emit('nomeDoEvento', [{ 'nome': 'Wygor', 'idade': 19 }]);

socket.emit('nomeDoEvento', [{ 'nome': 'Wygor', 'idade': 19 }, { 'nome': 'Joãozinho', 'idade': null }]);
```