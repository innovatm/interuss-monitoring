function(env) {
  // See the file below (in the `schemas` folder of this repo) for the schema this file's content follows
  '$content_schema': 'monitoring/uss_qualifier/configurations/configuration/USSQualifierConfiguration.json',

  // This configuration uses the v1 configuration schema
  v1: {
    // This block defines how to perform a test run
    test_run: {
      // This block defines which test action uss_qualifier should run, and what resources from the pool should be used
      action: {
        test_suite: {
          // suite_type is a FileReference (defined in uss_qualifier/file_io.py) to a test suite definition (see uss_qualifier/suites/README.md)
          suite_type: 'suites.uspace.network_identification',

          // Mapping of <resource name in test suite> to <resource name in resource pool>
          resources: {
            id_generator: 'id_generator',
            test_env_version_providers: 'test_env_version_providers?',
            prod_env_version_providers: 'prod_env_version_providers?',
            mock_uss_dp: 'mock_uss_instance_dp',
            mock_uss_sp: 'mock_uss_instance_sp',
            flights_data: 'flights_data',
            service_providers: 'service_providers?',
            observers: 'observers',
            evaluation_configuration: 'observation_evaluation_configuration',
            dss_instances: 'netrid_dss_instances?',
            utm_client_identity: 'utm_client_identity',
            service_area: 'service_area',
            planning_area: 'planning_area',
            problematically_big_area: 'problematically_big_area',
            test_exclusions: 'test_exclusions',
            uss_identification: 'uss_identification',
            dss_datastore_cluster: 'dss_datastore_cluster',
          },
        },
      },

      // When a test run is executed, a "baseline signature" is computed uniquely identifying the "baseline" of the test,
      // usually excluding exactly what systems are participating in the test (the "environment").  This is a list of
      // elements within this configuration to exclude from the configuration when computing the baseline signature.
      non_baseline_inputs: [
        'v1.test_run.resources.resource_declarations.utm_auth',
        'v1.test_run.resources.resource_declarations.utm_client_identity',
        'v1.test_run.resources.resource_declarations.service_providers',
        'v1.test_run.resources.resource_declarations.observers',
        'v1.test_run.resources.resource_declarations.netrid_dss_instances',
        'v1.test_run.resources.resource_declarations.mock_uss_instance_dp',
        'v1.test_run.resources.resource_declarations.mock_uss_instance_sp',
        'v1.test_run.resources.resource_declarations.uss_identification',
        'v1.test_run.resources.resource_declarations.dss_datastore_cluster',
        'v1.artifacts.tested_requirements[0].aggregate_participants',
        'v1.artifacts.tested_requirements[0].participant_requirements',
      ],

      // This block defines all the resources available in the resource pool.
      // All resources defined below should be used either
      //   1) directly in the test suite or
      //   2) to create another resource in the pool
      resources: {
        resource_declarations: env.resource_declarations {
          flights_data: {
            dependencies: {},
            resource_type: 'resources.netrid.FlightDataResource',
            specification: {
              flight_start_delay: '5s',
              kml_source: {
                kml_file: {
                  path: 'file://./test_data/che/rid/zurich.kml',
                },
              },
            },
          },

          planning_area_volume: {
            resource_type: 'resources.VolumeResource',
            specification: {
              template: {
                altitude_lower: {
                  reference: 'W84',
                  units: 'M',
                  value: 0,
                },
                altitude_upper: {
                  reference: 'W84',
                  units: 'M',
                  value: 1000,
                },
                outline_polygon: {
                  vertices: [
                    {
                      lat: 47.45237618874023,
                      lng: 8.337401667996478,
                    },
                    {
                      lat: 47.38882810764797,
                      lng: 8.343217430398902,
                    },
                    {
                      lat: 47.3643466256706,
                      lng: 8.389932768382156,
                    },
                    {
                      lat: 47.36323038495268,
                      lng: 8.536070011827881,
                    },
                    {
                      lat: 47.36909451406398,
                      lng: 8.580678976356925,
                    },
                    {
                      lat: 47.4007874493574,
                      lng: 8.57764881798931,
                    },
                    {
                      lat: 47.451319730511365,
                      lng: 8.46442103543102,
                    },
                  ],
                },
              },
            },
          },

          planning_area: {
            dependencies: {
              volume: 'planning_area_volume',
            },
            resource_type: 'resources.PlanningAreaResource',
            specification: {
              base_url: 'https://testdummy.interuss.org/interuss/monitoring/uss_qualifier/configurations/dev/library/resources/zurich_planning_area',
            },
          },

          problematically_big_area: {
            dependencies: {},
            resource_type: 'resources.VolumeResource',
            specification: {
              template: {
                outline_polygon: {
                  vertices: [
                    {
                      lat: 48,
                      lng: 9,
                    },
                    {
                      lat: 47,
                      lng: 9,
                    },
                    {
                      lat: 47,
                      lng: 8,
                    },
                    {
                      lat: 48,
                      lng: 8,
                    },
                  ],
                },
              },
            },
          },

          service_area_volume: {
            resource_type: 'resources.VolumeResource',
            specification: {
              template: {
                altitude_upper:{
                  value: 1000,
                  reference: 'W84',
                  units: 'M',
                },
                altitude_lower: {
                  value: 0,
                  reference: 'W84',
                  units: 'M',
                },
                outline_polygon: {
                  vertices: [
                    {
                      lat: 47.45237618874023,
                      lng: 8.337401667996478,
                    },
                    {
                      lat: 47.38882810764797,
                      lng: 8.343217430398902,
                    },
                    {
                      lat: 47.3643466256706,
                      lng: 8.389932768382156,
                    },
                    {
                      lat: 47.36323038495268,
                      lng: 8.536070011827881,
                    },
                    {
                      lat: 47.36909451406398,
                      lng: 8.580678976356925,
                    },
                    {
                      lat: 47.4007874493574,
                      lng: 8.57764881798931,
                    },
                    {
                      lat: 47.451319730511365,
                      lng: 8.46442103543102,
                    },
                  ],
                },
                start_time: {
                  offset_from: {
                    starting_from: {
                      time_during_test: 'TimeOfEvaluation',
                    },
                    offset: '1s',
                  },
                },
                end_time: {
                  offset_from: {
                    starting_from: {
                      time_during_test: 'TimeOfEvaluation',
                    },
                    offset: '1h0m1s',
                  },
                },
              },
            },
          },

          service_area: {
            dependencies: {
              volume: 'service_area_volume',
            },
            resource_type: 'resources.netrid.ServiceAreaResource',
            specification: {
              base_url: 'https://testdummy.interuss.org/interuss/monitoring/uss_qualifier/configurations/dev/library/resources/zurich_service_area',
            },
          },

          observation_evaluation_configuration: {
            dependencies: {},
            resource_type: 'resources.netrid.EvaluationConfigurationResource',
            specification: {},
          },

          id_generator: {
            dependencies: {
              client_identity: 'utm_client_identity',
            },
            resource_type: 'resources.interuss.IDGeneratorResource',
            specification: {},
          },

          // Controls tests behavior
          test_exclusions: {
            resource_type: 'resources.dev.TestExclusionsResource',
            specification: {
              // Tests should allow private addresses that are not publicly addressable since this configuration runs locally
              allow_private_addresses: true,
              // Tests should allow cleartext queries since this configuration runs locally without generalized usage of HTTPS
              allow_cleartext_queries: true,
            },
          },

        },  // resource_declarations
      },  // resources

      // How to execute a test run using this configuration
      execution: {
        // Since we expect no failed checks and want to stop execution immediately if there are any failed checks, we set
        // this parameter to true.
        stop_fast: false,
      },
    },  // test_run

    // This block defines artifacts related to the test run.  Note that all paths are
    // relative to where uss_qualifier is executed from, and are located inside the
    // Docker container executing uss_qualifier.
    artifacts: {
      // Write out full report content
      raw_report: {},

      tested_requirements: [
        // Write out a human-readable reports of the F3548-21 requirements tested
        {
          report_name: 'U-Space Network Identification Service',
          requirement_collections: {
            'U-Space Network Identification': {
              requirement_collections: [
                {
                  requirements: [
                    'astm.f3411.v22a.NET0030',
                    'astm.f3411.v22a.NET0040',
                    'astm.f3411.v22a.NET0210',
                    'astm.f3411.v22a.NET0220',
                    'astm.f3411.v22a.NET0250',
                    'astm.f3411.v22a.NET0260,Table1,1',
                    'astm.f3411.v22a.NET0260,Table1,2',
                    'astm.f3411.v22a.NET0260,Table1,5',
                    'astm.f3411.v22a.NET0260,Table1,6',
                    'astm.f3411.v22a.NET0260,Table1,10',
                    'astm.f3411.v22a.NET0260,Table1,11',
                    'astm.f3411.v22a.NET0260,Table1,12',
                    'astm.f3411.v22a.NET0260,Table1,16',
                    'astm.f3411.v22a.NET0260,Table1,17',
                    'astm.f3411.v22a.NET0260,Table1,18',
                    'astm.f3411.v22a.NET0260,Table1,19',
                    'astm.f3411.v22a.NET0260,Table1,20',
                    'astm.f3411.v22a.NET0260,Table1,21',
                    'astm.f3411.v22a.NET0270',
                    'astm.f3411.v22a.NET0290',
                    'astm.f3411.v22a.NET0320',
                    'astm.f3411.v22a.NET0340',
                    'astm.f3411.v22a.NET0500',
                    'astm.f3411.v22a.NET0610',
                    'astm.f3411.v22a.NET0710,1',
                    'astm.f3411.v22a.NET0710,2',
                    'astm.f3411.v22a.NET0740',
                    'astm.f3411.v22a.NET0210',
                    'astm.f3411.v22a.NET0220',
                    'astm.f3411.v22a.NET0240',
                    'astm.f3411.v22a.NET0340',
                    'astm.f3411.v22a.NET0420',
                    'astm.f3411.v22a.NET0430',
                    'astm.f3411.v22a.NET0440',
                    'astm.f3411.v22a.NET0450',
                    'astm.f3411.v22a.NET0460',
                    'astm.f3411.v22a.NET0470',
                    'astm.f3411.v22a.NET0470,Table1,1',
                    'astm.f3411.v22a.NET0470,Table1,2',
                    'astm.f3411.v22a.NET0470,Table1,5',
                    'astm.f3411.v22a.NET0470,Table1,6',
                    'astm.f3411.v22a.NET0470,Table1,10',
                    'astm.f3411.v22a.NET0470,Table1,11',
                    'astm.f3411.v22a.NET0470,Table1,12',
                    'astm.f3411.v22a.NET0470,Table1,16',
                    'astm.f3411.v22a.NET0470,Table1,17',
                    'astm.f3411.v22a.NET0470,Table1,18',
                    'astm.f3411.v22a.NET0470,Table1,19',
                    'astm.f3411.v22a.NET0470,Table1,20',
                    'astm.f3411.v22a.NET0470,Table1,21',
                    'astm.f3411.v22a.NET0480',
                    'astm.f3411.v22a.NET0490',
                    'astm.f3411.v22a.NET0730',
                    'astm.f3411.v22a.DSS0130,A2-6-1,1a',
                    'astm.f3411.v22a.DSS0130,A2-6-1,1b',
                    'astm.f3411.v22a.DSS0130,A2-6-1,1c',
                    'astm.f3411.v22a.DSS0130,A2-6-1,1d',
                    'astm.f3411.v22a.DSS0130,A2-6-1,2a',
                    'astm.f3411.v22a.DSS0130,A2-6-1,2b',
                    'astm.f3411.v22a.DSS0130,A2-6-1,3a',
                    'astm.f3411.v22a.DSS0130,A2-6-1,3b',
                    'astm.f3411.v22a.DSS0130,A2-6-1,3c',
                    'astm.f3411.v22a.DSS0130,A2-6-1,3d',
                    'astm.f3411.v22a.DSS0130,A2-6-1,4a',
                    'astm.f3411.v22a.DSS0130,A2-6-1,4b',
                    'astm.f3411.v22a.DSS0130,A2-6-1,5',
                    'astm.f3411.v22a.DSS0130,A2-6-1,6',
                    'astm.f3411.v22a.DSS0010',
                    'astm.f3411.v22a.DSS0020',
                    'astm.f3411.v22a.DSS0030',
                    'astm.f3411.v22a.DSS0050',
                    'astm.f3411.v22a.DSS0060',
                    'astm.f3411.v22a.DSS0070',
                    'astm.f3411.v22a.DSS0110',
                    'astm.f3411.v22a.DSS0120',
                    'astm.f3411.v22a.DSS0130,1',
                    'astm.f3411.v22a.DSS0130,2,a',
                    'astm.f3411.v22a.DSS0130,2,b',
                    'astm.f3411.v22a.DSS0130,2,c',
                    'astm.f3411.v22a.DSS0130,2,d',
                    'astm.f3411.v22a.DSS0130,2,e',
                    'astm.f3411.v22a.DSS0130,2,f',
                    'astm.f3411.v22a.DSS0130,3,a',
                    'astm.f3411.v22a.DSS0130,3,b',
                    'astm.f3411.v22a.DSS0130,3,c',
                    'astm.f3411.v22a.DSS0130,3,d',
                    'astm.f3411.v22a.DSS0130,3,e',
                    'astm.f3411.v22a.DSS0210',
                    'astm.f3411.v22a.NET0260,Table1,9',
                    'astm.f3411.v22a.NET0470,Table1,9',
                    'astm.f3411.v22a.NET0260,Table1,1a',
                    'astm.f3411.v22a.NET0470,Table1,1a',
                    'astm.f3411.v22a.NET0470,Table1,10',
                    'astm.f3411.v22a.NET0470,Table1,11',
                    'astm.f3411.v22a.NET0260,Table1,14',
                    'astm.f3411.v22a.NET0470,Table1,15',
                    'astm.f3411.v22a.NET0470,Table1,19',
                    'astm.f3411.v22a.NET0470,Table1,20',
                    'astm.f3411.v22a.NET0260,Table1,23',
                    'astm.f3411.v22a.NET0470,Table1,24',
                    'astm.f3411.v22a.NET0260,Table1,7',
                    'astm.f3411.v22a.NET0470,Table1,7',
                    'astm.f3411.v22a.NET0470,Table1,5',
                    // TODO: Add InterUSS requirements
                  ],
                },
                { requirements: ['uspace.article8.MSLAltitude'] },
              ],
            },
          },
          participant_requirements: env.participant_requirements,
          aggregate_participants: env.aggregate_participants,
        },
      ],  // tested_requirements

      // Write out a human-readable report showing the sequence of events of the test
      sequence_view: {},
    },  // artifacts

    validation: {
      // This block defines whether to return an error code from the execution of uss_qualifier, based on the content of the
      // test run report.  All the criteria must be met to return a successful code.
      criteria: [
        {
          // applicability indicates which test report elements the pass_condition applies to
          applicability: {
            // We want to make sure no test scenarios had execution errors
            test_scenarios: {},
          },
          pass_condition: {
            each_element: {
              has_execution_error: false,
            },
          },
        },
        {
          applicability: {
            // We also want to make sure there are no failed checks...
            failed_checks: {
              // ...at least, no failed checks with severity higher than "Low".
              has_severity: {
                higher_than: 'Low',
              },
            },
          },
          pass_condition: {
            // When considering all the applicable elements...
            elements: {
              // ...the number of applicable elements should be zero.
              count: {
                equal_to: 0,
              },
            },
          },
        },
        {
          applicability: {
            // We also want to make sure we don't skip more scenarios that we should
            skipped_actions: {},
          },
          pass_condition: {
            elements: {
              count: {
                // We currently expect this amount of skipped scenarios: making it an equality
                // to make sure this is reduced if some scenarios start to be executed
                equal_to: 2,
              },
            },
          },
        },
      ],  // criteria
    },  // validation
  },  // v1
}
