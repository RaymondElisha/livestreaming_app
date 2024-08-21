import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'agora_config.dart';
import 'package:provider/provider.dart';
import 'stream_provider.dart';

class StreamerScreen extends StatefulWidget {
  const StreamerScreen({super.key});

  @override
  _StreamerScreenState createState() => _StreamerScreenState();
}

class _StreamerScreenState extends State<StreamerScreen> {
  final _channelController = TextEditingController();
  bool _isStreaming = false;
  
  get AgoraRtcEngine => null;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  void _startStreaming() async {
    if (_channelController.text.isNotEmpty) {
      print('Starting streaming...');
      await _initializeAgora();
      print('Agora initialized.');
      await AgoraRtcEngine.joinChannel(null, _channelController.text, null, 0);
      print('Joined channel: ${_channelController.text}');
      Provider.of<CustomStreamProvider>(context, listen: false).addStream(_channelController.text);
      setState(() {
        _isStreaming = true;
      });
    } else {
      print('Channel name is empty.');
    }
  }

  Future<void> _initializeAgora() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
    print('Agora engine created and video enabled.');
  }

  void _endStreaming() async {
    await AgoraRtcEngine.leaveChannel();
    await AgoraRtcEngine.destroy();
    setState(() {
      _isStreaming = false;
    });
    print('Ended streaming.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Streaming'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_isStreaming) ...[
              TextField(
                controller: _channelController,
                decoration: const InputDecoration(
                  labelText: 'Stream Name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startStreaming,
                child: const Text('Start Stream'),
              ),
            ] else ...[
              Text('Streaming: ${_channelController.text}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _endStreaming,
                child: const Text('End Stream'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
