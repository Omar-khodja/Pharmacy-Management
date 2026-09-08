import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit.dart';
import 'package:pharmacy_management/core/controler/auth_cubit/auth_cubit_state.dart';
import 'package:pharmacy_management/feature/Inventory/presentaion/controlers/inventory_cubit/cubit/inventory_cubit.dart';
import 'package:pharmacy_management/feature/Inventory/presentaion/screen/inventory.dart';
import 'package:pharmacy_management/core/controler/medicien_mangment_bloc/medicien_mangment_bloc.dart';
import 'package:pharmacy_management/feature/Medicine%20Management/presentaion/screen/medicine_managment.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/controlers/sale%20bloc/sale_cubit.dart';
import 'package:pharmacy_management/feature/Sales/presentaion/screen/sales.dart';
import 'package:pharmacy_management/feature/dashboard/domain/usecase/get_dashboarddata_usecase.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/controlers/dashboard_bubit/dashboard_cubit.dart';
import 'package:pharmacy_management/feature/dashboard/presentaion/screen/dashboard.dart';
import 'package:pharmacy_management/core/dependnce_injection/injection_container.dart'
    as di;
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  int _selectedIndex = 0;
  late List<Widget> _pages;
  final List<String> _pageTitles = const [
    'Dashboard',
    'Medicine Management',
    'Sales',
    'Inventory',
  ];
  @override
  initState() {
    super.initState();
    context.read<AuthCubit>().getCurrentUser();

    _pages = [
      BlocProvider(
        create: (context) => DashboardCubit(
          getDashBoardDataUseCase: di.sl<GetDashBoardDataUseCase>(),
        ),

        child: const Dashboard(),
      ),
      BlocProvider.value(
        value: context.read<MedicienMangmentBloc>(),
        child: const MedicineManagement(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SaleCubit(
              getSaleDetailsUsecase: di.sl(),
              getSalesUsecase: di.sl(),
            ),
          ),
        ],
        child: const Sales(),
      ),

      BlocProvider(
        create: (context) => InventoryCubit(
          getAlaretUsecase: di.sl(),
          updatequantityUsecase: di.sl(),
        ),
        child: const Inventory(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: _advancedDrawerController,
      backdropColor: Theme.of(context).colorScheme.primary
          .withValues(alpha: .5),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: BlocBuilder<AuthCubit, AuthCubitState>(
            builder: (context, state) {
              if (state is Authorized) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DrawerHeader(
                      child: Column(
                        mainAxisAlignment: .center,
                        mainAxisSize: .min,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primaryContainer,
                            child: Text(
                              state.authstate.user.name.substring(0, 2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.authstate.user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: .bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () {
                        context.read<AuthCubit>().logout();
                      },
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 20,
          title: Text(_pageTitles[_selectedIndex]),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _advancedDrawerController
                  .showDrawer(); // open drawer programmatically
            },
          ),
        ),
        body: BlocListener<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            if (mounted && state is UnAuthorized) {
              Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              Navigator.pushReplacementNamed(context, "/login");
            }
          },
          child: IndexedStack(index: _selectedIndex, children: _pages),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 8,
              ),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,

                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.primary
                    .withValues(alpha: 0.8),
                color: Colors.black,
                tabs: const [
                  GButton(icon: LineIcons.home, text: 'Dashboard'),
                  GButton(icon: LineIcons.firstAid, text: 'Medicine'),
                  GButton(icon: LineIcons.shoppingCart, text: 'Sales'),
                  GButton(icon: LineIcons.box, text: 'Inventory'),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
