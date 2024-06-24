import 'dart:async';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager {
  late WebSocketChannel _channel;
  late String _wsUrl;
  late Function(String) _onMessage;
  late Function(dynamic) _onError;
  late Function() _onDone;
  late bool _shouldReconnect;

  WebSocketManager({
    required String wsUrl,
    required Function(String) onMessage,
    required Function(dynamic) onError,
    required Function() onDone,
  }) {
    _wsUrl = wsUrl;
    _onMessage = onMessage;
    _onError = onError;
    _onDone = onDone;
    _shouldReconnect = true;

    _connect();
  }

  void _connect() {
    try {
      _channel = IOWebSocketChannel.connect(Uri.parse(_wsUrl));
      _channel.stream.listen(
        (message) {
          _onMessage(message);
        },
        onError: (error) {
          _onError(error);
          if (_shouldReconnect) {
            _reconnect();
          }
        },
        onDone: () {
          _onDone();
          if (_shouldReconnect) {
            _reconnect();
          }
        },
      );
    } catch (e) {
      _onError(e);
      if (_shouldReconnect) {
        _reconnect();
      }
    }
  }

  void _reconnect() {
    const int reconnectDelaySeconds = 5; // Adjust as needed
    Timer(const Duration(seconds: reconnectDelaySeconds), () {
      if (_shouldReconnect) {
        _connect();
      }
    });
  }

  void close() {
    _shouldReconnect = false;
    _channel.sink.close();
  }
}
