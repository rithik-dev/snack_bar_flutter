import 'package:flutter/material.dart';
import 'package:snack_bar_flutter/src/helpers.dart';

class SnackBarDefaults {
  SnackBarDefaults._();

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static String infoString = 'Oh, hi there!';
  static String warningString = 'Warning!';
  static String successString = 'Success!';
  static String errorString = 'Oh snap!';
}

enum SnackBarType {
  info,
  warning,
  success,
  error,
}

void showInfoSnackBar(
  String? text, {
  Duration duration = const Duration(seconds: 2),
}) {
  showSnackBar(
    text,
    duration: duration,
    snackBarType: SnackBarType.info,
  );
}

void showWarningSnackBar(
  String? text, {
  Duration duration = const Duration(seconds: 2),
}) {
  showSnackBar(
    text,
    duration: duration,
    snackBarType: SnackBarType.warning,
  );
}

void showSuccessSnackBar(
  String? text, {
  Duration duration = const Duration(seconds: 2),
}) {
  showSnackBar(
    text,
    duration: duration,
    snackBarType: SnackBarType.success,
  );
}

void showErrSnackBar(
  String? text, {
  Duration duration = const Duration(seconds: 2),
}) {
  showSnackBar(
    text,
    duration: duration,
    snackBarType: SnackBarType.error,
  );
}

void showSnackBar(
  String? text, {
  required SnackBarType snackBarType,
  Duration duration = const Duration(seconds: 2),
}) {
  if (isNullOrBlank(text)) return;

  assert(
    SnackBarDefaults.scaffoldMessengerKey.currentState != null,
    'Initialize SnackBarDefaults.scaffoldMessengerKey in your app!',
  );

  SnackBarDefaults.scaffoldMessengerKey.currentState
    ?..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: _CustomSnackBarContent(
          content: text!,
          snackBarType: snackBarType,
        ),
        padding: EdgeInsets.zero,
        duration: duration,
      ),
    );
}

class _CustomSnackBarContent extends StatelessWidget {
  // static const id = 'CustomSnackBarContent';

  final String? title;
  final String content;
  final SnackBarType snackBarType;

  const _CustomSnackBarContent({
    Key? key,
    this.title,
    required this.content,
    required this.snackBarType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Material(
            color: _backgroundColor,
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15).copyWith(left: 65),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title ?? _title,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    content,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: 7.5,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: _bubbleColor,
              child: _bubbleIcon,
            ),
          ),
        ],
      ),
    );
  }

  String get _title {
    switch (snackBarType) {
      case SnackBarType.info:
        return SnackBarDefaults.infoString;
      case SnackBarType.warning:
        return SnackBarDefaults.warningString;
      case SnackBarType.success:
        return SnackBarDefaults.successString;
      case SnackBarType.error:
        return SnackBarDefaults.errorString;
    }
  }

  Color get _backgroundColor {
    switch (snackBarType) {
      case SnackBarType.info:
        return const Color(0xFF0070E0);
      case SnackBarType.warning:
        return const Color(0xFFEF8D32);
      case SnackBarType.success:
        return const Color(0xFF4E8D7C);
      case SnackBarType.error:
        return const Color(0xFFC72C41);
    }
  }

  Color get _bubbleColor {
    switch (snackBarType) {
      case SnackBarType.info:
        return const Color(0xFF05478A);
      case SnackBarType.warning:
        return const Color(0xFFCC561E);
      case SnackBarType.success:
        return const Color(0xFF004E32);
      case SnackBarType.error:
        return const Color(0xFF801336);
    }
  }

  Widget get _bubbleIcon {
    switch (snackBarType) {
      case SnackBarType.info:
        return const Text(
          '?',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      case SnackBarType.warning:
        return const Text(
          '!',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      case SnackBarType.success:
        return const Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 30,
        );
      case SnackBarType.error:
        return const Icon(
          Icons.cancel,
          color: Colors.white,
          size: 30,
        );
    }
  }
}
