{
  participant_id: 'uss2',
  participant_requirements: 'UAS Flight Authorisation SDD V1',
  aggregate_participant_ids: ['uss2_core', 'uss2_dss'],

  // uspace-services running locally
  local_env: {
    flight_planner: {
      participant_id: 'uss2_core',
      v1_base_url: 'http://localhost:8090/flight_planning/v1',
    },
    test_env_version_provider: {
      participant_id: 'uss2_core',
      interuss: {
        base_url: 'http://localhost:8090/versioning',
      },
    },
    prod_env_version_provider: {
      participant_id: 'uss2_core',
      interuss: {
        base_url: 'http://localhost:8090/versioning',
      },
    },
    dss_instances: [
      {
        participant_id: 'uss2_dss',
        base_url: 'https://dss.uspacekeeper.com',
        supports_ovn_request: true,
        datastore_nodes: [
          { host: 'ybdb.dss.uspacekeeper.com', port: 5433 },
        ],
      },
    ],
  },

  // uspace-services on staging
  staging_env: {
    flight_planner: {
      participant_id: 'uss2_core',
      v1_base_url: 'https://staging.uspace.uspacekeeper.com/flight_planning/v1',
    },
    test_env_version_provider: {
      participant_id: 'uss2_core',
      interuss: {
        base_url: 'https://staging.uspace.uspacekeeper.com/versioning',
      },
    },
    prod_env_version_provider: {
      participant_id: 'uss2_core',
      interuss: {
        base_url: 'https://staging.uspace.uspacekeeper.com/versioning',
      },
    },
    dss_instances: [
      {
        participant_id: 'uss2_dss',
        base_url: 'https://dss.uspacekeeper.com',
        supports_ovn_request: true,
        datastore_nodes: [
          { host: 'ybdb.dss.uspacekeeper.com', port: 5433 },
        ],
      },
    ],
  },
}
