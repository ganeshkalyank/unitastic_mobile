import 'package:flutter/material.dart';
import 'package:unitastic_mobile/widgets/home.dart';
import 'package:unitastic_mobile/widgets/materials.dart';
import 'package:unitastic_mobile/widgets/more.dart';
import 'package:unitastic_mobile/widgets/utilities.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgets = [
    const HomeWidget(),
    const MaterialsWidget(),
    UtilitiesWidget(),
    const MoreWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Unitastic',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: PageView(
        controller: controller,
        children: _widgets,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          surfaceTintColor: Colors.white,
          labelTextStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          iconTheme: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return const IconThemeData(
                    color: Colors.white,
                  );
                }
                return Theme.of(context).iconTheme.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                );
            },
          ),
          indicatorColor: Theme.of(context).colorScheme.tertiary,
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
            controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.book),
              label: 'Materials',
            ),
            NavigationDestination(
              icon: Icon(Icons.calculate),
              label: 'Utilities',
            ),
            NavigationDestination(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}