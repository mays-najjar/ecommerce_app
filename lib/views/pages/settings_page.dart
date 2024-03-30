
import 'package:ecommerce_app/utils/route/app_routes.dart';
import 'package:ecommerce_app/views/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'General',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
      leading: const Icon(Icons.edit),
      title: const Text("Edit Profile"),
      trailing: const Icon(Icons.arrow_forward_ios), 
      onTap:  (){
           Navigator.of(context, rootNavigator: true).pushNamed(
                           AppRoutes.editProfilPage,
                  );
      }
      ,
    ),
          buildSettingsButton(Icons.lock, 'Change Password'),
          buildSettingsButton(Icons.notifications, 'Notification'),
          buildSettingsButton(Icons.security, 'Security'),
          buildSettingsButton(Icons.language, 'Language'),
          const Divider(),
          buildSettingsButton(Icons.policy, 'Legal and Policies'),
          buildSettingsButton(Icons.help, 'Help & Support'),
        ],
      ),
    );
  }

  Widget buildSettingsButton(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios), 
      onTap:  (){}
      ,
    );
  }
}
