import 'package:flutter/material.dart';
import 'package:practice/ui/screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key});

  // final VoidCallback onTapAppBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
          );
        },
        child: Row(
          children: [
            CircleAvatar(),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Md Tanvir Ahmed', style: TextStyle(fontSize: 18)),
                Text('bmwthriad2023@gmail.com', style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
