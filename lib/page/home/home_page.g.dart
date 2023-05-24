// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as String,
      description: json['description'] as String,
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'completed': instance.completed,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listSizeHash() => r'b61885d062a01bba2899a804123148e03d386d82';

/// See also [listSize].
@ProviderFor(listSize)
final listSizeProvider = AutoDisposeProvider<int>.internal(
  listSize,
  name: r'listSizeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$listSizeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ListSizeRef = AutoDisposeProviderRef<int>;
String _$todoHash() => r'86b901da4f0b6134f67beb11525e39ecb091343f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef TodoRef = AutoDisposeProviderRef<Todo>;

/// See also [todo].
@ProviderFor(todo)
const todoProvider = TodoFamily();

/// See also [todo].
class TodoFamily extends Family<Todo> {
  /// See also [todo].
  const TodoFamily();

  /// See also [todo].
  TodoProvider call({
    required int index,
  }) {
    return TodoProvider(
      index: index,
    );
  }

  @override
  TodoProvider getProviderOverride(
    covariant TodoProvider provider,
  ) {
    return call(
      index: provider.index,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'todoProvider';
}

/// See also [todo].
class TodoProvider extends AutoDisposeProvider<Todo> {
  /// See also [todo].
  TodoProvider({
    required this.index,
  }) : super.internal(
          (ref) => todo(
            ref,
            index: index,
          ),
          from: todoProvider,
          name: r'todoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$todoHash,
          dependencies: TodoFamily._dependencies,
          allTransitiveDependencies: TodoFamily._allTransitiveDependencies,
        );

  final int index;

  @override
  bool operator ==(Object other) {
    return other is TodoProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$todosHash() => r'c6ed03d3ddf6cbf417b3c9bf119a280a791efad6';

/// See also [Todos].
@ProviderFor(Todos)
final todosProvider = AutoDisposeNotifierProvider<Todos, List<Todo>>.internal(
  Todos.new,
  name: r'todosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Todos = AutoDisposeNotifier<List<Todo>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
