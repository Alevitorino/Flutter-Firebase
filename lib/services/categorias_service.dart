import 'package:autonomo_app/models/categorias_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriasService {
  Categorias _dadosCat(DocumentSnapshot snapshot) {
    return Categorias(
      ti: snapshot.data['TI'],
    );
  }

  Stream<dynamic> get getCategorias {
    return Firestore.instance
        .collection('anuncio')
        .document("categorias")
        .snapshots()
        .map(_dadosCat);
    
  }
}
