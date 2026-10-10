import 'package:flutter/material.dart';

import 'event_details_screen.dart';

class HomeFeedScreen extends StatefulWidget {
  @override
  _HomeFeedScreenState createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  List<Map<String, dynamic>> events = [];

  @override
  voidinitState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    try {
      final data = await ApiService.getFeed();

      setState(() {
        events = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      print("Feed error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CLT BUZZ"), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: _loadFeed,
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return buildEventCard(event);
          },
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event["title"],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            Text(
              "Host: ${event["host"]}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 4),

            Text(
              "Date: ${event["date"]} at ${event["time"]}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(height: 4),

            Text(
              "Location: ${event["location"]}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(height: 4),

            Text(
              "Price: \$${event["price"]}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(height: 4),

            Text(
              "Capacity: ${event["capacity"]}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(height: 4),

            Text(
              "Hobby Type: ${event["hobbyType"]}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(height: 4),

            Text(
              "Age Range: ${event["ageRange"]}",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EventDetailsScreen(event: event),
                  ),
                );
              },
              child: Text("View Event"),
            ),
          ],
        ),
      ),
    );
  }
}
