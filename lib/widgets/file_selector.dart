import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';

class FileSelector extends StatefulWidget {
  final VoidCallback resetFiles;
  final Function(List<String> list) returnImages;

  const FileSelector(this.returnImages, this.resetFiles, {Key? key})
      : super(key: key);

  @override
  State<FileSelector> createState() => _FileSelectorState();
}

class _FileSelectorState extends State<FileSelector> {
  final List<Uri> _list = [];
  bool _dragging = false;

  void _extractLinks(List<Uri> urls) async {
    var images = <String>[];

    for (var url in urls) {
      if (_isDirectory(url.toFilePath())) {
        var content = await _dirContent(Directory(url.toFilePath()));
        images.addAll(content);
      } else {
        images.add(url.toFilePath());
      }
    }

    widget.returnImages(images);
  }

  bool _isDirectory(String path) {
    var filename = path.split('\\').last;
    return filename.split('.').length <= 1;
  }

  bool _isImage(String path) {
    var images = ['jpg', 'jpeg', 'png'];
    var name = path.split('\\').last;
    var ext = name.split('.').last;

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

    if (path != null) {
      var dir = Directory(path);
      var content = await _dirContent(dir);
      widget.returnImages(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Select files'),
              onPressed: () async {
                _selectFiles();
              },
            ),
            const SizedBox(width: 10),
            ElevatedButton(
                child: const Text('Clear files'),
                onPressed: () {
                  widget.resetFiles();
                }),
          ],
        ),
        const SizedBox(height: 25),
        DropTarget(
          onDragDone: (detail) {
            _extractLinks(detail.urls);
          },
          onDragEntered: (detail) {
            setState(() {
              _dragging = true;
            });
          },
          onDragExited: (detail) {
            setState(() {
              _dragging = false;
            });
          },
          child: Container(
            height: 200,
            width: 200,
            color: _dragging ? Colors.blue.withOpacity(0.4) : Colors.black26,
            child: _list.isEmpty
                ? const Center(child: Text("Drop here"))
                : Text(_list.join("\n")),
          ),
        ),
      ],
    );
  }
}
