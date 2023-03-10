import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_news_app/controllers/bbc_news_controller.dart';
import 'package:my_news_app/screens/details/news_details_screen.dart';
import 'package:my_news_app/widgets/build_image.dart';
import 'package:my_news_app/widgets/custom_card.dart';
import 'package:my_news_app/widgets/date_time_helper.dart';
import 'package:my_news_app/widgets/reusable_text.dart';

class BBCAllNewsScreen extends StatelessWidget {
  BBCAllNewsScreen({Key? key}) : super(key: key);

  final _bbcController = Get.put(BBCNewsController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: "BBC News",
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(() {
        if (_bbcController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: _bbcController.bbcNewsList.length,
              itemBuilder: (context, index) {
                final data = _bbcController.bbcNewsList[index];
                final timeAgo = DateTimeHelper.formatDateTime(
                    _bbcController.bbcNewsList[index]["publishedAt"]);
                return InkWell(
                    onTap: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailsScren(
                            imageUrl: data['urlToImage'],
                            title: data['title'],
                            author: data['author'],
                            dateTime: timeAgo,
                            description: data['description'],
                            content: data['content'],
                          ),
                        ),
                      );
                    },

                    child: CustomCard(imageUrl: data['urlToImage'].toString(), title: data['title'].toString(), dateTime: timeAgo.toString()));
              });
        }
      }),
    );
  }
}
