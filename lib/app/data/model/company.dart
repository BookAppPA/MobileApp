import 'package:google_maps_flutter/google_maps_flutter.dart';

class Company {

  String siren, siret, name, codeActivity, address;
  LatLng coord;

  Company({
    this.siren,
    this.siret,
    this.name,
    this.codeActivity,
    this.address,
    this.coord
  });

  Company.fromJson(Map<String, dynamic> json){
      this.siren = json['siren'];
      this.siret = json['siret'];
      this.name = json['nom_raison_sociale'];
      this.codeActivity = json['activite_principale_entreprise'] ?? json['activite_principale'];
      this.address = json['geo_adresse'];
      this.coord = LatLng(double.parse(json['latitude']), double.parse(json['longitude']));
  }

  @override
  String toString() => "$name: $siret";
}