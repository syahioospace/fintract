//step 5.6
//The goal: wire up all dependencies in one place so nothing manually instantiates its own dependencies. get_it is the service locator,
//injectable generates the registration code via code generation.
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;
//This is your global service locator — a registry where you register and retrieve dependencies. Instead of doing MyClass(dependency:
//SomeDep()) everywhere, you just call getIt<SomeDep>() and it hands you the instance.

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();

//configureDependencies()
//  This is the function you'll call once at app startup (in main_dev.dart etc.) to register everything. The @InjectableInit() annotation
//  tells injectable to generate the actual registration code into injection.config.dart automatically — you never write that file by hand.

//  The pattern is: you annotate your classes with @injectable, @singleton, or @lazySingleton, run build_runner, and it generates all the
//  wiring for you.