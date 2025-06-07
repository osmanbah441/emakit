import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ai/firebase_ai.dart'; // Keep for FunctionCall type if needed by tools
import 'dart:async';
import 'dart:developer';
// Remove 'package:record/record.dart'; - managed by service
// Remove 'package:flutter_soloud/flutter_soloud.dart'; - managed by service
// Remove 'dart:typed_data'; - managed by service

import 'app_state.dart';
import 'tools.dart'; // Keep for tool definitions
import 'utils.dart'; // Keep for tool call handlers
import 'live_conversion_service.dart'; // Import the new service

class AudioAgenticAppManagerDemo extends StatelessWidget {
  const AudioAgenticAppManagerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const AgentManagedApp(),
    );
  }
}

class AgentManagedApp extends StatelessWidget {
  const AgentManagedApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppState manager = context.watch<AppState>();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: manager.appColor),
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: context.watch<AppState>().fontFamily,
          fontSizeFactor: context.watch<AppState>().fontSizeFactor,
        ),
      ),
      home: const AudioAgentApp(title: 'myMail'),
    );
  }
}

class AudioAgentApp extends StatefulWidget {
  const AudioAgentApp({super.key, required this.title});

  final String title;

  @override
  State<AudioAgentApp> createState() => _AudioAgentAppState();
}

class _AudioAgentAppState extends State<AudioAgentApp> {
  late final LiveConversionService _liveConversionService;

  // UI State flags - these will be updated by callbacks from the service
  bool _isSettingUpSession = false;
  bool _isSessionOpened =
      false; // You might not need this directly if _isConversationActive covers it
  bool _isConversationActive = false;
  bool _isAudioReady = false;

  // Store the AppState for easy access in tool calls
  late AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);

    _liveConversionService = LiveConversionService(
      systemInstruction: '''
      You are a friendly and helpful app concierge. Your job is to help the user
      get the best, frictionless app experience.
      If you have access to a tool that can configure the setting for
      the user and address their feedback, ALWAYS ask the user to confirm the
      change before making the change.
      ''',
      modelName:
          'gemini-2.0-flash-live-preview-04-09', // Ensure this is the correct model
      tools: [
        Tool.functionDeclarations([
          fontFamilyTool,
          fontSizeFactorTool,
          appThemeColorTool,
        ]),
      ],
      onStateChanged: (isSettingUp, sessionOpened, conversationActive) {
        if (mounted) {
          setState(() {
            _isSettingUpSession = isSettingUp;
            _isSessionOpened =
                sessionOpened; // Useful for knowing if underlying session is live
            _isConversationActive = conversationActive;
          });
        }
        log(
          "UI State Updated: SettingUp=$isSettingUp, SessionOpened=$sessionOpened, ConversationActive=$conversationActive",
        );
      },
      onTextMessageReceived: (text) {
        log('UI Received Text: $text');
        // Potentially display this text in the UI if needed, or just log
      },
      onFunctionCallReceived: (functionCalls) {
        log('UI Received FunctionCalls: ${functionCalls.map((fc) => fc.name)}');
        _handleFunctionCalls(functionCalls);
      },
      onTurnComplete: () {
        log('UI Notified: Turn Complete');
        // You might want to provide some feedback to the user
      },
      onError: (error) {
        log('UI Error: $error');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.red),
          );
          // Potentially reset UI state if a critical error occurs
          if (_isConversationActive) {
            // If an error occurs during an active conversation, try to stop it gracefully
            _liveConversionService.stopConversation().catchError((e) {
              log("Error trying to stop conversation after error: $e");
            });
          } else {
            setState(() {
              _isSettingUpSession = false;
              _isConversationActive = false;
            });
          }
        }
      },
      onAudioReadyStateChanged: (audioReady) {
        if (mounted) {
          setState(() {
            _isAudioReady = audioReady;
          });
          log("UI Notified: Audio Ready = $audioReady");
          if (!audioReady) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Audio system failed to initialize."),
                backgroundColor: Colors.orange,
              ),
            );
          }
        }
      },
    );

    // Initialize audio through the service
    // Use a post frame callback to ensure context is available if needed for AppState,
    // though initializeAudio in service doesn't directly use it.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _liveConversionService
          .initializeAudio()
          .then((_) {
            // Log success or handle if already handled by callback
          })
          .catchError((e) {
            // Error already logged by service's onError callback
          });
    });
  }

  @override
  void dispose() {
    _liveConversionService.dispose();
    super.dispose();
  }

  Future<void> _handleFunctionCalls(List<FunctionCall> functionCalls) async {
    // Note: `context` is available here. Use `_appState` for modifications.
    for (var functionCall in functionCalls) {
      // Use a local context or the _appState directly if it's sufficient
      // For provider pattern, generally you'd use context.read<AppState>() or the stored _appState.
      // Since setFontFamilyCall etc. in utils.dart take BuildContext, we can pass it.
      // However, it's better if those utils take AppState directly if they only modify AppState.
      // For now, assuming they can work with the widget's context:
      switch (functionCall.name) {
        case 'setFontFamily':
          setFontFamilyCall(context, functionCall); // Original context usage
          break;
        case 'setFontSizeFactor':
          setFontSizeFactorCall(
            context,
            functionCall,
          ); // Original context usage
          break;
        case 'setAppColor':
          setAppColorCall(context, functionCall); // Original context usage
          break;
        default:
          log('Function not implemented in UI: ${functionCall.name}');
          // Optionally send back a FunctionResponse indicating an error if your AI expects it
          // For now, we just log it.
          _liveConversionService.onError?.call(
            'Function not implemented: ${functionCall.name}',
          );
      }
    }
  }

  void _toggleConversation() async {
    if (!_isAudioReady) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Audio system is not ready."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    // The service now manages the detailed logic of starting/stopping
    // and will update the UI via the onStateChanged callback.
    await _liveConversionService.toggleConversation();
  }

  @override
  Widget build(BuildContext context) {
    // Watch AppState for theme changes
    context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          _isSettingUpSession // Use the state variable from the service's callback
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : IconButton(
                  onPressed: _isAudioReady ? _toggleConversation : null,
                  icon:
                      _isConversationActive // Use state variable
                      ? const Icon(Icons.phone_disabled, color: Colors.red)
                      : const Icon(Icons.phone, color: Colors.green),
                  tooltip: _isAudioReady
                      ? (_isConversationActive
                            ? 'Stop conversation'
                            : 'Start conversation')
                      : 'Audio not ready',
                ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Press the phone icon to start a conversation!'),
            // You can add more UI elements here to display messages or status
          ],
        ),
      ),
    );
  }
}
