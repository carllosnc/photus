import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '/imports/app.dart';

class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const PlayerWidget({
    required this.player,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    widget.player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration?>(
      stream: widget.player.durationStream,
      builder: (context, snapshot) {
        final duration = snapshot.data ?? Duration.zero;

        widget.player.play();

        return StreamBuilder<Duration?>(
          stream: widget.player.positionStream,
          builder: (context, snapshot) {
            var position = snapshot.data ?? Duration.zero;

            if (position > duration) {
              position = duration;
            }

            if (position == duration) {
              widget.player.seek(Duration.zero);
              widget.player.pause();
            }

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Colors.white.withOpacity(0.18),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(widget.player.playing ? Icons.pause : Icons.play_arrow),
                        onPressed: () {
                          if (widget.player.playing) {
                            widget.player.pause();
                          } else {
                            widget.player.play();
                          }
                        },
                      ),
                      Text(
                        position.formattedDuration,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: position.inMilliseconds.toDouble(),
                          min: 0.0,
                          max: duration.inMilliseconds.toDouble(),
                          onChanged: (value) {
                            widget.player.seek(Duration(milliseconds: value.toInt()));
                          },
                        ),
                      ),
                      Text(
                        duration.formattedDuration,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
