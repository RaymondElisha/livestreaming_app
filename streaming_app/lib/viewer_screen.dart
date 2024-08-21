import 'package:flutter/material.dart';
//import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:provider/provider.dart';
import 'agora_config.dart';
import 'stream_provider.dart';

class ViewerScreen extends StatelessWidget {
  const ViewerScreen({super.key});

  get AgoraRtcEngine => null;

  @override
  Widget build(BuildContext context) {
    final streams = context.watch<CustomStreamProvider>().streams;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Streams'),
      ),
      body: ListView.builder(
        itemCount: streams.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(streams[index]),
            onTap: () async {
              await _initializeAgora();
              await AgoraRtcEngine.joinChannel(null, streams[index], null, 0);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StreamViewer(streamName: streams[index])),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _initializeAgora() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
  }
}

class StreamViewer extends StatelessWidget {
  final String streamName;

  const StreamViewer({super.key, required this.streamName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viewing $streamName'),
      ),
      body: const Center(
        child: Text('Stream content goes here'),
      ),
    );
  }
}
