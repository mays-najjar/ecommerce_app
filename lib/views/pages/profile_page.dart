import 'package:ecommerce_app/models/profile_details.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/utils/route/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/view_models/profile_cubit/profile_cubit.dart';
import 'package:ecommerce_app/views/pages/settings_page.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is ProfileLoaded ||
          current is ProfileLoading ||
          current is ProfileError,
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          final profile = state.profile;

          return buildPProfilePage(context, profile);
        } else if (state is ProfileError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget buildPProfilePage(BuildContext context, ProfileDetails profile) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50.0),
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        profile.photoUrl,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      profile.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30, child: VerticalDivider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      profile.country,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('History of Orders'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('Card Details'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                 Navigator.of(context, rootNavigator: true).pushNamed(
                           AppRoutes.setting,
                  );
                },
              ),
              BlocConsumer<AuthCubit, AuthState>(
                bloc: authCubit,
                listenWhen: (previous, current) =>
                    current is AuthFailure || current is AuthInitial,
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.red,
                        ),
                      );
                  } else if (state is AuthInitial) {
                    // Navigator.of(context).pop();
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed(AppRoutes.homeLogin);
                  }
                },
                buildWhen: (previous, current) =>
                    current is AuthLoading || current is AuthFailure,
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const MainButton(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return ListTile(
                    leading: const Icon(Icons.exit_to_app, color: AppColors.red),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: AppColors.red),
                    ),
                    onTap: () async {
                      await authCubit.signOut();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
