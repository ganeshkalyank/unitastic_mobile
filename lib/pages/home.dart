import 'package:flutter/material.dart';
import 'package:unitastic_mobile/widgets/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  final List<Widget> _widgets = [
    const HomeWidget(),
    Container(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unitastic',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: _widgets[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          surfaceTintColor: Colors.white,
          labelTextStyle: MaterialStateProperty.all<TextStyle>(
            Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          indicatorColor: Theme.of(context).colorScheme.tertiary,
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(
                  Icons.home,
                color: _selectedIndex == 0
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.book,
                color: _selectedIndex == 1
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
              ),
              label: 'Materials',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.calculate,
                color: _selectedIndex == 2
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
              ),
              label: 'Utilities',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.group,
                color: _selectedIndex == 3
                    ? Colors.white
                    : Theme.of(context).colorScheme.secondary,
              ),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }
}