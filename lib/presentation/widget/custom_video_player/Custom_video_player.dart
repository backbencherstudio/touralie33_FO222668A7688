import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String thumbnailAsset;

  const CustomVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.thumbnailAsset,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? _controller;
  bool _isInitializing = false;
  bool _showVideo = false;
  bool _isMuted = false;

  @override
  void dispose() {
    _controller?.removeListener(_refresh);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _startVideo() async {
    if (_showVideo || _isInitializing) return;

    setState(() {
      _isInitializing = true;
    });

    final VideoPlayerController controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    try {
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      _controller = controller;
      _controller!.addListener(_refresh);
      await _controller!.play();
      setState(() {
        _showVideo = true;
      });
    } catch (_) {
      await controller.dispose();
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  String _formatDuration(Duration duration) {
    final int totalSeconds = duration.inSeconds;
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;

    String two(int n) => n.toString().padLeft(2, '0');
    if (hours > 0) {
      return '${two(hours)}:${two(minutes)}:${two(seconds)}';
    }
    return '${two(minutes)}:${two(seconds)}';
  }

  Future<void> _openFullScreen() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    final Duration position = _controller!.value.position;
    final bool wasPlaying = _controller!.value.isPlaying;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _FullScreenVideoPlayer(
          videoUrl: widget.videoUrl,
          startFrom: position,
          autoPlay: wasPlaying,
        ),
      ),
    );
  }

  Future<void> _toggleMute() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    _isMuted = !_isMuted;
    await _controller!.setVolume(_isMuted ? 0 : 1);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isReady = _controller?.value.isInitialized ?? false;
    final Duration position = isReady ? _controller!.value.position : Duration.zero;
    final Duration total = isReady ? _controller!.value.duration : Duration.zero;

    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r),topRight: Radius.circular(12.r)),
        color: Colors.black,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!_showVideo) ...[
            Positioned.fill(
              child: Image.asset(widget.thumbnailAsset, fit: BoxFit.cover),
            ),
            GestureDetector(
              onTap: _startVideo,
              child: Container(
                height: 56.h,
                width: 56.w,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 34.sp,
                ),
              ),
            ),
            if (_isInitializing)
              const Center(child: CircularProgressIndicator(color: Colors.white)),
          ] else ...[
            if (isReady)
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller!.value.size.width,
                    height: _controller!.value.size.height,
                    child: VideoPlayer(_controller!),
                  ),
                ),
              )
            else
              const Center(child: CircularProgressIndicator(color: Colors.white)),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: .55),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!isReady) return;
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      },
                      child: Icon(
                        (_controller?.value.isPlaying ?? false)
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: SizedBox(
                        height: 3.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: VideoProgressIndicator(
                            _controller!,
                            allowScrubbing: true,
                            padding: EdgeInsets.zero,
                            colors: VideoProgressColors(
                              playedColor: const Color(0xFF91C759),
                              bufferedColor: Colors.white.withValues(alpha: .35),
                              backgroundColor: Colors.white.withValues(alpha: .25),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${_formatDuration(position)}/${_formatDuration(total)}',
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: _toggleMute,
                      child: Icon(
                        _isMuted ? Icons.volume_off_outlined : Icons.volume_up_outlined,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: Text(
                        'CC',
                        style: TextStyle(
                          color: ColorManager.blackColor,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: _openFullScreen,
                      child: Icon(
                        Icons.fullscreen_rounded,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.settings_outlined, color: Colors.white, size: 18.sp),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Duration startFrom;
  final bool autoPlay;

  const _FullScreenVideoPlayer({
    required this.videoUrl,
    required this.startFrom,
    required this.autoPlay,
  });

  @override
  State<_FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<_FullScreenVideoPlayer> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final VideoPlayerController controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    await controller.initialize();
    await controller.seekTo(widget.startFrom);
    if (widget.autoPlay) {
      await controller.play();
    }

    if (!mounted) {
      await controller.dispose();
      return;
    }

    setState(() {
      _controller = controller;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: _controller == null
                  ? const CircularProgressIndicator(color: Colors.white)
                  : AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    ),
            ),
            Positioned(
              top: 12.h,
              left: 12.w,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.fullscreen_exit_rounded, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
