import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:responsi/controller/articles_controller.dart';
import 'package:responsi/controller/blogs_controller.dart';
import 'package:responsi/controller/bookmark_controller.dart';
import 'package:responsi/controller/login_controller.dart';
import 'package:responsi/controller/reports_controller.dart';
import 'package:responsi/service/wrapper.dart';

List<SingleChildWidget> get appProviders => [
  Provider(create: (_) => Wrapper()),
  ChangeNotifierProvider(create: (context) => LoginView()),

  Provider(create: (context) => ArticlesController(context.read<Wrapper>())),
  Provider(create: (context) => BlogsController(context.read<Wrapper>())),
  Provider(create: (context) => ReportsController(context.read<Wrapper>())),

  ChangeNotifierProvider(create: (context) => ArticlesView(context.read<ArticlesController>())),
  ChangeNotifierProvider(create: (context) => BlogsView(context.read<BlogsController>())),
  ChangeNotifierProvider(create: (context) => ReportView(context.read<ReportsController>())),
  ChangeNotifierProvider(create: (_) => BookmarkView())
];
