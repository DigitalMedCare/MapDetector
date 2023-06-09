import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:data_collector/image_display.dart';
import 'package:data_collector/server_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_painting_tools/flutter_painting_tools.dart';
import 'package:path_provider/path_provider.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({Key? key, this.imageFile, this.imageWidth, this.imageHeight})
      : super(key: key);
  final File? imageFile;
  final int? imageWidth;
  final int? imageHeight;
  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  // Declare the controller
  late final PaintingBoardController controller;
  final GlobalKey _paintKey = GlobalKey();
  ui.Image? paintedImage;
  late File editedImageFile;
  late bool imageSaved = false;
  late Color penColor = Color(23);

  @override
  void initState() {
    // Init the controller
    controller = PaintingBoardController();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose the controller
    controller.dispose();
    super.dispose();
  }

  Future<ui.Image> _captureImage() async {
    RenderRepaintBoundary boundary =
        _paintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
          actions: [
            IconButton(
              // delete last line when this button is pressed
              onPressed: () => controller.deleteLastLine(),
              icon: const Icon(Icons.undo_rounded),
            ),
            IconButton(
              // Delete everything inside the board when this button is pressed
              onPressed: () => controller.deletePainting(),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final boardWidth = constraints.maxWidth * 0.9;
          final boardHeight = constraints.maxHeight * 0.5;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              PaintingColorBar(
                controller:
                    controller, // use here the controller defined before
                paintingColorBarMargin:
                    const EdgeInsets.symmetric(horizontal: 6),
                colorsType: ColorsType.material,
                onTap: (Color color) {
                  // do your logic here with the pressed color, for example change the color of the brush

                  print('tapped color: $color');
                  controller.changeBrushColor(color);
                  penColor = color;
                },
              ),
              const SizedBox(height: 50),
              Center(
                // Use here the PaintingBoard
                child: RepaintBoundary(
                  key: _paintKey,
                  child: PaintingBoard(
                    boardDecoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(widget.imageFile ??
                            File('')), // set a default empty file if null
                        fit: BoxFit.fill,
                      ),
                    ),
                    boardHeight: boardHeight,
                    boardWidth: boardWidth,
                    controller: controller, // use here the controller
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      paintedImage = await _captureImage();
                      ByteData? pngBytes = await paintedImage!
                          .toByteData(format: ui.ImageByteFormat.png);

                      editedImageFile =
                          await _saveImage(pngBytes!.buffer.asUint8List());
                      setState(() {
                        imageSaved = true;
                      });

                      print(
                          'Saved edited image to file: ${editedImageFile.path}');
                    },
                    child: const Text('Save your edit'),
                  ),
                  const SizedBox(width: 10),
                  imageSaved == false
                      ? const Text('Save your edit please')
                      : ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageDisplayPage(
                                    paintedImage: editedImageFile),
                              ),
                            );
                            ServerSide.uploadTwoImage(
                              editedImageFile,
                              widget.imageFile!,
                              penColor,
                            );
                          },
                          child: const Text('Get painted image'),
                        ),
                ],
              ),
            ],
          );
        }));
  }

  Future<File> _saveImage(List<int> bytes) async {
    Directory? directory = await getExternalStorageDirectory();
    File file = File('${directory!.path}/edited_image.png');
    await file.writeAsBytes(bytes);
    return file;
  }
}
