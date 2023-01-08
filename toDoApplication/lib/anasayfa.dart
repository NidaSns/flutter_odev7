import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/data/entity/kitaplar.dart';
import 'package:to_do_application/ui/screens/kitap_detay_sayfa.dart';
import 'package:to_do_application/ui/screens/kitap_kayit_sayfa.dart';
import 'ui/cubit/anasayfa_cubit.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnasayfaCubit>().loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: "Ara",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (searchResult) {
                  context.read<AnasayfaCubit>().search(searchResult);
                },
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : const Text("Kitaplar"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                    });
                    context.read<AnasayfaCubit>().loadBooks();
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                ),
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Kitaplar>>(
        builder: (context, kitaplarListesi) {
          if (kitaplarListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: kitaplarListesi.length,
              itemBuilder: (context, index) {
                var kitap = kitaplarListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KitaplarDetaySayfa(
                          kitap: kitap,
                        ),
                      ),
                    ).then((value) {
                      context.read<AnasayfaCubit>().loadBooks();
                    });
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${kitap.kitap_ad} - ${kitap.yazar_ad}"),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${kitap.kitap_ad} silinsin mi?"),
                                action: SnackBarAction(
                                  label: "Evet",
                                  onPressed: () {
                                    context
                                        .read<AnasayfaCubit>()
                                        .delete(kitap.kitap_id);
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const KitapKayitSayfa())).then((value) {
            context.read<AnasayfaCubit>().loadBooks();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
