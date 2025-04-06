import 'package:flutter/material.dart';

class StudentDashboard extends StatefulWidget {
  final bool advanced;
  const StudentDashboard({super.key, this.advanced = false});

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text('Welcome, Student!', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Department: Computer Science'),
              ),
            ),
            const SizedBox(height: 20),

            // Timetable Section
            widget.advanced
                ? Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.schedule, color: Colors.blueAccent),
                title: Text('View Timetable'),
                subtitle: Text('Check your upcoming classes'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TimetableScreen())),
              ),
            )
                : SizedBox.shrink(),

            const SizedBox(height: 20),

            // Dashboard Options
            _buildDashboardOption(Icons.calendar_today, 'View Attendance', AttendanceScreen()),
            _buildDashboardOption(Icons.menu_book, 'Study Materials', StudyMaterialsScreen()),
            _buildDashboardOption(Icons.report_problem, 'Register Complaint', ComplaintScreen()),
            _buildDashboardOption(Icons.search, 'Lost & Found', LostFoundScreen()),
            _buildDashboardOption(Icons.task, 'Task Manager & Notifications', TaskManagerScreen()),
            _buildDashboardOption(Icons.trending_up, 'Attendance Prediction (AI)', AttendancePredictionScreen()),
            _buildDashboardOption(Icons.school, 'Smart Study Material (AI)', SmartStudyMaterialScreen()),

            // Notifications Section
            widget.advanced
                ? Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.notifications, color: Colors.redAccent),
                title: Text('Recent Notifications'),
                subtitle: Text('New assignment uploaded'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen())),
              ),
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  // Helper function to create dashboard options
  Widget _buildDashboardOption(IconData icon, String title, Widget page) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      ),
    );
  }
}

// Placeholder Screens
class AttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Attendance Tracking')));
}

class StudyMaterialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Study Materials')));
}

class ComplaintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Complaint Registration')));
}

class LostFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Lost & Found')));
}

class TaskManagerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Task Manager & Notifications')));
}

class AttendancePredictionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('AI Attendance Prediction')));
}

class SmartStudyMaterialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Smart Study Material (AI)')));
}

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Timetable')));
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Notifications')));
}
