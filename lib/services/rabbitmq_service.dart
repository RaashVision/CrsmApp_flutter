import 'dart:async';

import 'package:ESmile/interfaces/i_messagebroker.dart';
import 'package:ESmile/locator.dart';
import 'package:ESmile/managers/stream_manager.dart';
import 'package:dart_amqp/dart_amqp.dart';

class RabbitMQService implements IMessageBroker{

  Client client;
  Channel channel;
  Queue queue;
  Consumer consumer;
  StreamManager streamManager = locator<StreamManager>();

//This to setup the rabbmq
  void initSetup(String que_username) async{


    ConnectionSettings settings = new ConnectionSettings(
      host : "192.168.0.21",
      port:5672,
      maxConnectionAttempts: 10,
      authProvider : new PlainAuthenticator("raash", "iloveu96")
  );

    //Setup the init value of rabbit mq
     print("RabbitMQ init starts");
     client = Client(settings: settings);
     channel = await client.channel();
     queue = await channel.queue(que_username,durable: true);
    // consumer = await queue.consume();
     print("RabbitMQ init ends");

      //Start listening to publisher
     print("RabbitMQ Consumer start listeing");
    //  consumer.listen((message) {
        
    //     //Emit to listener
    //  //   streamManager.receivedMessageFromMBroker().add(message);

    //   });
  }

  

  @override
  StreamController receivedMessage() {

    return streamManager.receivedMessageFromMBroker();
    
  }

  @override
  void receivedMessageTLS() {
    // TODO: implement receivedMessageTLS
  }

  @override
  void sendMessage(message) {

         queue.publish(message);
    //  queue.publish(message);
  }

  @override
  void sendMessageTLS(message) {
    // TODO: implement sendMessageTLS
  }

}