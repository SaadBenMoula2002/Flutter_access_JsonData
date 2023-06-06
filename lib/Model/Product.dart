

class Product {

  final String libelle;
  final int id;
  final double prix;
  final String date;

  const Product({
    required this.date,
    required this.id,
    required this.libelle,
    required this.prix
});

  @override String toString(){
    return "Produit : $libelle\n"
        "ID : $id\n"
        "Prix : $prix\n"
        "Date : $date\n";
  }

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      libelle: data['libelle'],
      id: data['id'],
      prix: data['prix'].toDouble(),
      date: data['date'],
    );
  }

}