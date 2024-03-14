import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:compression/compression_decompression.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController textController = TextEditingController();
  double sliderValue = 1;
  List<String>? filePaths;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(onPressed: () async{
            if(filePaths!=null && filePaths!.isNotEmpty) {
              for(int i = 0; i < filePaths!.length; ++i) {
                if(filePaths![i].toLowerCase().endsWith('png')) {
                  await compressPng(filePaths![i], "${filePaths![i]}.com.rafi", sliderValue.toInt() ~/ 10);
                } else {
                  debugPrint("HERE");
                  await compressFile(filePaths![i], "${filePaths![i]}.com.rafi", sliderValue.toInt() ~/ 10);
                }
              }
            }
          }, label: const Text('Compress')),
          FloatingActionButton.extended(onPressed: () async{
            for(int i = 0; i < filePaths!.length; ++i) {
                if(filePaths![i].toLowerCase().endsWith('rafi') && filePaths![i].toLowerCase().contains('.png')) {
                  await decompressPng(filePaths![i], "${filePaths![i]}.decom.rafi");
                } else if(filePaths![i].toLowerCase().endsWith('rafi') && !filePaths![i].toLowerCase().contains('.png')){
                  debugPrint("HERE");
                  await decompressFile(filePaths![i], "${filePaths![i]}.decom.rafi");
                }
              }
          }, label: const Text('Decompress'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Input Properties',
                  style: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Container(
                  color: Colors.black,
                  height: 2,
                ))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Input File(s):'),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 12)),
                        ))),
                const SizedBox(
                  width: 8,
                ),
                _buttonPreview(50, 80, 'Browse', onTap: () async {
                  filePaths = await FilePicker.platform
                      .pickFiles(
                    type: FileType.any,
                    allowMultiple: true,
                  )
                      .then((result) {
                    if (result != null) {
                      return result.files.map((file) => file.path!).toList();
                    }
                    return null;
                  });

                  if (filePaths != null && filePaths!.isNotEmpty) {
                    for (int i = 0; i < filePaths!.length; ++i) {
                      textController.text = "${filePaths![i]}, ";
                    }
                  }

                  debugPrint(filePaths.toString());
                }),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Text(
                  'Compression Properties',
                  style: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Container(
                  color: Colors.black,
                  height: 2,
                ))
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Compression Ratio:'),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Slider(
                        value: sliderValue,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value.round().toDouble();
                          });
                        },
                        min: 0,
                        max: 90,
                      ),
                      SizedBox(height: 4,),
                      Text("$sliderValue%")
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buttonPreview(double height, double width, String text,
      {GestureTapCallback? onTap}) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      minimumSize: Size(width, height),
      backgroundColor: Colors.grey,
      padding: const EdgeInsets.all(0),
    );
    return TextButton(
      style: flatButtonStyle,
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
