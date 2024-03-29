import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../../theme/colors.dart';
import '../provider/news_provider.dart';

class NewsSliderWidget extends StatefulHookConsumerWidget {
  const NewsSliderWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewsSliderWidgetState();
}

class _NewsSliderWidgetState extends ConsumerState<NewsSliderWidget> {
  @override
  Widget build(BuildContext context) {
    final newsData = ref.watch(newsProvider);

    return SizedBox(
      height: 240,
      child: newsData.when(
        data: (data) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) => Container(
            width: 250,
            margin: const EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(secondaryBackgroundColor),
                  ),
                  height: 140,
                  width: double.infinity,
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: data[index].image,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => SizedBox(
                                height: 10,
                                width: 10,
                                child: Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                              ),
                      errorWidget: (context, url, error) => const SizedBox(
                          height: 10,
                          width: 10,
                          child: Center(child: Icon(Icons.error)))),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data[index].title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMMd('id_ID')
                              .format(DateTime.parse(data[index].createdAt)),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(secondaryTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
