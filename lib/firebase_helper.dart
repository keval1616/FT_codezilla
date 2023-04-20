import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codezilla/model/categorymodel.dart';
import 'package:codezilla/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Map<String, List<Map<String, dynamic>>>? sortedMap;
  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];

    QuerySnapshot querySnapshot = await _db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('qrs').orderBy('timestamp', descending: false)
        .get();
    // retrieve all documents from the 'users' collection

    querySnapshot.docs.forEach((doc) {
      users.add(UserModel(
          title: doc['title'],
          note: doc['note'],
          logo: doc['logo'],
          image: doc['image'],
          category: doc['category'],
          url: doc['url']));
    });
    // CustomModel customModel = CustomModel();
    //my6 logic goes here
   // for(int i=0;i<querySnapshot.docs.length;i++){
   //   print(querySnapshot.docs[i]['category']);
   //   String category = querySnapshot.docs[i]['category'];
   //   if(customModel.category.contains(category)){
   //     customModelList.add(CustomModel(category: category,userModel: querySnapshot.docs[i]),);
   //   }
   // }

    return users;
  }

  Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> categorys = [];

    QuerySnapshot querySnapshot = await _db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('category')
        .get();
    // retrieve all documents from the 'users' collection

    querySnapshot.docs.forEach((doc) {
      categorys.add(CategoryModel(category: doc['category']));
    });

    return categorys;
  }
}


class CustomModel{
  String category ="";
  List<UserModel>? userModelList = [];
  CustomModel({this.userModelList,this.category=""});
}