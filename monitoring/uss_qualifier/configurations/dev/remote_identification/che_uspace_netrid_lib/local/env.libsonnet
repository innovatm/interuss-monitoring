function(participants) {
  // This file contains environmental (non-baseline) parameters for the che_uspace_netrid.jsonnet test configuration for the standard local CI environment.
  // It is parameterized on which participants to include in the test.  Each participant is expected to have a "local_env" block in their definitions.
  // Top-level keys are used in che_uspace_netrid.jsonnet when this content is provided as `env`.
  resource_declarations: {

    utm_client_identity: {
      resource_type: 'resources.communications.ClientIdentityResource',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        whoami_audience: 'localhost',
        whoami_scope: 'rid.display_provider',
      },
    },

    // Means by which uss_qualifier can obtain authorization to make requests in an ASTM USS ecosystem
    utm_auth: {
      resource_type: 'resources.communications.AuthAdapterResource',
      specification: {
        // To avoid putting secrets in configuration files, the auth spec (including sensitive information) will be read from the AUTH_SPEC environment variable
        environment_variable_containing_auth_spec: 'AUTH_SPEC',
        scopes_authorized: [
          // InterUSS flight_planning v1 automated testing API
          'rid.inject_test_data',

          // InterUSS versioning automated testing API
          'interuss.versioning.read_system_versions',

          // ASTM F3411-22a USS roles
          'rid.service_provider',
          'rid.display_provider',

          // ASTM F3548-21 DSS roles
          'dss.read.identification_service_areas',
          'dss.write.identification_service_areas',
        ],
      },
    },
    service_providers: {
      resource_type: 'resources.netrid.NetRIDServiceProviders',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        service_providers: [
          participant.local_env.service_provider
          for participant in participants
          if 'service_provider' in participant.local_env
        ],
      },
    },
    observers: {
      resource_type: 'resources.netrid.NetRIDObserversResource',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        observers: [
          participant.local_env.observer
          for participant in participants
          if 'observer' in participant.local_env
        ],
      },
    },
    // Location of DSS instance that can be used to verify flight planning outcomes
    netrid_dss_instances: {
      resource_type: 'resources.astm.f3411.DSSInstancesResource',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        dss_instances: [
          instance
          for participant in participants
          if 'dss_instances' in participant.local_env
          for instance in participant.local_env.dss_instances
        ],
      },
    },

    mock_uss_instance_dp: {
      resource_type: 'resources.interuss.mock_uss.client.MockUSSResource',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        participant_id: 'mock_uss',
        mock_uss_base_url: 'https://mock.dss.uspacekeeper.com/mock_uss_riddp',
        timeout_seconds: null,
      },
    },

    mock_uss_instance_sp: {
      resource_type: 'resources.interuss.mock_uss.client.MockUSSResource',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        participant_id: 'mock_uss',
        mock_uss_base_url: 'https://mock.dss.uspacekeeper.com/mock_uss_ridsp',
        timeout_seconds: null,
      },
    },

    uss_identification: {
      resource_type: 'resources.interuss.uss_identification.USSIdentificationResource',
      specification: {
        uss_identifiers: {
          uss1: {
            astm_url_regexes: ['http://[^/]*uss1\\.localutm.*'],
          },
          uss2: {
            astm_url_regexes: ['http://[^/]*uss2\\.localutm.*'],
          },
          uss3: {
            astm_url_regexes: ['http://[^/]*uss3\\.localutm.*'],
          },
        },
      },
      dependencies: {},
    },

    dss_datastore_cluster: {
      resource_type: 'resources.interuss.datastore.datastore.DatastoreDBClusterResource',
      specification: {
        nodes: [
          {
            participant_id: dss_instance.participant_id,
            host: datastore_node.host,
            port: datastore_node.port,
          }
          for participant in participants
          if 'dss_instances' in participant.local_env
          for dss_instance in participant.local_env.dss_instances
          if 'datastore_nodes' in dss_instance
          for datastore_node in dss_instance.datastore_nodes
        ],
      },
    },
  },

  aggregate_participants: {
    [participant.participant_id]: participant.aggregate_participant_ids
    for participant in participants
    if 'aggregate_participant_ids' in participant
  },

  participant_requirements: {
    [participant.participant_id]: participant.participant_requirements
    for participant in participants
  },
}
