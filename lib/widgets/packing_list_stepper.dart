import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/providers/items_provider.dart';
import 'package:easypack/providers/packing_list_provider.dart';
import 'package:easypack/widgets/custom_choice_chip.dart';
import 'package:easypack/widgets/custom_icons_grid_view.dart';
import 'package:easypack/widgets/loading_packing_list.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/trip_type_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackingListStepper extends StatefulWidget {
  final String tripId;

  const PackingListStepper({super.key, required this.tripId});

  @override
  State<PackingListStepper> createState() => _PackingListStepperState();
}

class _PackingListStepperState extends State<PackingListStepper> {
  int currentStep = 0;
  late Future<void> _packingListCreation;

  @override
  void initState() {
    super.initState();
    _packingListCreation = Future.value();
    Provider.of<ItemsProvider>(context, listen: false).fetchStepperData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsProvider>(
      builder: (context, itemsProvider, child) {
        PackingListProvider packingListProvider =
            Provider.of<PackingListProvider>(context, listen: false);

        return Stack(
          children: [
            Stepper(
              controlsBuilder: (context, details) {
                return Row(
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          const Color.fromRGBO(26, 35, 126, 1),
                          
                        ),
                        foregroundColor: WidgetStatePropertyAll(
                           Colors.white
                
                        ),
                      ),
                      onPressed: details.onStepContinue,
                      child: const Text('NEXT'),
                    ),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('BACK'),
                    ),
                  ],
                );
              },
              steps: getSteps(itemsProvider, packingListProvider),
              type: StepperType.vertical,
              currentStep: currentStep,
              onStepContinue: () async {
                if (currentStep == 2) {
                  setState(() {
                    _packingListCreation = packingListProvider
                        .createPackingList(context, widget.tripId);
                  });
                }

                if (currentStep <
                    getSteps(itemsProvider, packingListProvider).length - 1) {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepCancel: () {
                if (currentStep > 0) {
                  setState(() {
                    currentStep -= 1;
                  });
                }
              },
              onStepTapped: (step) => setState(() => currentStep = step),
              connectorColor: WidgetStatePropertyAll(
                const Color.fromRGBO(26, 35, 126, 1),
              ),
            ),
            FutureBuilder<void>(
              future: _packingListCreation,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            color: Colors.white.withOpacity(0.80),
                            child: const Center(
                              child: LoadingPackingList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        );
      },
    );
  }

  List<Step> getSteps(
      ItemsProvider itemsProvider, PackingListProvider packingListProvider) {
    final specialItemsNames = itemsProvider.specialItemsNames ?? [];
    final activities = itemsProvider.activities ?? [];

    return [
      Step(
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Text('Trip Type'),
        content: TripTypeToggleButton(
          onChanged: (type) {
            packingListProvider.isWork = type == TripType.business;
          },
        ),
      ),
      Step(
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const Text('Special Items'),
        content: itemsProvider.specialItemsNames == null
            ? const LoadingWidget()
            : Consumer<PackingListProvider>(
                builder: (context, selectionProvider, child) {
                  return CustomChoiceChip(
                    title: "Any items you'd like to bring?",
                    options: specialItemsNames,
                    addSelection: selectionProvider.addSpecialItem,
                    removeSelection: selectionProvider.removeSpecialItem,
                  );
                },
              ),
      ),
      Step(
        isActive: currentStep >= 2,
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        title: const Text('Activities'),
        content: itemsProvider.activities == null
            ? const LoadingWidget()
            : Consumer<PackingListProvider>(
                builder: (context, selectionProvider, child) {
                  return CustomIconsGridView(
                    title: "Any activities you're planning?",
                    activities: activities,
                    addSelection: selectionProvider.addAcivity,
                    removeSelection: selectionProvider.removeActivity,
                  );
                },
              ),
      ),
    ];
  }
}
