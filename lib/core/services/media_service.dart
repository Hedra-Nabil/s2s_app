import 'dart:io';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:s2s_app/core/utils/response.dart';

class MediaService {
  final ImagePicker _imagePicker = ImagePicker();
  final AudioRecorder _audioRecorder = AudioRecorder();
  List<CameraDescription>? _cameras;

  // Initialize cameras
  Future<void> initializeCameras() async {
    try {
      _cameras = await availableCameras();
    } catch (e) {
      _cameras = [];
    }
  }

  // Get available cameras
  List<CameraDescription> get cameras => _cameras ?? [];

  // Request camera permission
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  // Request microphone permission
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  // Request storage permission
  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  // Pick image from gallery
  Future<Response<File?>> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        return Response.success(File(image.path));
      } else {
        return Response.error('No image selected');
      }
    } catch (e) {
      return Response.error('Error picking image: ${e.toString()}');
    }
  }

  // Take photo with camera
  Future<Response<File?>> takePhoto() async {
    try {
      final hasPermission = await requestCameraPermission();
      if (!hasPermission) {
        return Response.error('Camera permission denied');
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        return Response.success(File(image.path));
      } else {
        return Response.error('No image captured');
      }
    } catch (e) {
      return Response.error('Error taking photo: ${e.toString()}');
    }
  }

  // Pick video from gallery
  Future<Response<File?>> pickVideoFromGallery() async {
    try {
      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
      );

      if (video != null) {
        return Response.success(File(video.path));
      } else {
        return Response.error('No video selected');
      }
    } catch (e) {
      return Response.error('Error picking video: ${e.toString()}');
    }
  }

  // Record video with camera
  Future<Response<File?>> recordVideo() async {
    try {
      final hasPermission = await requestCameraPermission();
      if (!hasPermission) {
        return Response.error('Camera permission denied');
      }

      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.camera,
      );

      if (video != null) {
        return Response.success(File(video.path));
      } else {
        return Response.error('No video recorded');
      }
    } catch (e) {
      return Response.error('Error recording video: ${e.toString()}');
    }
  }

  // Pick file
  Future<Response<File?>> pickFile({
    List<String>? allowedExtensions,
  }) async {
    try {
      final hasPermission = await requestStoragePermission();
      if (!hasPermission) {
        return Response.error('Storage permission denied');
      }

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.single.path != null) {
        return Response.success(File(result.files.single.path!));
      } else {
        return Response.error('No file selected');
      }
    } catch (e) {
      return Response.error('Error picking file: ${e.toString()}');
    }
  }

  // Start audio recording
  Future<Response<void>> startAudioRecording(String path) async {
    try {
      final hasPermission = await requestMicrophonePermission();
      if (!hasPermission) {
        return Response.error('Microphone permission denied');
      }

      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(
          const RecordConfig(),
          path: path,
        );
        return Response.success(null);
      } else {
        return Response.error('Microphone permission denied');
      }
    } catch (e) {
      return Response.error('Error starting recording: ${e.toString()}');
    }
  }

  // Stop audio recording
  Future<Response<String?>> stopAudioRecording() async {
    try {
      final path = await _audioRecorder.stop();
      return Response.success(path);
    } catch (e) {
      return Response.error('Error stopping recording: ${e.toString()}');
    }
  }

  // Check if recording
  Future<bool> isRecording() async {
    return await _audioRecorder.isRecording();
  }

  // Dispose
  void dispose() {
    _audioRecorder.dispose();
  }
}

