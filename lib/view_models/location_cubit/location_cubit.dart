import 'package:ecommerce_app/models/address_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  final locationServices = LocationServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getLocations() async {
    emit(LocationLoading());
    try {
      final currentUser = await authServices.currentUser();
      final locations = await locationServices.getLocations(currentUser!.uid);

      emit(LocationLoaded(
        locations: locations,
      ));
    } catch (e) {
      emit(
        LocationError(message: e.toString()),
      );
    }
  }
  
  Future<void> addLocation() async {
    emit(LocationLoading());
    try {
      final currentUser = await authServices.currentUser();
      final locations = await locationServices.getLocations(currentUser!.uid);

      emit(LocationLoaded(
        locations: locations,
      ));
    } catch (e) {
      emit(
        LocationError(message: e.toString()),
      );
    }
  }
}
