import 'dart:typed_data';

class ConverterHelperUtils{

    Uint8List convertListintToUint8List(List<int> _data ){

    //if data null, return null
      if(_data == null){
        return null;
      }
      //Convert ListInt to byte
      Uint8List byte = Uint8List.fromList(_data);

      return byte;


   }



}