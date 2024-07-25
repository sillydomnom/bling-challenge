import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/agify__bloc.dart';
import '../di/di_provider.dart';
import 'agify_form_submit.dart';

class AgifyForm extends StatefulWidget {
  const AgifyForm({super.key});

  @override
  State<AgifyForm> createState() => _AgifyFormState();
}

class _AgifyFormState extends State<AgifyForm> {
  late TextEditingController controller;
  late AgifyBloc agifyBloc;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    agifyBloc = context.readDependency<AgifyBloc>();
  }

  void evaluateName(String name) {
    agifyBloc.add(AgifyLoadNameStarted(name: name));

    controller.clear();
    controller.clearComposing();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Evaluate your Age by your name!',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Please enter your name to get evaluated by high-tech AI Models:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Name'),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            onFieldSubmitted: (name) => evaluateName(name),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<AgifyBloc, AgifyState>(
            bloc: agifyBloc,
            builder: (context, state) {
              return AgifyFormSubmit(
                loading: state is AgifyAgeRetrievalInProgress,
                editingController: controller,
                onSubmit: () => evaluateName(controller.text),
              );
            },
          ),
        ),
      ],
    );
  }
}
