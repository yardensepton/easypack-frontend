import 'package:easypack/providers/items_provider.dart';
import 'package:easypack/providers/packing_list_provider.dart';
import 'package:easypack/widgets/custom_choice_chip.dart';
import 'package:easypack/widgets/custom_icons_grid_view.dart';
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

  @override
  void initState() {
    super.initState();
    Provider.of<ItemsProvider>(context, listen: false).fetchStepperData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsProvider>(
      builder: (context, itemsProvider, child) {
        return Stepper(
          steps: getSteps(itemsProvider),
          type: StepperType.vertical,
          currentStep: currentStep,
          onStepContinue: () {
            if (currentStep < getSteps(itemsProvider).length - 1) {
              setState(() {
                currentStep += 1;
              });
            }
            if (currentStep == 2) {
              Provider.of<PackingListProvider>(context, listen: false)
                  .ceatePackingList(context,widget.tripId);
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
        );
      },
    );
  }

  List<Step> getSteps(ItemsProvider itemsProvider) {
    final specialItemsNames = itemsProvider.specialItemsNames ?? [];
    final activities = itemsProvider.activities ?? [];

    return [
      Step(
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Text('Trip Type'),
        content: const TripTypeToggleButton(),
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
            : CustomIconsGridView(
                title: "Any activities you're planning?",
                activities: activities), // Replace with actual content widget
      ),
    ];
  }
}
