import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  EventDetailsScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event["title"]),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 250,
              child: PageView(
                children: event["images"]
                .map<Widget>((img) => ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(img, fit: BoxFit.cover),
                ))
                .toList(),
              ),
            ),
            SizedBox(height: 20),

            Text(
              event["title"],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),
            Text(
              "Hosted by: ${event["host"]}",
              style: TextStyle(fontSize: 10, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icons(Icons.calendar_today, size: 20),
                SizedBox(width: 0),
                Text(
                  "${event["date"]} at ${event["time"]}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 12),
            Row(
              children: [
                Icons(Icons.location_on, size: 20),
                SizedBox(width: 0),
                Text(
                  event["location"],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Icons(Icons.attach_money, size: 20),
                SizedBox(width: 0),
                Text(
                  event["price"] == 0 ? "Free" : "\$${event["price"]}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.people, size: 20),
                SizedBox(width: 8),
                Text(
                  "Capacity: ${event["capacity"]}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Hobby Type
            Row(
              children: [
                Icon(Icons.sports_soccer, size: 20),
                SizedBox(width: 8),
                Text(
                  "Category: ${event["hobbyType"]}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Age Range
            Row(
              children: [
                Icon(Icons.cake, size: 20),
                SizedBox(width: 8),
                Text(
                  "Age Range: ${event["ageRange"]}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 30),

            // RSVP Button
            ElevatedButton(
              onPressed: () async {
                // TODO: Add RSVP API call
                try {
                  final result = await ApiService.rsvp(eventId: event["id"], username: "Nate",
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("RSVP successful!")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to RSVP.")),
                  );
                }
              }
              child: Text("RSVP"),
            )

            SizedBox(height: 12),

            // Share Button
            OutlinedButton(
              onPressed: () {
                // TODO: Add share functionality
              },
              child: Text("Share Event"),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ]
          Future<List<dynamic>> _loadAttendees() async {
            return await ApiService.getAttendees(event["id"]);
          }
          FutureBuilder(
            future: _loadAttendees(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              final attendees = snapshot.data as List<dynamic>;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Attendees (${attendees.length})",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ...attendees.map((name) => ListTile(
                        leading: Icon(Icons.person),
                        title: Text(name),
                      )),
                ],
              );
            },
          )
        )
      )
    );
  }
}