import 'dart:convert';

import 'dart:convert' as prefix0;

const PACKET_CODES = {
  'CONNECTION': 0,
  'RECEIVED': 42
}; 

class SocketIoParser{
  int packetType(data){

    var buf = 0;
    var type = "";

    while (isNumeric(data[buf]) && buf != data.length - 1){

      type = type+data[buf];

      buf++;
    }

    var parsedType = int.tryParse(type);

    return parsedType == null ? 999 : parsedType;

  }

  List<dynamic> json(data){

    int packetType = this.packetType(data);

    String dataString = data.substring("$packetType".length);

    try {

      if(dataString.startsWith("{") || !dataString.startsWith('[')){
        return jsonDecode("[$dataString]");
      }

      return jsonDecode(dataString);

    } on FormatException catch (_) {
      return [{"error": 'FormatException'}];
    }
    
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }

    return double.tryParse(s) != null;
  }
}