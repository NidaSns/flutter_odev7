import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/kitap_kayit_cubit.dart';

class KitapKayitSayfa extends StatefulWidget {
  const KitapKayitSayfa({Key? key}) : super(key: key);

  @override
  State<KitapKayitSayfa> createState() => _KitapKayitSayfaState();
}

class _KitapKayitSayfaState extends State<KitapKayitSayfa> {
  var tfKitapAd = TextEditingController();
  var tfYazarAd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitap Kayıt"),
      ),
      body: Container(
        color: Colors.tealAccent,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.15,
                ),
                SizedBox(
                  width: width * 0.3,
                  child: Image.asset(
                    "assets/resimler/books.png",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: Column(
                      children: [
                        TextField(
                          controller: tfKitapAd,
                          decoration:
                              const InputDecoration(hintText: "Kitap Ad"),
                        ),
                        TextField(
                          controller: tfYazarAd,
                          decoration:
                              const InputDecoration(hintText: "Yazar Ad"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<KitapKayitCubit>()
                        .save(tfKitapAd.text, tfYazarAd.text)
                        .then((value) => Navigator.of(context).pop());
                  },
                  child: const Text("Kaydet"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
