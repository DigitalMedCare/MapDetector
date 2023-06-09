import 'dart:io';

import 'package:data_collector/image_display.dart';
import 'package:data_collector/server_side.dart';
import 'package:data_collector/show.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:pixel_color_picker/pixel_color_picker.dart';

class PixelDetection extends StatefulWidget {
  const PixelDetection({super.key, this.imageFile});
  final File? imageFile;

  @override
  State<PixelDetection> createState() => _PixelDetectionState();
}

class _PixelDetectionState extends State<PixelDetection> {
  Color? color;
  late File Image = widget.imageFile!;

  @override
  void initState() {
    setState(() {
      Image = widget.imageFile!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Data Collector').tr()),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: PixelColorPicker(
              onChanged: (color) {
                setState(() {
                  this.color = color;
                });
              },
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(widget.imageFile!),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: color,
                  child: const Text(''),
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                Text(
                  color.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: color == null
                ? Text('Detect a pixel color ')
                : ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ImageDisplayPage(paintedImage: widget.imageFile!),
                        ),
                      );
                      ServerSide.uploadOneImage(
                        widget.imageFile!,
                        color!,
                      );
                    },
                    child: const Text('Upload Image')),
          )
        ],
      ),
    );
  }
}
