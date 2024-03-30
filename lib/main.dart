import 'package:ecommerce_app/utils/app_theme.dart';
import 'package:ecommerce_app/utils/route/app_router.dart';
import 'package:ecommerce_app/utils/route/app_routes.dart';
import 'package:ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/view_models/location_cubit/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) {
            final cubit = AuthCubit();
            cubit.getCurrentUser();
            return cubit;
          },
        ),
        BlocProvider<LocationCubit>(
          create: (context) {
            final cubit = LocationCubit();
            cubit.getLocations();
            return cubit;
          },
        ),
      ],
      child: Builder(builder: (context) {
        final cubit = BlocProvider.of<AuthCubit>(context);
        return BlocBuilder<AuthCubit, AuthState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is AuthInitial || current is AuthSuccess,
          builder: (context, state) {
            return MaterialApp(
              title: 'E-Commerce App',
              theme: AppTheme.lightTheme(),
              initialRoute: state is AuthSuccess
                  ? AppRoutes.bottomNavbar
                  : AppRoutes.homeLogin,
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        );
      }),
    );
  }
}
