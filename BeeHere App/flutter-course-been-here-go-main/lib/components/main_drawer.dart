import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Text('BeenHere',
                  style: Theme.of(context).textTheme.headlineSmall)),
          ListTile(
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text('Places'),
            onTap: () => Navigator.pushNamed(context, '/places'),
          ),
          ListTile(
            title: const Text('Mapview'),
            onTap: () => Navigator.pushNamed(context, '/places-maps'),
          )
        ],
      ),
    );
  }
}
