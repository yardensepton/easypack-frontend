import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingButton<T extends ChangeNotifier> extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, provider, child) {
        final isLoading = (provider as dynamic).isLoading;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(200.0, 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.purple)
              : Text(buttonText),
        );
      },
    );
  }
}
