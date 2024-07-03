import 'package:easypack/providers/trip_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WebSocketInitializer extends StatefulWidget {
  final Widget child;

  const WebSocketInitializer({super.key, required this.child});

  @override
  _WebSocketInitializerState createState() => _WebSocketInitializerState();
}

class _WebSocketInitializerState extends State<WebSocketInitializer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TripDetailsProvider>(context, listen: false).connectToWebSocket();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
