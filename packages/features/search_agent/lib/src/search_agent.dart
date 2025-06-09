import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc

import 'search_cubit.dart';
import 'utils/utils.dart'; // Assuming AudioService and InputMode are here

class SearchAgentScreen extends StatelessWidget {
  final void Function(String result)? onSearchResult;
  final void Function()? onSearchStarted;
  final void Function(String message)? onSearchError;
  final VoidCallback onFilterTap;

  const SearchAgentScreen({
    super.key,
    this.onSearchResult,
    this.onSearchStarted,
    this.onSearchError,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: SearchAgent(
        onSearchResult: onSearchResult,
        onSearchStarted: onSearchStarted,
        onSearchError: onSearchError,
        onFilterTap: onFilterTap,
      ),
    );
  }
}

class SearchAgent extends StatefulWidget {
  final void Function(String result)? onSearchResult;
  final void Function()? onSearchStarted;
  final void Function(String message)? onSearchError;
  final VoidCallback onFilterTap;

  const SearchAgent({
    super.key,
    this.onSearchResult,
    this.onSearchStarted,
    this.onSearchError,
    required this.onFilterTap,
  });
  @override
  State<SearchAgent> createState() => _SearchAgentState();
}

class _SearchAgentState extends State<SearchAgent> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      context.read<SearchCubit>().textChanged(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchProcessing) {
          widget.onSearchStarted?.call();
        } else if (state is SearchSuccess) {
          widget.onSearchResult?.call(state.result);
        } else if (state is SearchError) {
          widget.onSearchError?.call(state.message);
          _showSnackBar(state.message);
        }
      },
      builder: (context, state) {
        InputMode currentMode;
        if (state is SearchRecording) {
          currentMode = InputMode.recording;
        } else if (state is SearchProcessing) {
          currentMode = InputMode.processing;
        } else if (state is SearchTyping) {
          currentMode = InputMode.typing;
        } else {
          currentMode = InputMode.idle;
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AudioTextInputField(
              onFilterTap: widget.onFilterTap,
              mode: currentMode,
              amplitudeStream: cubit.getamplitudeStream,
              controller: _controller,
              onTextChanged: (value) {
                // Text changes are now handled by the listener in initState
              },
              onMicTap: () => context.read<SearchCubit>().startRecording(),
              onSendText: () {
                cubit.sendText(_controller.text);
                _controller.clear();
              },
              onSendRecording: cubit.sendRecording,

              onCancelRecording: cubit.cancelRecording,
            ),
            if (state is SearchSuccess)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Search Result:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(state.result),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
