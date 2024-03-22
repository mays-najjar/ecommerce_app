import 'package:ecommerce_app/models/profile_details.dart';
import 'package:ecommerce_app/view_models/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubitP = ProfileCubit();
        cubitP.getProfileData();
        return cubitP;
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
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
            return buildPProfilePage(context, state.profile);
          } else if (state is ProfileError) {
            return  Center(
             child: Text(state.message),
            );
          } else {
             return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget buildPProfilePage(
      BuildContext context, List<ProfileDetails> favProducts) {
    int index = 0;
    final cubitP = BlocProvider.of<ProfileCubit>(context);
    final profile = cubitP.state is ProfileLoaded
        ? (cubitP.state as ProfileLoaded).profile
        : [];

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
                        profile[index].imgUrl,
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
                      profile[index].name,
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
                      profile[index].country,
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
                title: const Text('Personal Details'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Logout'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
