import 'dart:async';

abstract class IMessageBroker{

  void initSetup(String que_username);

  StreamController receivedMessage();

  void sendMessage(dynamic message);

  void receivedMessageTLS();

  void sendMessageTLS(dynamic message);

}