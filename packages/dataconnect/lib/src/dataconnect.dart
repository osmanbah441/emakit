import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dataconnect_gen/default.dart';
import 'repositories/product_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/category_repository.dart';
import 'repositories/user_commerce_repository.dart';

final class DataConnect {
  const DataConnect._()
    : productRepository = const ProductRepository(),
      categoryRepository = const CategoryRepository(),
      // userRepository = const UserRepository(),
      userCommerceRepository = const UserCommerceRepository();

  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  // final UserRepository userRepository;
  final UserCommerceRepository userCommerceRepository;

  static get defaultConnect => DefaultConnector.instance;

  static const instance = DataConnect._();

  static void useEmulator({
    required (String, int) db,
    required (String, int) auth,
    required (String, int) fn,
    required (String, int) firestore,
    required (String, int) storage,
  }) async {
    DefaultConnector.instance.dataConnect.useDataConnectEmulator(db.$1, db.$2);
    await FirebaseAuth.instance.useAuthEmulator(auth.$1, auth.$2);
    FirebaseFunctions.instance.useFunctionsEmulator(fn.$1, fn.$2);
    FirebaseFirestore.instance.useFirestoreEmulator(firestore.$1, firestore.$2);
    FirebaseStorage.instance.useStorageEmulator(storage.$1, storage.$2);
  }
}
