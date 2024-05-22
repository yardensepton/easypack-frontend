import 'package:flutter/material.dart';


class PackingListPage extends StatefulWidget {
  const PackingListPage({super.key});

  @override
  _PackingListPageState createState() => _PackingListPageState();
}

class _PackingListPageState extends State<PackingListPage> {
  final Map<String, IconData> categoryIcons = {
    'Accessories': Icons.watch,
    'Clothing': Icons.checkroom,
    'Electronics': Icons.electrical_services,
  };

  final Map<String, List<Map<String, dynamic>>> packingList = {
    'Accessories': [
      {'name': 'Watch', 'quantity': 1},
      {'name': 'Sunglasses', 'quantity': 2},
      {'name': 'Hat', 'quantity': 1},
    ],
    'Clothing': [
      {'name': 'T-Shirts', 'quantity': 5},
      {'name': 'Jeans', 'quantity': 2},
      {'name': 'Jacket', 'quantity': 1},
    ],
    'Electronics': [
      {'name': 'Phone Charger', 'quantity': 1},
      {'name': 'Camera', 'quantity': 1},
      {'name': 'Laptop', 'quantity': 1},
    ],
  };

  void _editItem(String category, int index) {
    TextEditingController controller = TextEditingController(
      text: packingList[category]![index]['quantity'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Quantity'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Quantity'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                packingList[category]![index]['quantity'] =
                    int.parse(controller.text);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteItem(String category, int index) {
    setState(() {
      packingList[category]!.removeAt(index);
    });
  }

  void _addItem() {
    String? selectedCategory;
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Category'),
              items: categoryIcons.keys.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                selectedCategory = value;
              },
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (selectedCategory != null &&
                  nameController.text.isNotEmpty &&
                  quantityController.text.isNotEmpty) {
                setState(() {
                  packingList[selectedCategory]!.add({
                    'name': nameController.text,
                    'quantity': int.parse(quantityController.text),
                  });
                });
                Navigator.of(context).pop(); // Close the dialog after saving
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paris Packing List'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: packingList.keys.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpansionTile(
                leading: Icon(categoryIcons[category], color: Colors.teal),
                title: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: packingList[category]!
                    .asMap()
                    .entries
                    .map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> item = entry.value;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(item['name']),
                            trailing: Text('Quantity: ${item['quantity']}'),
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.edit),
                                      title: const Text('Edit Quantity'),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        _editItem(category, index);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.delete),
                                      title: const Text('Delete'),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        _deleteItem(category, index);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    })
                    .toList()
                    .cast<Widget>(),
              ),
            ),
          );
        }).toList()
          ..add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}