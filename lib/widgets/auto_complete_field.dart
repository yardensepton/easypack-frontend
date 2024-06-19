import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/utils/validators.dart';
import 'package:easypack/widgets/city_list_item.dart';

class AutoCompleteField extends StatelessWidget {
  // final ValueChanged<String> onCitySelected;

  const AutoCompleteField(
      {super.key}); // Modify constructor

  @override
  Widget build(BuildContext context) {
    return Consumer<AutoCompleteProvider>(
      builder: (context, autoCompleteProvider, child) {
        return Column(
          children: [
            SizedBox(
              child: TextFormField(
                controller: autoCompleteProvider.searchController,
                onChanged: autoCompleteProvider.onSearchChanged,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Residence',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 240, 232, 245),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(LineIcons.city),
                ),
                validator: (value) =>
                    Validators.validateNotEmpty(value, 'Residence'),
              ),
            ),
            Container(
              constraints:
                  const BoxConstraints(maxHeight: 400.0), // Limit the height
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: autoCompleteProvider.autocompleteResults.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: CityListItem(
                      cityName:
                          autoCompleteProvider.autocompleteResults[index].text,
                      placeId: autoCompleteProvider
                          .autocompleteResults[index].placeId,
                      onTap: (placeId) async {
                        autoCompleteProvider.searchController.text =
                            autoCompleteProvider
                                .autocompleteResults[index].text;
                        autoCompleteProvider.selectedCity =
                            autoCompleteProvider.autocompleteResults[index];
                        autoCompleteProvider.clearResults();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
