import 'package:flutter/material.dart';
import 'package:to_do_application/anasayfa.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/ui/cubit/anasayfa_cubit.dart';
import 'package:to_do_application/ui/cubit/kitap_detay_cubit.dart';
import 'package:to_do_application/ui/cubit/kitap_kayit_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => KitapKayitCubit()),
        BlocProvider(create: (context) => KitapDetayCubit()),
        BlocProvider(create: (context) => AnasayfaCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.pink,
          ),
        ),
        home: const Anasayfa(),
      ),
    );
  }
}
