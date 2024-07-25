import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/agify__bloc.dart';
import '../di/di_provider.dart';
import 'agify_dialog.dart';

class AgifyFormWrapper extends StatelessWidget {
  final Widget child;

  const AgifyFormWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AgifyBloc, AgifyState>(
      bloc: context.readDependency<AgifyBloc>(),
      listener: (context, state) {
        if (state is AgifyAgeRetrievalFailure) {
          showDialog(
            context: context,
            builder: (context) => AgifyDialog.error(),
          );
        }
        
        if (state is AgifyAgeRetrieved) {
          showDialog(
            context: context,
            builder: (context) => AgifyDialog.success(age: state.age),
          );
        }
      },
      child: child,
    );
  }
}
