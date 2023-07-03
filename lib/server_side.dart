import 'dart:io';
import 'dart:ui';

import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import 'dart:typed_data';
import 'package:flutter/services.dart';

class ServerSide {
  static void uploadTwoImage(
      File imageFile, File normalImage, Color color) async {
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    int alpha = (color.opacity * 255).toInt();
    // Create a multipart request
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://mapdetectorserver.xyz/apiupload'));

    // Add the image file and color tuple to the request
    request.files.add(await http.MultipartFile.fromPath(
      'image1',
      imageFile.path,
    ));
    request.files.add(await http.MultipartFile.fromPath(
      'image2',
      normalImage.path,
    ));
    request.fields['color'] = '$red,$green,$blue,$alpha';

    // Send the request
    var response = await request.send();

    // Check the response status code and print the response body
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print('Error uploading image: ${response.reasonPhrase}');
    }
  }

  static void uploadOneImage(File imageFile, Color color) async {
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    int alpha = (color.opacity * 255).toInt();
    // Create a multipart request
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://mapdetectorserver.xyz/apiupload'));

    // Add the image file and color tuple to the request
    request.files.add(await http.MultipartFile.fromPath(
      'image1',
      imageFile.path,
    ));
    request.fields['color'] = '$red,$green,$blue,$alpha';

    // Send the request
    var response = await request.send();

    // Check the response status code and print the response body
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print('Error uploading image: ${response.reasonPhrase}');
    }
  }
}
