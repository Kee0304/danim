import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/camera_view_model.dart';
import './record_screen.dart';

class CameraView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CameraViewModel>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: viewModel.initializeCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Failed to initialize camera: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return SafeArea(
                child: Scaffold(
                  body: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        // 카메라 화면
                        CameraPreview(viewModel.controller),

                        // 버튼들
                        Positioned(
                          // 위치 지정
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 130,
                            color: Colors.black38,
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left:25.0),
                                      width: 60,
                                      height: 60,
                                    ),
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(45)
                                      ),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.camera,
                                          color: Colors.white,
                                          size: 70,
                                        ),
                                        onPressed: () {
                                          if (viewModel.allFileList.length < 9) {
                                            viewModel.takePhoto();

                                            } else {
                                              viewModel.showAlert(context);
                                            }
                                          },
                                      )
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right:25.0),
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                          borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: IconButton(
                                        // icon:  viewModel.allFileList.isNotEmpty ?
                                        //         Image.file(File(viewModel.allFileList.last))
                                        //     : const Icon(
                                        //         Icons.folder,
                                        //       color: Colors.white,
                                        //     ),
                                        icon: const Icon(
                                                Icons.folder,
                                                color: Colors.white
                                          ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChangeNotifierProvider(
                                                create: (_) => CameraViewModel(),
                                                child: RecordView(viewModel.allFileList),
                                              ),
                                            ),
                                          );
                                        },
                                          ),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}