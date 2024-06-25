
import 'package:active_fit_user/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class DetalleEjercicioScreen extends StatefulWidget {
  final String videoUrl;
  final String nombre;
  final String descripcion;
  static const name = '/detalleEjercicio';

  const DetalleEjercicioScreen({
    Key? key,
    required this.videoUrl,
    required this.nombre,
    required this.descripcion,
  }) : super(key: key);

  @override
  _DetalleEjercicioScreenState createState() => _DetalleEjercicioScreenState();
}

class _DetalleEjercicioScreenState extends State<DetalleEjercicioScreen> {
  late YoutubePlayerController _controller;
  bool _expanded = true;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null) {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    } else {
      print(widget.videoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.textFieldBgColor,
      appBar: AppBar(
        backgroundColor: AppTheme.scaffoldBbColor,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Card(
                  margin: EdgeInsets.all(16.0),
                  elevation: 4,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.blue,
                      handleColor: Colors.blueAccent,
                    ),
                    controlsTimeOut: Duration(seconds: 5),
                    aspectRatio:
                        16 / 9,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _expanded = _expanded;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _expanded ? 400.0 : 100.0,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteTextColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.nombre,
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              widget.descripcion,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildExerciseDetailsTab(String nombre, String descripcion) {
    return Container(
      height: 400.0,
      width: 350, // Adjust height as needed
      decoration: BoxDecoration(
        color: AppTheme.whiteTextColor, // Use a color from your theme
        borderRadius: BorderRadius.circular(10.0), // Add some rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              descripcion,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
