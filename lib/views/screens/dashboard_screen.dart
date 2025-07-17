import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final List<_ModuleItem> modules = [
    _ModuleItem('Learning by Words', Icons.book, Colors.lightBlue),
    _ModuleItem('Games', Icons.videogame_asset, Colors.orange),
    _ModuleItem('Speech Assistance', Icons.record_voice_over, Colors.purple),
    _ModuleItem('User Analysis', Icons.analytics, Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: modules.map((module) {
          return GestureDetector(
            onTap: () {
              // TODO: Navigate to respective module screen
              print("Tapped on ${module.title}");
            },
            child: Container(
              decoration: BoxDecoration(
                color: module.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: module.color.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(module.icon, size: 48, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    module.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ModuleItem {
  final String title;
  final IconData icon;
  final Color color;

  _ModuleItem(this.title, this.icon, this.color);
}
