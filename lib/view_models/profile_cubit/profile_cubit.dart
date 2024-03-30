import 'package:ecommerce_app/models/profile_details.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/profile_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final profileServices = ProfileServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getProfils() async {}
  Future<void> getProfileData() async {
    emit(ProfileLoading());
    try {
      final currentUser = await authServices.currentUser();
      final profile = await profileServices.getProfile(currentUser!.uid);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
