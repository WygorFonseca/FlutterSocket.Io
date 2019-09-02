library flutter_socket_io;

import 'dart:io';
import 'dart:async';
import 'package:flutter_socket_io/parser.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

/// Socket Instance
class SocketIo{
  SocketIoParser socketDataParser = new SocketIoParser();

  WebSocket socket;

  //final myStream = numberCreator().listen(onData)

  /// Initialize socket connection 
  /// * hostaname without prefix 
  /// * example: 127.0.0.1
  /// * don't use http://locahost or ws://127.0.0.1, etc...
  /// * port 3000
  /// * the default [port] is 3000
  connect({String hostname, int port = 3000}) async{

    return proccessConnection(hostname, port);

  }

  proccessConnection(String hostname, int port) async{

    socket = await WebSocket.connect('ws://$hostname:$port/socket.io/?EIO=3&transport=websocket');

    socket.listen((data){
    })
    .onData((data) => receivedData(data));

  }

  void receivedData(data){
    List<dynamic> parsed = socketDataParser.json(data);

    print(parsed);
  }

  final StreamController myStream = StreamController(
    onListen: (){
      print('startListen');
    }
  );

  nts() async{
    await Future.delayed(Duration(seconds: 3));

    myStream.stream.listen((data){
      print('Stream data $data');
    });

    await Future.delayed(Duration(seconds: 3));

    myStream.add([]);
  }

  on(event, void onData(event)) async{

  }

  emit(event, List<dynamic> data){

  }
}