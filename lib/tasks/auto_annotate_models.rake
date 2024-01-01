# frozen_string_literal: true

if Rails.env.development?
  require 'annotate'
  task set_annotation_options: :environment do
    # You can override any of these by setting an environment variable of the
    # same name.
    Annotate.set_defaults(
      'active_admin' => 'false',
      'additional_file_patterns' => [],
      'routes' => 'false',
      'models' => 'true',
      'position_in_routes' => 'before',
      'position_in_class' => 'before',
      'position_in_test' => 'before',
      'position_in_fixture' => 'before',
      'position_in_factory' => 'before',
      'position_in_serializer' => 'before',
      'show_foreign_keys' => 'true',
      'show_complete_foreign_keys' => 'false',
      'show_indexes' => 'true',
      'simple_indexes' => 'false',
      'model_dir' => 'app/models',
      'root_dir' => '',
      'include_version' => 'false',
      'require' => '',
      # spec/models には追加しない
      # 'exclude_tests'               => 'false',
      'exclude_tests' => 'true',
      'exclude_fixtures' => 'false',
      # spec/factories には追加しない
      # 'exclude_factories'           => 'false',
      'exclude_factories' => 'true',
      'exclude_serializers' => 'false',
      'exclude_scaffolds' => 'true',
      'exclude_controllers' => 'true',
      'exclude_helpers' => 'true',
      'exclude_sti_subclasses' => 'false',
      'ignore_model_sub_dir' => 'false',
      'ignore_columns' => nil,
      'ignore_routes' => nil,
      'ignore_unknown_models' => 'false',
      'hide_limit_column_types' => 'integer,bigint,boolean',
      'hide_default_column_types' => 'json,jsonb,hstore',
      'skip_on_db_migrate' => 'false',
      'format_bare' => 'true',
      'format_rdoc' => 'false',
      'format_yard' => 'false',
      'format_markdown' => 'false',
      'sort' => 'false',
      'force' => 'false',
      'frozen' => 'false',
      # alphabetical sort ではなく db の順序に合わせたい
      # 'classified_sort'             => 'true',
      'classified_sort' => 'false',
      'trace' => 'false',
      'wrapper_open' => nil,
      'wrapper_close' => nil,
      'with_comment' => 'true'
    )
  end

  Annotate.load_tasks
end
