import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/utils/route/app_routes.dart';
import 'package:ecommerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/view_models/payment_choose_method_cubit/payment_choose_method_cubit.dart';
import 'package:ecommerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:ecommerce_app/view_models/profile_cubit/profile_cubit.dart';
import 'package:ecommerce_app/views/pages/checkout_page.dart';
import 'package:ecommerce_app/views/pages/custom_buttom_navbar.dart';
import 'package:ecommerce_app/views/pages/login_page.dart';
import 'package:ecommerce_app/views/pages/product_details_page.dart';
import 'package:ecommerce_app/views/pages/settings_page.dart';
import 'package:ecommerce_app/views/widgets/add_payment_method_form.dart';
import 'package:ecommerce_app/views/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.productDetails:
        final product = settings.arguments as ProductItemModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit = ProductDetailsCubit();
                    cubit.getProductDetails(product.id);
                    return cubit;
                  },
                  child: const ProductDetailsPage(),
                ));
      case AppRoutes.profilPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit = ProfileCubit();
                    cubit.getProfileData();
                    return cubit;
                  },
                  child: const ProductDetailsPage(),
                ));
      case AppRoutes.bottomNavbar:
        return MaterialPageRoute(builder: (_) => const CustomBottomNavbar());
      case AppRoutes.homeLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = CheckoutCubit();
              cubit.getCheckoutPage();
              return cubit;
            },
            child: const CheckoutPage(),
          ),
          settings: settings,
        );
      case AppRoutes.addPaymentMethod:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit = PaymentChooseMethodCubit();
                    cubit.getPaymentMethod();
                    return cubit;
                  },
                  child: AddPaymentMethodPage(),
                ));
      case AppRoutes.setting:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit = ProfileCubit();
                    cubit.getProfileData();
                    return cubit;
                  },
                  child: const SettingsPage(),
                ));

      case AppRoutes.editProfilPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) {
                    final cubit = ProfileCubit();
                    cubit.getProfileData();
                    return cubit;
                  },
                  child: const EditProfileForm(),
                ));

      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text('Error Page'))));
    }
  }
}
