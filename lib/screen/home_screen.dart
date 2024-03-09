import 'package:flutter/material.dart';
import 'package:tv_online/get_banner.dart';
import 'package:tv_online/model/channel.dart';
import 'package:tv_online/screen/tv_online_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'تلویزیون آنلاین',
            style: TextStyle(
              fontFamily: 'morabee',
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          const SliverToBoxAdapter(
            child: BannerSlider(),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
            sliver: SliverGrid.builder(
              itemCount: channels.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                final Channel channel = channels[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TvOnlineScreen(mychannel: channel),
                    ));
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 100,
                          color: Colors.grey.shade300,
                          child: Image.network(
                            channel.logo,
                            cacheHeight: 60,
                            color: const Color.fromARGB(137, 0, 0, 0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        channel.name,
                        style: TextStyle(
                          fontFamily: 'morabee',
                          color: Color.fromARGB(178, 16, 4, 4),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
