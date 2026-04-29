function(participants) {
  // Staging environment — reads staging_env from participants.
  // AUTH_SPEC='DummyOAuth(https://dss.uspacekeeper.com/token,uss_qualifier)'
  resource_declarations: {
    utm_client_identity: {
      resource_type: 'resources.communications.ClientIdentityResource',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        whoami_audience: 'localhost',
        whoami_scope: 'rid.display_provider',
      },
    },

    utm_auth: {
      resource_type: 'resources.communications.AuthAdapterResource',
      specification: {
        environment_variable_containing_auth_spec: 'AUTH_SPEC',
        scopes_authorized: [
          'rid.inject_test_data',
          'interuss.versioning.read_system_versions',
          'rid.service_provider',
          'rid.display_provider',
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
          participant.staging_env.service_provider
          for participant in participants
          if 'service_provider' in participant.staging_env
        ],
      },
    },
    observers: {
      resource_type: 'resources.netrid.NetRIDObserversResource',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        observers: [
          participant.staging_env.observer
          for participant in participants
          if 'observer' in participant.staging_env
        ],
      },
    },
    netrid_dss_instances: {
      resource_type: 'resources.astm.f3411.DSSInstancesResource',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        dss_instances: [
          instance
          for participant in participants
          if 'dss_instances' in participant.staging_env
          for instance in participant.staging_env.dss_instances
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
            astm_url_regexes: ['https://mock\\.dss\\.uspacekeeper\\.com.*'],
          },
          uss2: {
            astm_url_regexes: ['https://staging\\.uspacekeeper\\.com.*'],
          },
          uss3: {
            astm_url_regexes: ['https://mock\\.dss\\.uspacekeeper\\.com.*'],
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
          if 'dss_instances' in participant.staging_env
          for dss_instance in participant.staging_env.dss_instances
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
