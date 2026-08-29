import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ProfilePage({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //top header section.........
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  color: Colors.orange,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      child: Image.network(
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                      ),
                    ),

                    const SizedBox(height: 12),
                    Text(
                      'Mohammad Shah Nur',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Flutter Developer | CSE Student',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              //Stats row.........
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statCard('12', 'Orders'),
                    _statCard('5', 'Reviews'),
                    _statCard('8', 'Favorites'),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              //Settings menu.........
              _menuItem(Icons.person_outlined, 'Edit Profile', context),
              _menuItem(Icons.location_on_outlined, 'My Address', context),
              _menuItem(Icons.receipt_long_outlined, 'My Orders', context),
              _menuItem(Icons.notifications_outlined, 'Notifications', context),

              const SizedBox(height: 10),

              //Dark mode toggle - seperate from other items.......
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: ListTile(
                  leading: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Colors.orange,
                  ),
                  title: Text(isDarkMode ? 'Dark Mode' : 'Light Mode'),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (_) => onThemeToggle(),
                    activeThumbColor: Colors.orange,
                  ),
                ),
              ),

              const SizedBox(height: 10),
              _menuItem(Icons.logout, 'Log Out', context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  //Helper stats card.......
  Widget _statCard(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          number,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  //Helper menu card............
  Widget _menuItem(IconData icon, String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange,),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
