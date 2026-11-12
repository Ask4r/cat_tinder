import 'package:flutter/material.dart';

NetworkImage webPhotograph(String url) =>
    NetworkImage(url, webHtmlElementStrategy: WebHtmlElementStrategy.prefer);
