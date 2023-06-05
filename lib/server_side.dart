import 'dart:io';
import 'dart:ui';

import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class ServerSide {
  static void uploadImage(File imageFile, Color color) async {
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    int alpha = (color.opacity * 255).toInt();
    // Create a multipart request
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://mapdetectorserver.xyz/apiupload'));

    // Add the image file and color tuple to the request
    request.files.add(await http.MultipartFile.fromPath(
      'image',
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
