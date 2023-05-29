import 'package:get/get.dart';
import 'package:jangjeon/model/comment.dart';
import 'package:jangjeon/service/cloud_natural_language.dart';
import 'package:jangjeon/service/cloud_summarize.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/service/news_crawling.dart';

class NewsDetailController extends GetxController {
  RxDouble investmentIndex = (-1.0).obs;
  RxString summarContent = ''.obs;
  RxList otherNews = [].obs;
  var news = Get.arguments;

  RxList<Comment> comments = <Comment>[].obs;

  getOtherNews(String stock) async {
    await NewsCrawling().newsCrawling(stock, otherNews);
  }

  //댓글 좋아요 수 증가
  increseCommentLikes(comment) {
    DBService().increseCommentLikes(news['stock'].toUpperCase(), comment.id);
    comment.likes += 1;
  }

  newsSummarized() async {
    summarContent.value =
        await CloudSummarize().summarizeText(news['article'], 4);
  }

  newsStockNatural() async {
    investmentIndex.value =
        await CloudNaturalLanguage().getPositiveNatural('오늘의 ${news['stock']}');
  }

  newsStockComments() async {
    comments
        .addAll(await DBService().readComments(news['stock'].toUpperCase()));
    comments.sort((a, b) => -a.createdAt.compareTo(b.createdAt));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    newsSummarized();
    newsStockNatural();
    newsStockComments();
    getOtherNews(news['stock']);
  }
}
