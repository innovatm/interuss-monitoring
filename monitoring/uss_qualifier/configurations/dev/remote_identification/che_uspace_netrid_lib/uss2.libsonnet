{
  participant_id: 'uss2',
  participant_requirements: 'U-Space Network Identification',
  aggregate_participant_ids: ['uss2', 'uss2_dss'],

  // uspace-services running locally
  local_env: {
    service_provider: {
      participant_id: 'uss2',
      injection_base_url: 'http://localhost:8090/ridsp/injection',
    },
    observer: {
      participant_id: 'uss2',
      observation_base_url: 'http://localhost:8090/riddp/observation',
    },
    dss_instances: [
      {
        participant_id: 'uss2_dss',
        rid_version: 'F3411-22a',
        base_url: 'https://dss.uspacekeeper.com/rid/v2',
        user_participant_ids: ['mock_uss'],
        datastore_nodes: [
          { host: 'ybdb.dss.uspacekeeper.com', port: 5433 },
        ],
      },
    ],
  },

  // uspace-services on staging
  staging_env: {
    service_provider: {
      participant_id: 'uss2',
      injection_base_url: 'https://staging.uspacekeeper.com/ridsp/injection',
    },
    observer: {
      participant_id: 'uss2',
      observation_base_url: 'https://staging.uspacekeeper.com/riddp/observation',
    },
    dss_instances: [
      {
        participant_id: 'uss2_dss',
        rid_version: 'F3411-22a',
        base_url: 'https://dss.uspacekeeper.com/rid/v2',
        user_participant_ids: ['mock_uss'],
        datastore_nodes: [
          { host: 'ybdb.dss.uspacekeeper.com', port: 5433 },
        ],
      },
    ],
  },
}
