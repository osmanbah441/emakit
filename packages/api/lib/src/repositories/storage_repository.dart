import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

enum StorageFolder { products, variations, users }

final class StorageRepository {
  static final StorageRepository instance = StorageRepository._();
  const StorageRepository._();

  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final _uuid = Uuid();

  /// Upload a single image and return its download URL.
  static Future<String> uploadImage({
    required ({Uint8List bytes, String mimeType}) imageData,
    required String storeId,
    required StorageFolder folder,
  }) async {
    try {
      final String fileExtension = _getFileExtension(imageData.mimeType);
      final String fileName = '${_uuid.v4()}.$fileExtension';
      final ref = _storage.ref('${folder.name}/$storeId/$fileName');
      final metadata = SettableMetadata(contentType: imageData.mimeType);
      final snapshot = await ref.putData(imageData.bytes, metadata);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  /// Upload multiple images and return their download URLs.
  static Future<List<String>> uploadImages({
    required List<({Uint8List bytes, String mimeType})> imagesData,
    required String storeId,
    required StorageFolder folder,
  }) async {
    try {
      return await Future.wait(
        imagesData.map(
          (i) => uploadImage(imageData: i, storeId: storeId, folder: folder),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Delete a single image by its download URL.
  static Future<void> deleteImage(String downloadUrl) async {
    try {
      final ref = _storage.refFromURL(downloadUrl);
      await ref.delete();
    } catch (e) {
      rethrow;
    }
  }

  /// Delete multiple images by their download URLs.
  static Future<void> deleteImages(List<String> downloadUrls) async {
    try {
      for (final url in downloadUrls) {
        await deleteImage(url);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Update an image: delete old and upload new one.
  /// Returns the new download URL.
  static Future<String> updateImage({
    required String oldImageUrl,
    required ({Uint8List bytes, String mimeType}) newImageData,
    required String storeId,
    required StorageFolder folder,
  }) async {
    try {
      await deleteImage(oldImageUrl);
      final newUrl = await uploadImage(
        imageData: newImageData,
        storeId: storeId,
        folder: folder,
      );
      return newUrl;
    } catch (e) {
      rethrow;
    }
  }

  /// Helper to get file extension from MIME type.
  static String _getFileExtension(String mimeType) {
    switch (mimeType) {
      case 'image/jpeg':
        return 'jpg';
      case 'image/png':
        return 'png';
      case 'image/webp':
        return 'webp';
      default:
        throw UnsupportedError('Unsupported MIME type: $mimeType');
    }
  }
}
