import 'package:flutter/material.dart';

class AgifyFormSubmit extends StatefulWidget {
  final bool loading;
  final Function() onSubmit;
  final TextEditingController editingController;

  const AgifyFormSubmit({
    super.key,
    required this.loading,
    required this.onSubmit,
    required this.editingController,
  });

  @override
  State<AgifyFormSubmit> createState() => _AgifyFormSubmitState();
}

class _AgifyFormSubmitState extends State<AgifyFormSubmit> {
  String currentName = '';

  @override
  void initState() {
    super.initState();

    currentName = widget.editingController.text;
    widget.editingController.addListener(updateName);
  }

  @override
  void dispose() {
    super.dispose();

    widget.editingController.removeListener(updateName);
  }

  void updateName() {
    final newName = widget.editingController.text;

    setState(() {
      currentName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final onPressDisabled = widget.loading || currentName.isEmpty;

    return ElevatedButton(
      onPressed: onPressDisabled ? null : widget.onSubmit,
      child: widget.loading
          ? const SizedBox(
              height: 12.0,
              width: 12.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            )
          : const Text('Evaluate!'),
    );
  }
}
