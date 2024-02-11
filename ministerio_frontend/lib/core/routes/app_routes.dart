import 'package:get/get.dart';
import 'package:ministerio_frontend/view/client/create_client_view.dart';
import 'package:ministerio_frontend/view/client/home_view.dart';
import 'package:ministerio_frontend/view/client/projects_client_view.dart';
import 'package:ministerio_frontend/view/project/create_project_view.dart';
import 'package:ministerio_frontend/view/project/project_view.dart';
import 'package:ministerio_frontend/viewmodel/client_projects_view_model.dart';
import 'package:ministerio_frontend/viewmodel/client_view_model.dart';
import 'package:ministerio_frontend/viewmodel/project_view_model.dart';
import '../../repositories/client_repository_impl.dart';
import '../../repositories/project_repository_impl.dart';

class AppRoutes {
  static String get initialRoute => Routes.home;

  static List<GetPage> get pages => [
        GetPage(
            name: Routes.home,
            page: () => const HomeView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<ClientViewModel>(
                  () => ClientViewModel(ClientRepositoryImpl()));
              Get.lazyPut<ClientProjectsViewModel>(
                () => ClientProjectsViewModel(ProjectRepositoryImpl()),
              );
            })),
        GetPage(
          name: Routes.createClient,
          page: () => const CreateClienteView(),
          binding: BindingsBuilder(() {
            Get.lazyPut<ClientViewModel>(
                () => ClientViewModel(ClientRepositoryImpl()));
          }),
        ),
        GetPage(
          name: Routes.projects,
          page: () => const ProjectView(),
          binding: BindingsBuilder(() {
            Get.lazyPut<ProjectViewModel>(
                () => ProjectViewModel(ProjectRepositoryImpl()));
          }),
        ),
        GetPage(
          name: Routes.projectsClient,
          page: () => const ProjectsClientView(),
          arguments: String,
          binding: BindingsBuilder(() {
            Get.lazyPut<ClientProjectsViewModel>(
                () => ClientProjectsViewModel(ClientRepositoryImpl()));
          }),
        ),
        GetPage(
            name: Routes.createProject,
            page: () => const CreateProjecView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<ProjectViewModel>(
                () => ProjectViewModel(ProjectRepositoryImpl()),
              );
              Get.lazyPut<ClientViewModel>(
                  () => ClientViewModel(ClientRepositoryImpl()));
            })),
      ];
}

abstract class Routes {
  static const String home = '/';
  static const String projects = '/projects';
  static const String createClient = '/createClient';
  static const String createProject = '/createProject';
  static const String projectsClient = '/projectsClient';
}
