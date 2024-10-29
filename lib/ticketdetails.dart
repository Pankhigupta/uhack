import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket Details',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const TicketDetails(),
    );
  }
}

class TicketDetails extends StatefulWidget {
  const TicketDetails({super.key});

  @override
  State<TicketDetails> createState() => TicketDetailState();
}

class TicketDetailState extends State<TicketDetails> {
  final TextEditingController _pnrController = TextEditingController();
  Map<String, dynamic>? ticketDetails;
  bool isLoading = false;

  // Function to fetch PNR Status from the API
  Future<void> fetchPNRStatus(String pnr) async {
    setState(() {
      isLoading = true;
      ticketDetails = null;
    });

    const String apiKey = 'd8f57301a0msh6773338790d5db7p176868jsn0bebba0a353a';
    const String apiHost = 'irctc-indian-railway-pnr-status.p.rapidapi.com';

    try {
      final url = 'https://$apiHost/getPNRStatus/$pnr';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'x-rapidapi-key': apiKey,
          'x-rapidapi-host': apiHost,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          ticketDetails = data['data'];
        });
      } else {
        _showError('Invalid PNR or API error: ${response.reasonPhrase}');
      }
    } catch (e) {
      _showError('Failed to fetch data: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to display an error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter PNR Number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pnrController,
                decoration: const InputDecoration(
                  hintText: 'PNR No.',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_pnrController.text.isNotEmpty) {
                    fetchPNRStatus(_pnrController.text);
                  } else {
                    _showError('Please enter a PNR number.');
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text('Fetch Ticket Details'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              ticketDetails != null
                  ? _buildTicketDetailsTable()
                  : const Text('Enter a PNR number to fetch details.'),
            ],
          ),
        ),
      ),
    );
  }

  // Build a table to display ticket details
  Widget _buildTicketDetailsTable() {
    // Extract data from the ticketDetails map
    final List<dynamic> passengers = ticketDetails!['passengerList'] ?? [];
    final String trainNo = ticketDetails!['trainNumber'] ?? 'N/A';
    final String trainName = ticketDetails!['trainName'] ?? 'N/A';
    final String boardingPoint = ticketDetails!['boardingPoint'] ?? 'N/A';
    final String arrivalDate = ticketDetails!['arrivalDate'] ?? 'N/A';

    return Table(
      border: TableBorder.all(color: Colors.black),
      children: [
        // Header Row
        const TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Train No',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Train Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Boarding Point',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Arrival Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        // Train Details Row
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(trainNo),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(trainName),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(boardingPoint),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(arrivalDate),
            ),
          ],
        ),
        const TableRow(children: [
          TableCell(child: Divider()),
          TableCell(child: Divider()),
          TableCell(child: Divider()),
          TableCell(child: Divider()),
        ]),
        // Passenger Details Header
        const TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'S.No',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Booking Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Coach Position',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Berth No',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        // Passenger Details Rows
        ...List.generate(passengers.length, (index) {
          final passenger = passengers[index];
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text((index + 1).toString()), // S.No
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Text(passenger['currentStatus'] ?? 'N/A'), // Booking Status
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(passenger['passengerCoachPosition'].toString() ??
                    'N/A'), // Coach Position
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(passenger['currentBerthNo'].toString() ??
                    'N/A'), // Berth No
              ),
            ],
          );
        }),
        if (passengers.isEmpty)
          const TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child:
                Text('No passengers', style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('N/A', style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('N/A', style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('N/A', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
      ],
    );
  }
}