import 'package:flutter/material.dart';

// This is a static page to show CV
class CVPage extends StatelessWidget {
  CVPage({Key? key}) : super(key: key);

  //TODO move 2 lists below to repository folder

  final List<String> information = [
    '12439 Berlin Germany',
    'yutaro.koyama@code.berlin',
    'https://github.com/KOYAMANI',
    'https://www.linkedin.com/in\n/yutaro-koyama-142853200'
  ];
  final List<Icon> icons = [
    const Icon(Icons.place, color: Colors.white),
    const Icon(Icons.email, color: Colors.white),
    const Icon(Icons.laptop_mac_rounded, color: Colors.white),
    const Icon(Icons.link, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0.5, -1.1),
              end: Alignment(1.0, 1.0),
              colors: [Colors.indigo, Colors.lightBlueAccent]),
        ),
        child: Center(
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
                ListTile(
                  leading: Text(
                    'CONTACT',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: information.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ListTile(
                            leading: icons[index],
                            title: Text(
                              information[index],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
