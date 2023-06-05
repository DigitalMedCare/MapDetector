import 'dart:io';

import 'package:data_collector/image_display.dart';
import 'package:data_collector/server_side.dart';
import 'package:data_collector/show.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:pixel_color_picker/pixel_color_picker.dart';

class PageFive extends StatefulWidget {
  final File? imageFile;
  final int? imageWidth;
  final int? imageHeight;
  const PageFive(
      {super.key, this.imageFile, this.imageWidth, this.imageHeight});

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
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
                    Positioned(
                      bottom: 0.0,
                      right: 50.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowImage(
                                  imageFile: widget.imageFile,
                                  imageHeight: widget.imageHeight,
                                  imageWidth: widget.imageWidth,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.draw),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
        ],
      ),
    );
  }
}
