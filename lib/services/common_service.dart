import 'package:cloud_firestore/cloud_firestore.dart';

class CommonService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<String> get terms async {
    String content = '';
    DocumentReference documentReference =
        _firebaseFirestore.collection('commons').doc('terms');

    content = (await documentReference.get()).get('content');
    content =  content.replaceAll('\\n', "\n");
    return content.replaceAll('\\t', "\t");
  }
}
