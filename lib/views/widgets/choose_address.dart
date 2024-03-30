import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/location_cubit/location_cubit.dart';
import 'package:ecommerce_app/views/widgets/location_item_widget.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseAddress extends StatelessWidget {
  const ChooseAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationCubit = BlocProvider.of<LocationCubit>(context);
    final TextEditingController locationController = TextEditingController();

    return BlocBuilder<LocationCubit, LocationState>(
      bloc: BlocProvider.of<LocationCubit>(context),
      buildWhen: (previous, current) =>
          current is LocationLoaded ||
          current is LocationLoading ||
          current is LocationError,
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is LocationLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Address'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose your location',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Let\'s find your unforgettable event. Choose a location below to get started.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                      suffixIcon: Icon(Icons.my_location),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Select location',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => BlocProvider.of<LocationCubit>(context)
                          .getLocations(),
                      child: ListView.builder(
                        itemCount: state.locations.length,
                        itemBuilder: (context, index) {
                          final item = state.locations[index];
                          return LocationItemWidget(location: item);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MainButton(
                    onPressed: () {
                      final newLocation = locationController.text;
                      locationCubit.addLocation();
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Error loading locations'),
          );
        }
      },
    );
  }
}
