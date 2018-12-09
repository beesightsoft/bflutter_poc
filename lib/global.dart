import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Env {
  Env._({@required this.apiBaseUrl});

  final String apiBaseUrl;

  factory Env.dev() {
    return new Env._(apiBaseUrl: "https://api.github.com/");
  }
}

class Global {
  static final Global instance = Global._private();

  Global._private();

  Env env = Env.dev();
}
