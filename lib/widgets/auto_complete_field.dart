import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:easypack/providers/auto_complete_provider.dart';
import 'package:easypack/utils/validators.dart';
import 'package:easypack/widgets/city_list_item.dart';

class AutoCompleteField extends StatelessWidget {
  const AutoCompleteField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AutoCompleteProvider>(
      builder: (context, autoCompleteProvider, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: autoCompleteProvider.searchController,
                onChanged: autoCompleteProvider.onSearchChanged,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Residence',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(LineIcons.city),
                ),
                validator: (value) =>
                    Validators.validateNotEmpty(value, 'Residence'),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              constraints:
                  const BoxConstraints(maxHeight: 200.0), // Limit the height
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: autoCompleteProvider.autocompleteResults.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CityListItem(
                      cityName: autoCompleteProvider.autocompleteResults[index].text,
                      placeId: autoCompleteProvider.autocompleteResults[index].placeId,
                      onTap: (placeId) {
                        autoCompleteProvider.searchController.text =
                            autoCompleteProvider.autocompleteResults[index].text;
                        autoCompleteProvider.selectedCity =
                            autoCompleteProvider.autocompleteResults[index];
                        autoCompleteProvider.fetchAndShowPhoto(context, placeId);
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
