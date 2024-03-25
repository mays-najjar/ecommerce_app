import 'package:ecommerce_app/models/profile_details.dart';
import 'package:ecommerce_app/services/profile_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final profileServices = ProfileServicesImpl();
  
  Future<void> getProfils() async {
   
  }
  Future<void>  getProfileData(String profileId) async {
    emit(ProfileLoading());
    try {
      final profile = await profileServices.getProfile(profileId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
