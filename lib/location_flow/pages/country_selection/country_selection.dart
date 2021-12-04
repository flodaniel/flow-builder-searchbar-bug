import 'package:example/location_flow/location_flow.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'country_selection_cubit.dart';

class CountrySelection extends StatelessWidget {
  static MaterialPage<void> page() {
    return MaterialPage<void>(child: CountrySelection());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return CountrySelectionCubit(
          context.read<LocationRepository>(),
        )..countriesRequested();
      },
      child: CountrySelectionForm(),
    );
  }
}

class CountrySelectionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.flow<Location>().complete(),
        ),
        title: const Text('Country'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<CountrySelectionCubit, LocationState>(
              builder: (context, state) {
                return FloatingSearchBar(builder: (_, __) => Container());
              },
            ),
            BlocBuilder<CountrySelectionCubit, LocationState>(
              builder: (context, state) {
                return TextButton(
                  child: const Text('Submit'),
                  onPressed: state.selectedLocation != null
                      ? () => context
                          .flow<Location>()
                          .update((s) => s.copyWith(country: 'TestCountry'))
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
