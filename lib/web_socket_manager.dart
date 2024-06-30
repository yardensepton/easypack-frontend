import 'package:web_socket_channel/io.dart';

class WebsocketManager {
  static final WebsocketManager _webSocketService =
      WebsocketManager._internal();
  factory WebsocketManager() {
    return _webSocketService;
  }
  WebsocketManager._internal();

  IOWebSocketChannel? channel;
  // DUMMY URL; DO NOT TRY TO IMPLEMENT
  String websocketUrl = 'ws://test.example.com?token=eySjks7sadjklwaskfjtAw8sS';

  void init() {
    // INITIATE A CONNECTION THROUGH AN IOWebsocketChannel channel
    channel = IOWebSocketChannel.connect(websocketUrl);
    if (channel != null) {
      // IF CHANNEL IS INITIALIZED AND WEBSOCKET IS CONNECTED
      // LISTEN TO WEBSOCKET EVENTS
      channel!.stream.listen(_eventListener).onDone(_reconnect);
    }
  }

  void transmit(dynamic data) {
    // THIS METHOD CAN BE CALLED ANYWHERE THROUGHOUT THE APP
    // AND CAN BE USED TO SEND DATA FROM THE CLIENT TO THE SERVER
    // VIA THE WEBSOCKET
    if (channel != null) {
      channel!.sink.add(data);
    }
  }

  void _eventListener(dynamic event) {
    if (event == 'message') {
      // PERFORM OPERATIONS ON THE EVENT PAYLOAD
    }
  }

  void _reconnect() {
    // IF CONTROL HAS TRANSFERRED TO THIS FUNCTION, IT MEANS
    // THAT THE WEBSOCKET HAS DISCONNECTED.
    if (channel != null) {
      // CLOSE THE PREVIOUS WEBSOCKET CHANNEL AND ATTEMPT A RECONNECTION
      channel!.sink.close();
      init();
    }
  }
}