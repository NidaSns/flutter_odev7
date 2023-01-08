import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/kitaplar.dart';
import '../cubit/kitap_detay_cubit.dart';

class KitaplarDetaySayfa extends StatefulWidget {
  final Kitaplar kitap;

  const KitaplarDetaySayfa({required this.kitap, Key? key}) : super(key: key);

  @override
  State<KitaplarDetaySayfa> createState() => _KitaplarDetaySayfaState();
}

class _KitaplarDetaySayfaState extends State<KitaplarDetaySayfa> {
  var tfKitapAd = TextEditingController();
  var tfYazarAd = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var kitap = widget.kitap;
    tfKitapAd.text = kitap.kitap_ad;
    tfYazarAd.text = kitap.yazar_ad;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitap Detay"),
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
                    "assets/resimler/reading-book.png",
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
                        const Text("Kitap Adı:"),
                        TextField(
                          controller: tfKitapAd,
                          decoration:
                              const InputDecoration(hintText: "Kitap Ad"),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text("Yazar Adı:"),
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
                        .read<KitapDetayCubit>()
                        .update(
                          widget.kitap.kitap_id,
                          tfKitapAd.text,
                          tfYazarAd.text,
                        )
                        .then((value) => Navigator.of(context).pop());
                  },
                  child: const Text("Güncelle"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
