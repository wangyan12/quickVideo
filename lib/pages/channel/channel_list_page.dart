import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh_strong/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipin/net/repository_auth.dart';
import 'package:shipin/pages/video_playback/video_playback_page.dart';
import 'package:shipin/styles.dart';
import 'package:shipin/widgets/refresh.dart';

import '../../model/cate_model.dart';
import '../../model/commend_model.dart';
import '../../model/list_model.dart';
import '../../net/string.dart';

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({Key? key, required this.cateExtModel}) : super(key: key);
  final CateExtModel cateExtModel;
  @override
  State<StatefulWidget> createState() {
    return ChannelListPageState();
  }
}
class ChannelListPageState extends State<ChannelListPage> {
  int pageNum = 1;
  List<ListExtVodListModel> vodList = [];
  EasyRefreshController? easyRefreshController; // 下拉刷新控制器

  @override
  void initState() {
    super.initState();
    easyRefreshController = EasyRefreshController();
    cateListRequest(page: 1);
  }
  cateListRequest({required int page}) async {
    int pageNumber = page;
    Map<String, dynamic> dataMap = await mapString(
      data: {
        'type': widget.cateExtModel.type,
        'page': '$pageNumber',
        'cid': widget.cateExtModel.cid,
      },
    );
    RepositoryAuth.list(data: dataMap, context: context).then((value) {
      ListModel listModel = value;
      if (page == 1) {
        vodList.clear();
      }
      vodList.addAll(listModel.ext?.vodList ?? []);
      easyRefreshController!.finishLoad(success: true, noMore: listModel.ext!.pageCount == pageNumber);
      setState(() {});
    }).catchError((error) {
      debugPrint('********======= list 111111  error = $error');
      easyRefreshController!.finishLoad(success: true, noMore: false);
    });
  }
  @override
  void dispose() {
    super.dispose();
    easyRefreshController?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.cateExtModel.name!,
          style: TextStyle(
            color: const Color(0xff232323),
            fontSize: 17.sp
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.translucent,
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/icon_return.png',
              color: Colors.black,
              width: 23.w,
              height: 23.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: myRefresh(
        controller: easyRefreshController,
        refreshFn: () => cateListRequest(page: 1),
        loadFn: () => cateListRequest(page: ++pageNum),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          itemCount: vodList.length,
          itemBuilder: (ctx, index) {
            return itemWidget(index: index);
          },
        ),
      ),
    );
  }
  // item
  Widget itemWidget({
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        CommendExtTypeListModel model = CommendExtTypeListModel.fromJson(vodList[index].toJson());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => VideoPlaybackPage(
            commendExtTypeListModel: model,
          )),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
            child: Image.network(
              vodList[index].cover!,
              width: 355.w,
              height: 210.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 45.h,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    vodList[index].title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: PageStyle.ts_000000_14sp,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_heat.png',
                      width: 20.w,
                      height: 20.w,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 6.w,),
                    Text(
                      '热度 ${vodList[index].hot}',
                      style: TextStyle(
                        color: const Color(0xffC8A06A),
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}