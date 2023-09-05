import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Theme.of(context).cardColor,
              strokeWidth: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Carregando...",
              style: TextStyle(
                color: Theme.of(context).cardColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
