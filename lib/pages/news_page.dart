import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:internity/shared/riverpod_and_hooks.dart';
import 'package:internity/shared/widget/custom_app_bar.dart';
import 'package:internity/theme/colors.dart';
import 'package:intl/intl.dart';

import '../features/news/model/news_model.dart';
import '../features/news/provider/news_provider.dart';

class NewsPage extends HookConsumerWidget {
  const NewsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsResult = ref.watch(newsProvider);

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        appBar: const CustomBackButton(),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref.refresh(newsProvider.future);
          },
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: newsResult.when(
                    data: (result) {
                      if (result.isSuccess) {
                        final data = result.data!;
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: data.map((news) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(
                                            secondaryBackgroundColor),
                                      ),
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: news.image,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              SizedBox(
                                                height: 10,
                                                width: 10,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const SizedBox(
                                                  height: 10,
                                                  width: 10,
                                                  child: Center(
                                                      child:
                                                          Icon(Icons.error)))),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            news.title,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          HtmlWidget(news.content),
                                          Text(
                                            DateFormat.yMMMMd('id_ID').format(
                                                DateTime.parse(news.createdAt)),
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Color(secondaryTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList());
                      } else {
                        return Center(
                          child: Text(
                            result.error!, // Display the error message
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }
                    },
                    error: (error, stack) {
                      return Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: Center(child: Text(error.toString())));
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()))),
          ),
        ),
      ),
    );
  }
}
