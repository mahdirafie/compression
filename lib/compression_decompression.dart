import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

Future<void> compressPng(String inputFilePath, String outputFilePath, int compressionLevel) async {
  try {
    final inputImage = img.decodeImage(File(inputFilePath).readAsBytesSync());
    final compressedBytes = img.encodePng(inputImage!, level: compressionLevel);
    await File(outputFilePath).writeAsBytes(compressedBytes);
    print('Compression successful.');
  } catch (e) {
    print('Error compressing PNG: $e');
  }
}

Future<void> decompressPng(String inputFilePath, String outputFilePath) async {
  try {
    final inputImage = img.decodeImage(File(inputFilePath).readAsBytesSync());
    await File(outputFilePath).writeAsBytes(img.encodePng(inputImage!));
    print('Decompression successful.');
  } catch (e) {
    print('Error decompressing PNG: $e');
  }
}

Future<void> compressFile(String inputFilePath, String outputFilePath, int compressionLevel) async {
  debugPrint(compressionLevel.toString());
  try {
    final inputFile = File(inputFilePath);
    final outputFile = File(outputFilePath);

    if (!await inputFile.exists()) {
      print('Input file not found.');
      return;
    }

    final inputBytes = await inputFile.readAsBytes();
    
    // Create a ZLibCodec with the specified compression level
    final codec = ZLibCodec(
      level: compressionLevel,
    );

    final compressedBytes = codec.encode(inputBytes);

    await outputFile.writeAsBytes(compressedBytes);
    print('Compression successful.');
  } catch (e) {
    print('Error compressing file: $e');
  }
}

Future<void> decompressFile(String inputFilePath, String outputFilePath) async {
  try {
    final inputFile = File(inputFilePath);
    final outputFile = File(outputFilePath);
    if (!await inputFile.exists()) {
      print('Input file not found.');
      return;
    }
    final inputBytes = await inputFile.readAsBytes();
    final decompressedBytes = zlib.decode(inputBytes);
    await outputFile.writeAsBytes(decompressedBytes);
    print('Decompression successful.');
  } catch (e) {
    print('Error decompressing file: $e');
  }
}
