import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mogulog/data/notifiers.dart';
import 'package:mogulog/theme/app_colors.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with WidgetsBindingObserver {
  List<CameraDescription> cameras = const [];
  CameraController? controller;
  int selectedCameraIndex = 0;
  bool isInitializingCamera = true;
  bool isTakingPicture = false;
  bool flashEnabled = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final currentController = controller;
    if (currentController == null || !currentController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      currentController.dispose();
      controller = null;
    } else if (state == AppLifecycleState.resumed) {
      initializeSelectedCamera();
    }
  }

  Future<void> initializeCamera() async {
    setState(() {
      isInitializingCamera = true;
      errorMessage = null;
    });

    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw CameraException(
          'NoCamera',
          'No available camera was found on this device.',
        );
      }

      if (selectedCameraIndex >= cameras.length) {
        selectedCameraIndex = 0;
      }

      await initializeSelectedCamera();
    } on CameraException catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        errorMessage = error.description ?? error.code;
        isInitializingCamera = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        errorMessage = 'Unable to start the camera.';
        isInitializingCamera = false;
      });
    }
  }

  Future<void> initializeSelectedCamera() async {
    if (cameras.isEmpty) {
      return;
    }

    final nextController = CameraController(
      cameras[selectedCameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await nextController.initialize();
      await nextController.setFlashMode(
        flashEnabled ? FlashMode.torch : FlashMode.off,
      );

      final previousController = controller;
      if (!mounted) {
        await nextController.dispose();
        return;
      }

      setState(() {
        controller = nextController;
        isInitializingCamera = false;
        errorMessage = null;
      });

      await previousController?.dispose();
    } on CameraException catch (error) {
      await nextController.dispose();
      if (!mounted) {
        return;
      }

      setState(() {
        errorMessage = error.description ?? error.code;
        isInitializingCamera = false;
      });
    }
  }

  Future<void> toggleFlash() async {
    final currentController = controller;
    if (currentController == null || !currentController.value.isInitialized) {
      return;
    }

    final nextFlashEnabled = !flashEnabled;
    try {
      await currentController.setFlashMode(
        nextFlashEnabled ? FlashMode.torch : FlashMode.off,
      );
      if (!mounted) {
        return;
      }

      setState(() {
        flashEnabled = nextFlashEnabled;
      });
    } on CameraException {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Flash is not available on this camera.')),
      );
    }
  }

  Future<void> switchCamera() async {
    if (cameras.length < 2) {
      return;
    }

    setState(() {
      selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
      isInitializingCamera = true;
    });

    await initializeSelectedCamera();
  }

  Future<void> captureImage() async {
    final currentController = controller;
    if (currentController == null ||
        !currentController.value.isInitialized ||
        isTakingPicture) {
      return;
    }

    setState(() {
      isTakingPicture = true;
    });

    try {
      final file = await currentController.takePicture();
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Saved photo: ${file.name}')));
    } on CameraException catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.description ?? 'Failed to capture photo.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isTakingPicture = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            selectedPageNotifier.value = 0;
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Upload Meal'),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (controller != null && controller!.value.isInitialized)
            _FullScreenCameraPreview(controller: controller!)
          else
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF3D434A), Color(0xFF111214)],
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.28),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.38),
                ],
              ),
            ),
          ),
          const _CameraGridOverlay(),
          if (isInitializingCamera)
            const Center(
              child: CircularProgressIndicator(color: AppColors.orange),
            ),
          if (errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: initializeCamera,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(24, 24, 24, 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RoundCameraButton(
                    icon: flashEnabled ? Icons.flash_on : Icons.flash_off,
                    onTap: toggleFlash,
                  ),
                  GestureDetector(
                    onTap: captureImage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      width: isTakingPicture ? 82 : 88,
                      height: isTakingPicture ? 82 : 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          width: isTakingPicture ? 42 : 68,
                          height: isTakingPicture ? 42 : 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isTakingPicture
                                ? Colors.white
                                : AppColors.orange,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _RoundCameraButton(
                    icon: Icons.cameraswitch_outlined,
                    onTap: switchCamera,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FullScreenCameraPreview extends StatelessWidget {
  final CameraController controller;

  const _FullScreenCameraPreview({required this.controller});

  @override
  Widget build(BuildContext context) {
    final previewSize = controller.value.previewSize;
    if (previewSize == null) {
      return CameraPreview(controller);
    }

    return ClipRect(
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: previewSize.height,
            height: previewSize.width,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );
  }
}

class _CameraGridOverlay extends StatelessWidget {
  const _CameraGridOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: CustomPaint(painter: _CameraGridPainter()));
  }
}

class _CameraGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1;

    final thirdWidth = size.width / 3;
    final thirdHeight = size.height / 3;

    for (var i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(thirdWidth * i, 0),
        Offset(thirdWidth * i, size.height),
        paint,
      );
      canvas.drawLine(
        Offset(0, thirdHeight * i),
        Offset(size.width, thirdHeight * i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoundCameraButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundCameraButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.18),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
