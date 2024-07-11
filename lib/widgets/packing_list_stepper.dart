// import 'package:easypack/widgets/trip_type_toggle_button.dart';
// import 'package:flutter/material.dart';

// class PackingListStepper extends StatefulWidget {
//   const PackingListStepper({super.key});

//   @override
//   State<PackingListStepper> createState() => _PackingListStepperState();
// }

// class _PackingListStepperState extends State<PackingListStepper> {
//   int currentStep = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Stepper(
//       steps: getSteps(),
//       type: StepperType.vertical,
//       currentStep: currentStep,
//       onStepContinue:
//           currentStep == 2 ? null : () => setState(() => currentStep += 1),
//       onStepCancel:
//           currentStep == 0 ? null : () => setState(() => currentStep -= 1),
//       onStepTapped: (step) => setState(() {
//         currentStep = step;
//       }),
//     );
//   }

//   List<Step> getSteps() => [
//         Step(
//           isActive: currentStep >= 0,
//           state: currentStep > 0 ? StepState.complete : StepState.indexed,

//           title: const Text('Trip Type'),
//           content: const SizedBox(
//             child: TripTypeToggleButton()
//           ), // Replace with actual content widget
//         ),
//         Step(
//           isActive: currentStep >= 1,
//           state: currentStep > 1 ? StepState.complete : StepState.indexed,

//           title: const Text('Special items'),
//           content: const SizedBox(), // Replace with actual content widget
//         ),
//         Step(
//           isActive: currentStep >= 2,
//           state: currentStep > 2 ? StepState.complete : StepState.indexed,

//           title: const Text('Activities'),
//           content: const SizedBox(), // Replace with actual content widget
//         ),
//       ];
// }
// import 'package:easypack/widgets/custom_choice_chip.dart';
// import 'package:easypack/widgets/trip_type_toggle_button.dart';
// import 'package:flutter/material.dart';

// class PackingListStepper extends StatefulWidget {
//   const PackingListStepper({super.key});

//   @override
//   State<PackingListStepper> createState() => _PackingListStepperState();
// }

// class _PackingListStepperState extends State<PackingListStepper> {
//   int currentStep = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Stepper(
//       steps: getSteps(),
//       type: StepperType.vertical,
//       currentStep: currentStep,
//       onStepContinue: () {
//         if (currentStep < getSteps().length - 1) {
//           setState(() {
//             currentStep += 1;
//           });
//         }
//       },
//       onStepCancel: () {
//         if (currentStep > 0) {
//           setState(() {
//             currentStep -= 1;
//           });
//         }
//       },
//       onStepTapped: (step) => setState(() => currentStep = step),
//     );
//   }

//   List<Step> getSteps() => [
//         Step(
//           isActive: currentStep >= 0,
//           state: currentStep > 0 ? StepState.complete : StepState.indexed,
//           title: const Text('Trip Type'),
//           content: const TripTypeToggleButton(),
//         ),
//         Step(
//           isActive: currentStep >= 1,
//           state: currentStep > 1 ? StepState.complete : StepState.indexed,
//           title: const Text('Special items'),
//           content: const CustomChoiceChip(), // Replace with actual content widget
//         ),
//         Step(
//           isActive: currentStep >= 2,
//           state: currentStep > 2 ? StepState.complete : StepState.indexed,
//           title: const Text('Activities'),
//           content: const SizedBox(), // Replace with actual content widget
//         ),
//       ];
// }
import 'package:easypack/providers/items_provider.dart';
import 'package:easypack/widgets/custom_choice_chip.dart';
import 'package:easypack/widgets/loading_widget.dart';
import 'package:easypack/widgets/trip_type_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackingListStepper extends StatefulWidget {
  const PackingListStepper({super.key});

  @override
  State<PackingListStepper> createState() => _PackingListStepperState();
}

class _PackingListStepperState extends State<PackingListStepper> {
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<ItemsProvider>(context, listen: false).fetchItemsNamesByCategory();
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
        title: const Text('Special items'),
        content: itemsProvider.specialItemsNames == null 
          ?const LoadingWidget() 
          : CustomChoiceChip(options: specialItemsNames),
      ),
      Step(
        isActive: currentStep >= 2,
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        title: const Text('Activities'),
        content: const SizedBox(), // Replace with actual content widget
      ),
    ];
  }
}
