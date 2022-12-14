import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/application/bookmark/bookmark_bloc.dart';
import 'package:flutter_advanced_course/application/weather/home_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/widgets/main_wrapper.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///  init locator
  await setup();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MultiBlocProvider(providers: [
      BlocProvider(create: (_) => locator<HomeBloc>()),
      BlocProvider(create: (_) => locator<BookmarkBloc>()),
    ], child: MainWrapper()),
  ));
}
