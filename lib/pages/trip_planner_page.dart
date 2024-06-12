import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({super.key});

  @override
  _TripPlannerPageState createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  final TextEditingController _destinationController = TextEditingController();
  DateTime _departureDate = DateTime.now();
  DateTime _returnDate = DateTime.now().add(const Duration(days: 1));
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDeparture ? _departureDate : _returnDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: 'Destination',
                hintText: 'Enter your travel destination',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text('Departure Date: ${_dateFormat.format(_departureDate)}'),
              onTap: () => _selectDate(context, true),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text('Return Date: ${_dateFormat.format(_returnDate)}'),
              onTap: () => _selectDate(context, false),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add action to save or process the trip data
                  print('Destination: ${_destinationController.text}');
                  print('Departure Date: ${_dateFormat.format(_departureDate)}');
                  print('Return Date: ${_dateFormat.format(_returnDate)}');
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Trip'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
