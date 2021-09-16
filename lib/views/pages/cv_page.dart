import 'package:flutter/material.dart';

class CVPage extends StatelessWidget {
  const CVPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 3,
                child: const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/profile.jpg',
                  ),
                ),
              ),
              Text('Contact'),
              Row(
                children: [
                  Icon(Icons.pin_drop),
                  const Text('12439 Berlin Germany')
                ],
              ),
              Row(
                children: [
                  Icon(Icons.email),
                  Text('yutaro.koyama@code.berlin')
                ],
              ),
              Row(
                children: [
                  Icon(Icons.laptop),
                  Text('https://github.com/KOYAMANI')
                ],
              ),
              Row(
                children: [
                  Icon(Icons.link),
                  Text('https://www.linkedin.com/in\n/yutaro-koyama-142853200')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
