import 'dart:typed_data';
import 'flutter_storm_platform_interface.dart';

Future<String?> SFileOpenArchive(String mpqName, int mpqFlags) async {
  return FlutterStormPlatform.instance.SFileOpenArchive(mpqName, mpqFlags);
}

Future<String?> SFileCreateArchive(String mpqName, int mpqFlags, int maxFileCount) async {
  return FlutterStormPlatform.instance.SFileCreateArchive(mpqName, mpqFlags, maxFileCount);
}

Future<int?> SFileCloseArchive(String hMpq) async {
  return FlutterStormPlatform.instance.SFileCloseArchive(hMpq);
}

Future<bool?> SFileHasFile(String hMpq, String fileName, int fileSize, int dwFlags) async {
  return FlutterStormPlatform.instance.SFileHasFile(hMpq, fileName, fileSize, dwFlags);
}

Future<String?> SFileCreateFile(String hMpq, String fileName, int fileSize, int dwFlags) async {
  return FlutterStormPlatform.instance.SFileCreateFile(hMpq, fileName, fileSize, dwFlags);
}

Future<int?> SFileCloseFile(String hFile) async {
  return FlutterStormPlatform.instance.SFileCloseFile(hFile);
}

Future<void> SFileWriteFile(String hFile, Uint8List pvData, int dwSize, int dwCompression) async {
  return FlutterStormPlatform.instance.SFileWriteFile(hFile, pvData, dwSize, dwCompression);
}

Future<void> SFileRemoveFile(String hMpq, String fileName) async {
  return FlutterStormPlatform.instance.SFileRemoveFile(hMpq, fileName);
}

Future<void> SFileRenameFile(String hMpq, String oldFileName, String newFileName) async {
  return FlutterStormPlatform.instance.SFileRenameFile(hMpq, oldFileName, newFileName);
}

Future<void> SFileFinishFile(String hFile) async {
  return FlutterStormPlatform.instance.SFileFinishFile(hFile);
}
