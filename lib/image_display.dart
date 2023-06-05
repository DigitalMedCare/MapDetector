// import 'package:image_painter/image_painter.dart';

// import 'package:path_provider/path_provider.dart';

// class ImagePainterExample extends StatefulWidget {
//   const ImagePainterExample({super.key, this.imageFile});
//   final File? imageFile;

//   @override
//   _ImagePainterExampleState createState() => _ImagePainterExampleState();
// }

// class _ImagePainterExampleState extends State<ImagePainterExample> {
//   final _imageKey = GlobalKey<ImagePainterState>();
//   final _key = GlobalKey<ScaffoldState>();
//   late Uint8List? _editedImageBytes;

//   Future<void> _saveChanges() async {
//     final imagePainterState = _imageKey.currentState!;
//     final imageData = await imagePainterState.exportImage();
//     setState(() {
//       _editedImageBytes = imageData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _key,
//       appBar: AppBar(
//         title: Center(child: const Text('Data Collector').tr()),
//         backgroundColor: Colors.green,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save_alt),
//             onPressed: _saveChanges,
//           ),
//           IconButton(
//             icon: const Icon(Icons.next_plan),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ShowImage(image: _editedImageBytes),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//       body: ImagePainter.file(
//         widget.imageFile!,
//         key: _imageKey,
//         scalable: true,
//         initialStrokeWidth: 2,
//         initialColor: Colors.green,
//         initialPaintMode: PaintMode.line,
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ImageDisplayPage extends StatelessWidget {
  const ImageDisplayPage({Key? key, required this.paintedImage})
      : super(key: key);
  final File paintedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painted Image'),
      ),
      body: Center(
        child: Image.file(paintedImage),
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image paintedImage;

  ImagePainter(this.paintedImage);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(paintedImage, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
