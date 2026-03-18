local resources = import 'resources.libsonnet';

function(env) {
  '$content_schema': 'monitoring/uss_qualifier/configurations/configuration/USSQualifierConfiguration.json',
  v1: {
    test_run: {
      resources: {
        resource_declarations: env.resource_declarations {
          feature_check_table: resources.feature_check_table,
        },
      },
      action: {
        test_suite: {
          resources: {
            geospatial_info_provider: 'geospatial_info_provider',
            table: 'feature_check_table',
          },
          suite_definition: {
            name: 'uspace-services geospatial map tests',
            resources: {
              geospatial_info_provider: 'resources.geospatial_info.GeospatialInfoProviderResource',
              table: 'resources.interuss.geospatial_map.FeatureCheckTableResource',
            },
            actions: [
              {
                test_scenario: {
                  scenario_type: 'scenarios.interuss.geospatial_map.GeospatialFeatureComprehension',
                  resources: {
                    geospatial_info_provider: 'geospatial_info_provider',
                    table: 'table',
                  },
                },
              },
            ],
          },
        },
      },
      non_baseline_inputs: [
        'v1.test_run.resources.resource_declarations.utm_auth',
        'v1.test_run.resources.resource_declarations.geospatial_info_provider',
      ],
      execution: {
        stop_fast: true,
      },
    },
    artifacts: {
      raw_report: {},
      sequence_view: {},
    },
    validation: {
      criteria: [
        {
          applicability: { test_scenarios: {} },
          pass_condition: {
            each_element: {
              has_execution_error: false,
            },
          },
        },
      ],
    },
  },
}
