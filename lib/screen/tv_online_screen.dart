import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tv_online/model/channel.dart';
import 'package:video_player/video_player.dart';

class TvOnlineScreen extends StatefulWidget {
  const TvOnlineScreen({super.key, required this.mychannel});
  final Channel mychannel;

  @override
  State<TvOnlineScreen> createState() => _TvOnlineScreenState();
}

class _TvOnlineScreenState extends State<TvOnlineScreen> {
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  lodeVideo() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.mychannel.url))
          ..initialize().then((value) {
            chewieController = ChewieController(
              videoPlayerController: videoPlayerController!,
              autoPlay: true,
              isLive: true,
            );
            setState(() {});
          });
  }

  @override
  void initState() {
    lodeVideo();
    super.initState();
  }



  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                backgroundColor: Colors.white,

                elevation: 0,
                expandedHeight: 240,
                floating: true,
                //    shadowColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: chewieController == null
                      ? const SizedBox(
                          height: 20,
                          child: Center(child: CircularProgressIndicator()))
                      : Chewie(controller: chewieController!),
                ),
                centerTitle: true,
                //  leadingWidth: 200,
              ),
              ////
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 70,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 60,
                            color: Colors.grey.shade300,
                            width: 200,
                            child: const Center(
                                child: Text(
                              'لیست شبکه های تلویزیونی',
                              style: TextStyle(
                                fontFamily: 'morabee',
                                color: Color.fromARGB(178, 16, 4, 4),
                              ),
                            )),
                          ),
                        ),
                        const Spacer(),
                        Column(children: [
                          Image.network(
                            widget.mychannel.logo,
                            cacheHeight: 40,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.mychannel.name,
                            style: const TextStyle(
                              fontFamily: 'morabee',
                              color: Color.fromARGB(178, 16, 4, 4),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),

              /////
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                sliver: SliverList.builder(
                  itemCount: channels.length,
                  itemBuilder: (context, index) {
                    final Channel channel = channels[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              TvOnlineScreen(mychannel: channel),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            //   color: Colors.grey.shade300,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                  Colors.grey.shade300,
                                  Colors.grey.shade100
                                ])),
                            height: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        channel.logo,
                                        cacheHeight: 40,
                                        color:
                                            const Color.fromARGB(137, 0, 0, 0),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Spacer(),
                                      Text(
                                        channel.name,
                                        style: const TextStyle(
                                          fontFamily: 'morabee',
                                          color: Color.fromARGB(178, 16, 4, 4),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )

              ///
            ],
          ),
        ),
      ),
    );
  }
}
