import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/profile_details.dart';
import 'package:ecommerce_app/services/profile_services.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _profileServices = ProfileServicesImpl();
  final authServices = AuthServicesImpl();

  late TextEditingController _nameController;
  late TextEditingController _imgUrlController;
  late TextEditingController _ageController;
  late TextEditingController _countryController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _imgUrlController = TextEditingController();
    _ageController = TextEditingController();
    _countryController = TextEditingController();
    _emailController = TextEditingController();

    _fetchProfileDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imgUrlController.dispose();
    _ageController.dispose();
    _countryController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfileDetails() async {
    try {
      final currentUser = await authServices.currentUser();
      final profile = await _profileServices.getProfile(currentUser!.uid);
      _nameController.text = profile.name;
      _imgUrlController.text = profile.photoUrl;
      _ageController.text = profile.age.toString();
      _countryController.text = profile.country;
      _emailController.text = profile.email;
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch profile: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final currentUser = await authServices.currentUser();

      final updatedProfile = ProfileDetails(
        id: currentUser!.uid,
        name: _nameController.text,
        photoUrl: _imgUrlController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        country: _countryController.text,
        email: _emailController.text,
      );
      try {
        await _profileServices.updateProfile(currentUser.uid, updatedProfile);
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Profile updated successfully.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to update profile: $e'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Settings'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                Text(
                  'Image URL',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextFormField(
                  controller: _imgUrlController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    prefixIcon: Icon(Icons.image),
                  ),
                ),
                Text(
                  'Age',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Text(
                  'Country',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                MainButton(
                  title: 'Save Changes',
                  onPressed: _updateProfile,
                ),
              ],
            ),
          ),
        ));
  }
}
