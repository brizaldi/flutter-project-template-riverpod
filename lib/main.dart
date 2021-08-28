import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'extra/config/configuration.dart';
import 'features/core/presentation/app_widget.dart';

void main() => Main();

class Main extends Env {
  @override
  FutureOr<HookConsumerWidget> onCreate() {
    ErrorWidget.builder = (details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return Container(color: Colors.transparent);
    };

    return AppWidget();
  }
}
