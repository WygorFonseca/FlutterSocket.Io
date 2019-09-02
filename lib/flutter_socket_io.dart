library flutter_socket_io;

import 'dart:io';
import 'dart:async';
import 'package:flutter_socket_io/parser.dart';

/// Socket Instance
class SocketIo{
  SocketIoParser socketParser = new SocketIoParser();

  WebSocket socket;

  ///
  /// Initialize socket connection 
  /// * hostaname without prefix 
  /// * example: 127.0.0.1
  /// * don't use http://locahost or ws://127.0.0.1, etc...
  /// * port 3000
  /// * the default [port] is 3000
  /// 
  connect({String hostname, int port = 3000}) async{

    socket = await WebSocket.connect('ws://$hostname:$port/socket.io/?EIO=3&transport=websocket');

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

  void emit(event, List<dynamic> data){

  }

  void close(){
    socketStream.close();
  }
}