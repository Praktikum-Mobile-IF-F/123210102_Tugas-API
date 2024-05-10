import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final user, pass, birthday;
  ProfilePage({Key? key, required this.user, required this.pass, required this.birthday})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String hobby = "Main Game - Nonton Film - Mendengarkan musik";

  @override
  Widget build(BuildContext context) {
    List<String> hobbies = hobby.split(' - ');
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/rafael.jpg'),
            ),
            SizedBox(height: 20),
            _buildProfileField('Nama', widget.user),
            _buildProfileField('Password', widget.pass),
            _buildProfileField('Birthday', widget.birthday),
            _buildHobbiesList(hobbies),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHobbiesList(List<String> hobbies) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            'Hobi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: hobbies.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildHobbyItem(hobbies[index]);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHobbyItem(String hobby) {
    return
      ListTile(
        leading: Icon(Icons.remove),
        title: Text(
          hobby,
          style: TextStyle(fontSize: 16),
        ),
      );
  }
}