import 'package:ecommerce_app/view_models/categories_cubit/categories_cubit.dart';
import 'package:ecommerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/views/widgets/categories_tab_view.dart';
import 'package:ecommerce_app/views/widgets/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) {
            final cubitH = HomeCubit();
            cubitH.getHomeData();
            return cubitH;
          },
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) {
            final cubitC = CategoriesCubit();
            cubitC.getCategoryData();
            return cubitC;
          },
        ),
      ],
      child: const DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Home',
                ),
                Tab(
                  text: 'Categories',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  HomeTabView(),
                  CategoriesTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
