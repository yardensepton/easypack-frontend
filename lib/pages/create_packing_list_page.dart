import 'package:easypack/widgets/packing_list_stepper.dart';
import 'package:flutter/material.dart';

class CreatePackingListPage extends StatefulWidget {
  final String tripTitle;
  final String tripId;

  const CreatePackingListPage({super.key, required this.tripTitle, required this.tripId});

  @override
  _CreatePackingListPageState createState() => _CreatePackingListPageState();
}

class _CreatePackingListPageState extends State<CreatePackingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFdfbfbfb),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('New Packing List'),
        centerTitle: true,
      ),
      body:  Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: PackingListStepper(tripId: widget.tripId),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

