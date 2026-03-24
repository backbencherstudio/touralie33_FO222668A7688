import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
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
  String? _errorMessage;
  bool _isDraggingSlider = false;
  double? _dragValueMs;
  bool _wasPlayingBeforeDrag = false;

  String _normalizeUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }
    if (trimmed.startsWith('http:/')) {
      return trimmed.replaceFirst('http:/', 'http://');
    }
    if (trimmed.startsWith('https:/')) {
      return trimmed.replaceFirst('https:/', 'https://');
    }
    return trimmed;
  }

  VideoPlayerController _buildController(String url) {
    final normalizedUrl = _normalizeUrl(url);
    if (normalizedUrl.startsWith('http://') ||
        normalizedUrl.startsWith('https://')) {
      return VideoPlayerController.networkUrl(Uri.parse(normalizedUrl));
    }
    return VideoPlayerController.file(File(normalizedUrl));
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller?.removeListener(_refresh);
      _controller?.dispose();
      _controller = null;
      _showVideo = false;
      _isInitializing = false;
      _errorMessage = null;
      _isDraggingSlider = false;
      _dragValueMs = null;
      _wasPlayingBeforeDrag = false;
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_refresh);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _startVideo() async {
    if (_showVideo || _isInitializing || widget.videoUrl.isEmpty) return;

    setState(() {
      _isInitializing = true;
      _errorMessage = null;
    });

    final VideoPlayerController controller = _buildController(widget.videoUrl);

    try {
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      _controller = controller;
      _controller!.addListener(_refresh);
      await _controller!.setVolume(_isMuted ? 0 : 1);
      await _controller!.play();
      setState(() {
        _showVideo = true;
      });
    } catch (e) {
      debugPrint("Video Error: $e");
      await controller.dispose();
      if (mounted) {
        setState(() {
          _errorMessage = 'Video could not be loaded.';
        });
      }
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

  Future<void> _togglePlayback() async {
    if (_controller == null || !(_controller!.value.isInitialized)) return;
    if (_controller!.value.isPlaying) {
      await _controller!.pause();
    } else {
      await _controller!.play();
    }
    if (mounted) setState(() {});
  }

  Future<void> _seekToMilliseconds(double milliseconds) async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final int durationMs = _controller!.value.duration.inMilliseconds;
    final int safeMs = milliseconds.round().clamp(0, durationMs < 0 ? 0 : durationMs);
    await _controller!.seekTo(Duration(milliseconds: safeMs));
    if (mounted) setState(() {});
  }

  Future<void> _seekRelativeSeconds(int seconds) async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final int currentMs = _controller!.value.position.inMilliseconds;
    final int targetMs = currentMs + (seconds * 1000);
    await _seekToMilliseconds(targetMs.toDouble());
  }

  Future<void> _onSliderChangeStart(double value) async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    _wasPlayingBeforeDrag = _controller!.value.isPlaying;
    if (_wasPlayingBeforeDrag) {
      await _controller!.pause();
    }
    if (!mounted) return;
    setState(() {
      _isDraggingSlider = true;
      _dragValueMs = value;
    });
  }

  void _onSliderChanged(double value) {
    setState(() {
      _dragValueMs = value;
    });
  }

  Future<void> _onSliderChangeEnd(double value) async {
    await _seekToMilliseconds(value);
    if (_wasPlayingBeforeDrag &&
        _controller != null &&
        _controller!.value.isInitialized) {
      await _controller!.play();
    }
    _wasPlayingBeforeDrag = false;
    if (!mounted) return;
    setState(() {
      _isDraggingSlider = false;
      _dragValueMs = null;
    });
  }

  String _formatDuration(Duration duration) {
    final int totalSeconds = duration.inMilliseconds <= 0
        ? 0
        : (duration.inMilliseconds / 1000).floor();
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

  Widget _buildThumbnail() {
    final thumbnail = _normalizeUrl(widget.thumbnailAsset);
    if (thumbnail.startsWith('http')) {
      return Image.network(
        thumbnail,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          ImageManager.gymGuide,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.asset(
      widget.thumbnailAsset.isEmpty
          ? ImageManager.gymGuide
          : widget.thumbnailAsset,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final VideoPlayerValue? playerValue = _controller?.value;
    final bool isReady = playerValue?.isInitialized ?? false;
    final Duration position = isReady ? playerValue!.position : Duration.zero;
    final Duration total = isReady ? playerValue!.duration : Duration.zero;
    final int totalMillisInt =
        total.inMilliseconds <= 0 ? 1 : total.inMilliseconds;
    final double totalMillis = totalMillisInt.toDouble();
    final double currentMillis = position.inMilliseconds
        .clamp(0, totalMillisInt)
        .toDouble();
    final double sliderValue = _isDraggingSlider
        ? (_dragValueMs ?? currentMillis).clamp(0, totalMillis)
        : currentMillis;
    final Duration displayPosition = _isDraggingSlider
        ? Duration(milliseconds: sliderValue.round())
        : position;

    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
        color: Colors.black,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!_showVideo) ...[
            Positioned.fill(child: _buildThumbnail()),
            if (_errorMessage != null)
              Positioned(
                left: 12.w,
                right: 12.w,
                bottom: 12.h,
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
          ] else ...[
            if (isReady)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _togglePlayback,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller!.value.size.width,
                          height: _controller!.value.size.height,
                          child: VideoPlayer(_controller!),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 180),
                        opacity:
                            (_controller?.value.isPlaying ?? false) ? 0 : 1,
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
                    ],
                  ),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4.h,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 6.r,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 10.r,
                        ),
                        activeTrackColor: const Color(0xFF91C759),
                        inactiveTrackColor: Colors.white.withValues(alpha: .28),
                        thumbColor: const Color(0xFF91C759),
                        overlayColor: const Color(0xFF91C759).withValues(alpha: .20),
                      ),
                      child: Slider(
                        value: sliderValue,
                        min: 0,
                        max: totalMillis,
                        onChangeStart:
                            isReady ? _onSliderChangeStart : null,
                        onChanged: isReady ? _onSliderChanged : null,
                        onChangeEnd: isReady ? _onSliderChangeEnd : null,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _seekRelativeSeconds(-10),
                          child: Icon(
                            Icons.replay_10_rounded,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: _togglePlayback,
                          child: Icon(
                            (playerValue?.isPlaying ?? false)
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () => _seekRelativeSeconds(10),
                          child: Icon(
                            Icons.forward_10_rounded,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          _formatDuration(displayPosition),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '/',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          _formatDuration(total),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _toggleMute,
                          child: Icon(
                            _isMuted
                                ? Icons.volume_off_outlined
                                : Icons.volume_up_outlined,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: _openFullScreen,
                          child: Icon(
                            Icons.fullscreen_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
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
  String? _errorMessage;

  String _normalizeUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }
    if (trimmed.startsWith('http:/')) {
      return trimmed.replaceFirst('http:/', 'http://');
    }
    if (trimmed.startsWith('https:/')) {
      return trimmed.replaceFirst('https:/', 'https://');
    }
    return trimmed;
  }

  VideoPlayerController _buildController(String url) {
    final normalizedUrl = _normalizeUrl(url);
    if (normalizedUrl.startsWith('http://') ||
        normalizedUrl.startsWith('https://')) {
      return VideoPlayerController.networkUrl(Uri.parse(normalizedUrl));
    }
    return VideoPlayerController.file(File(normalizedUrl));
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final VideoPlayerController controller = _buildController(widget.videoUrl);

    try {
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
    } catch (e) {
      debugPrint("Video Error: $e");
      await controller.dispose();
      if (mounted) {
        setState(() {
          _errorMessage = 'Video could not be loaded.';
        });
      }
    }
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
              child: _errorMessage != null
                  ? Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.white),
                    )
                  : _controller == null
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
                icon: const Icon(
                  Icons.fullscreen_exit_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
