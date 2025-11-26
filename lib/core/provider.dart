import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:responsi/controller/articles_controller.dart';
import 'package:responsi/service/wrapper.dart';

List<SingleChildWidget> get appProviders => [
  Provider(create: (_) => Wrapper()),

  Provider(create: (context) => ArticlesController(context.read<Wrapper>())),

  ChangeNotifierProvider(create: (context) => ArticlesView(context.read<ArticlesController>()))
];
