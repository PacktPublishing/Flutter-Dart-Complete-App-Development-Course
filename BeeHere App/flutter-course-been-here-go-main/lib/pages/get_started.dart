import 'package:been_here_go/pages/home_screen.dart';
import 'package:been_here_go/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('BeenHere - Document Your Journey!',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .signInUserAnonymously();

                // Navigate users to the home page
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const HomePage()));

                //This will navigate to the new screen (HomePage) and replace
                //the current screen with it, effectively
                // removing the previous screen from the navigation stack
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Get Started'))
        ],
      ),
    );
  }
}
