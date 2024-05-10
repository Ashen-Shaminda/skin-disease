import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skin_diseases_detection_system/components/my_animated_container.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userEmail = '';
  String _userName = '';
  late User _user;

  Future<void> _getUserData() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('roles').doc(_user.uid).get();
      DocumentSnapshot userData =
          await _firestore.collection('userData').doc(_user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _userEmail = userDoc['email'];
          _userName = userDoc['name'];
        });
      } else {
        print('Roles document does not exist');
      }
    } catch (e) {
      print('Error getting user name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('userData').snapshots(),
              builder: (context, snapshot) {
                List<Column> userWidgets = [];
                try {
                  if (snapshot.hasData) {
                    final users = snapshot.data?.docs.reversed.toList();
                    for (var userData in users!) {
                      final userWidget = Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyAnimatedContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(userData['email']),
                                Text(userData['name']),
                                Text(userData['label'])
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                      userWidgets.add(userWidget);
                    }
                  } else {
                    print('No data.');
                  }
                } catch (e) {
                  print(e);
                }

                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: userWidgets,
                );
              }),
        ],
      ),
    );
  }
}
