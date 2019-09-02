library flutter_socket_io;

import 'dart:io';
import 'dart:async';
import 'package:flutter_socket_io/parser.dart';

/// Socket Instance
class SocketIo{
  SocketIoParser socketParser = new SocketIoParser();

  WebSocket socket;

  //final myStream = numberCreator().listen(onData)

  /// Initialize socket connection 
  /// * hostaname without prefix 
  /// * example: 127.0.0.1
  /// * don't use http://locahost or ws://127.0.0.1, etc...
  /// * port 3000
  /// * the default [port] is 3000
  connect({String hostname, int port = 3000}) async{

    socket = await WebSocket.connect('ws://$hostname:$port/socket.io/?EIO=3&transport=websocket');

    socket.listen((data){}).onData((data) => receivedData(data));

  }

  final StreamController myStream = StreamController(
    onListen: (){
      print('startListen');
    }
  );

  void receivedData(data){
    List<dynamic> parsed = socketParser.json(data);

    myStream.add(parsed);
  }

  on(event, void onData(event)) async{
    myStream.stream.listen((data){
      print(data[0]);
    });
  }

  emit(event, List<dynamic> data){

  }

  close(){
    myStream.close();
  }
}