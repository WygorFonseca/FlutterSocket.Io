library flutter_socket_io;

import 'dart:io';
import 'dart:async';
import 'package:flutter_socket_io/parser.dart';

import 'dart:convert';

/// Socket Instance
class SocketIo{
  String hostname;
  int port = 3000;
  Duration timeLimit = Duration(seconds: 30);

  SocketIoParser socketParser = new SocketIoParser();

  WebSocket socket;

  SocketIo(this.hostname, this.port){
    connect(this.hostname, this.port, this.timeLimit);
  }

  ///
  /// Initialize socket connection 
  /// * hostaname without prefix 
  /// * example: 127.0.0.1
  /// * don't use http://locahost or ws://127.0.0.1, etc...
  /// * port 3000
  /// * the default [port] is 3000
  /// 
  connect(String hostname, int port, Duration timeLimit) async{

    socket = await WebSocket.connect('ws://$hostname:$port/socket.io/?EIO=3&transport=websocket')
    .timeout(timeLimit)
    .catchError((error){
      print('Conexão com o websocket falhou! Verifique os parâmetros e tente novamente');
    });

    socket.listen(null).onData((data) => socketReceivedData(data));

  }

  final StreamController<List<dynamic>> socketStream = StreamController.broadcast();

  void socketReceivedData(String data){
    // Parse received data String to json
    List<dynamic> parsed = socketParser.json(data);

    // Add data to stream
    socketStream.add(parsed);
  }

  void on(listeningEvent, void onData(List<dynamic> data)) async{
    socketStream.stream.listen((data){
      String eventName = data[0].toString();
      
      if(eventName == listeningEvent){
        data.remove(eventName);

        onData(data);
      }
    });
  }

  void emit(String eventName, dynamic data) async{
    String parsed = socketParser.eventEmitParse(eventName, data);

    await Future.delayed(Duration(seconds: 5));
    socket.add(parsed);
  }

  void close(){
    socketStream.close();
  }
}