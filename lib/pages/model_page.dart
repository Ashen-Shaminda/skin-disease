import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:developer' as devtools;

import 'package:skin_diseases_detection_system/services/user_data_service.dart';

import '../services/auth/auth_service.dart';

class ModelPage extends StatefulWidget {
  const ModelPage({super.key});

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  File? filePath;
  String label = '';
  double confidence = 0.0;
  late User _user;
  final _auth = AuthService();

  Future<void> _tfLteInit() async {
    // ignore: unused_local_variable
    String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1,
        // defaults to 1
        isAsset: true,
        // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  recognition() {}

  @override
  void initState() {
    //
    super.initState();
    _tfLteInit();
    _user = _auth.getCurrentUser()!;
  }

  pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        // required
        imageMean: 0.0,
        // defaults to 117.0
        imageStd: 255.0,
        // defaults to 1.0
        numResults: 2,
        // defaults to 5
        threshold: 0.2,
        // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      devtools.log("recognitions is Null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
      UserDataService(confidence: confidence, label: label).saveUserData();
    });
    await _uploadImageToFirebaseStorage();
  }

  pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        // required
        imageMean: 0.0,
        // defaults to 117.0
        imageStd: 255.0,
        // defaults to 1.0
        numResults: 2,
        // defaults to 5
        threshold: 0.2,
        // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      devtools.log("recognitions is Null");
      return;
    }
    devtools.log(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
      UserDataService(confidence: confidence, label: label).saveUserData();
    });

    await _uploadImageToFirebaseStorage();
  }

  Future<void> _uploadImageToFirebaseStorage() async {
    if (filePath == null) return;

    // Upload the image to Firebase Storage
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('userInfo')
        .child(_user.uid)
        .child('user_disease.jpg');
    final UploadTask uploadTask = storageRef.putFile(filePath!);

    // Await the completion of the upload task
    await uploadTask.whenComplete(() => print('Image uploaded'));

    // Optionally, you can get the download URL of the uploaded image
    final String downloadUrl = await storageRef.getDownloadURL();
    print('Download URL: $downloadUrl');
  }

  @override
  void dispose() {
    //
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 12,
          ),
          Card(
            elevation: 20,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: 330,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 280,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/upload.jpg'),
                        ),
                      ),
                      child: filePath == null
                          ? const Text('')
                          : Image.file(
                              filePath!,
                              fit: BoxFit.fill,
                            ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          LinearPercentIndicator(
                            backgroundColor: CupertinoColors.systemGrey4,
                            lineHeight: 30,
                            percent: confidence / 100,
                            animation: true,
                            animationDuration: 700,
                            barRadius: const Radius.circular(7),
                            progressColor: CupertinoColors.systemGrey2,
                            center: Text("${confidence.toStringAsFixed(0)}%"),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "Accuracy",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  pickImageCamera();
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    foregroundColor: Colors.black),
                child: const Text(
                  "Open Camera",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  pickImageGallery();
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    foregroundColor: Colors.black),
                child: const Text(
                  "Pick From Gallery",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {

            },
            style: ElevatedButton.styleFrom(
                splashFactory: InkSparkle.splashFactory,
                backgroundColor: CupertinoColors.opaqueSeparator,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                foregroundColor: Colors.black),
            child: const Text(
              "View more info.",
            ),
          ),
        ],
      ),
    );
  }


}
