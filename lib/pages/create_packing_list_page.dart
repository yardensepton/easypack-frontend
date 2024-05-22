import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePackingListPage extends StatefulWidget {
  final String destination = 'Paris';
  final DateTime departureDate = DateTime(2023, 5, 1);
  final DateTime returnDate = DateTime(2023, 5, 7);

  CreatePackingListPage({super.key});

  @override
  _CreatePackingListPageState createState() => _CreatePackingListPageState();
}

class _CreatePackingListPageState extends State<CreatePackingListPage> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Business Trip', 'icon': Icons.business_center, 'selected': false},
    {'name': 'Ski Trip', 'icon': Icons.ac_unit, 'selected': false},
    {'name': 'Baby Trip', 'icon': Icons.child_friendly, 'selected': false},
    {'name': 'Car Trip', 'icon': Icons.directions_car, 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip to ${widget.destination}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'From: ${dateFormat.format(widget.departureDate)} - To: ${dateFormat.format(widget.returnDate)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        category['selected'] = !category['selected'];
                      });
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'],
                            size: 60,
                            color: category['selected']
                                ? Colors.teal
                                : Colors.grey,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            category['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: category['selected']
                                  ? Colors.teal
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle save action
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
