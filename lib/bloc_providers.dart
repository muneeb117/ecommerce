
import 'package:basic_ecommerce_app/screens/application/bloc/app_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProviders {

  static get allBlocProvider => [
    BlocProvider(create: (BuildContext context) => AppBlocs()),

  ];
}
