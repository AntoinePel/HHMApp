import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String countryName;

  DetailPage(this.countryName);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Map<String, dynamic> country = {};

  @override
  void initState() {
    super.initState();
    // Appeler la méthode pour récupérer les données dans initState
    _fetchCountryData();
  }

  // Méthode pour récupérer les données du pays
  Future<void> _fetchCountryData() async {
    try {
      final data = await getCountryData(widget.countryName);
      setState(() {
        country = data;
      });
    } catch (error) {
      print('Erreur lors de la récupération des données du pays: $error');
      // Gérer l'erreur selon vos besoins (affichage d'un message d'erreur, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du pays'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Détails du pays pour :',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              widget.countryName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Afficher les détails du pays récupérés ici
            // Par exemple, vous pouvez afficher des détails spécifiques du pays à partir de la variable country
            // Exemple : Text('Capitale : ${country['capital']}'),
          ],
        ),
      ),
    );
  }
}

// Méthode pour récupérer les données du pays
Future<Map<String, dynamic>> getCountryData(String countryName) async {
  try {
    final response = await Dio().get('https://restcountries.com/v3.1/name/' + countryName);
    return response.data[0];
  } catch (error) {
    throw Exception('Impossible de récupérer les données du pays');
  }
}
