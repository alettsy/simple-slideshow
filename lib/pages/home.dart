import 'package:flutter/material.dart';
import 'package:slideshow/pages/slideshow.dart';
import 'package:slideshow/widgets/file_selector.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _files = [];

  void _getFiles(List<String> files) {
    setState(() {
      _files.addAll(files);
    });
  }

  void _resetFiles() {
    setState(() {
      _files.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slideshow Home'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            FileSelector(_getFiles, _resetFiles),
            const SizedBox(height: 50),
            Text(
              'Total files: ${_files.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              child: const Text('Start SlideShow'),
              onPressed: _files.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SlideShowPage(_files),
                        ),
                      );
                    }
                  : null,
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
