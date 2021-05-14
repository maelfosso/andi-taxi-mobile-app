import 'package:andi_taxi/blocs/app/app_bloc.dart';
import 'package:andi_taxi/pages/home/home_page.dart';
import 'package:andi_taxi/ui/welcome.dart';
import 'package:flutter/widgets.dart';


List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [Welcome.page()];
  }
}