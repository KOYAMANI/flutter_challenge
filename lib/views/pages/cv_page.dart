import 'package:flutter/material.dart';
import 'package:flutter_challenge/domain/repositories/repositories.dart';

// This is a static page to show CV
class CVPage extends StatelessWidget {
  final CVPageRepository cvPageRepository;
  const CVPage({Key? key, required this.cvPageRepository}) : super(key: key);

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
                    child: CircleAvatar(
                        backgroundImage: cvPageRepository.profileImage)),
                ListTile(
                  leading: Text('CONTACT',
                      style: Theme.of(context).textTheme.headline1),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: cvPageRepository.information.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ListTile(
                            leading: cvPageRepository.icons[index],
                            title: Text(cvPageRepository.information[index],
                                style: Theme.of(context).textTheme.bodyText1),
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
