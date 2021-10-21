import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileSelector extends StatelessWidget {
  final Function(List<String> list) returnImages;

  const FileSelector(this.returnImages, {Key? key}) : super(key: key);

  bool _isImage(String path) {
    var images = ['jpg', 'jpeg', 'png'];
    var ext = path.split('.').last;

    for (String image in images) {
      if (ext == image) {
        return true;
      }
    }

    return false;
  }

  Future<List<String>> _dirContent(Directory dir) {
    var files = <String>[];
    var completer = Completer<List<String>>();
    var lister = dir.list(recursive: true);

    lister.listen((file) {
      if (_isImage(file.path)) {
        files.add(file.path);
      }
    }, onDone: () => completer.complete(files));

    return completer.future;
  }

  void _selectFiles() async {
    String? path = await FilePicker.platform
        .getDirectoryPath(dialogTitle: 'Select a picture folder');

    var dir = Directory(path!);
    var content = await _dirContent(dir);

    returnImages(content);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          child: const Text('Select files'),
          onPressed: () async {
            _selectFiles();
          },
        ),
      ],
    );
  }
}
