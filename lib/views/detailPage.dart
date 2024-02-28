import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String countryName;

  DetailPage(this.countryName);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var country;
  late String capital = '';
  late String flag = '';
  late double area = 0.0;

  @override
  void initState() {
    super.initState();
    // Appeler la méthode pour récupérer les données dans initState
    _fetchCountryData();
  }

  // Méthode pour récupérer les données du pays
  Future<void> _fetchCountryData() async {
    final data = await getCountryData(widget.countryName);
    setState(() {
      country = data;
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country details'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              country['flags']['png'],
              height: 100,
              fit: BoxFit.contain,
            ),
            Text(
              '${country['name']['common']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Capital : ${country['capital'][0]}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Population : ${country['population'].toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ' ')} inhabitants',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Area : ${country['area'].toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ' ')} km²',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Region : ${country['region']}' + ' (${country['subregion']})',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'UN Member : ${country['unMember'] ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Méthode pour récupérer les données du pays
Future<Map<String, dynamic>> getCountryData(String countryName) async {
  final response = await Dio().get('https://restcountries.com/v3.1/name/' + countryName);
  return response.data[0];
}
