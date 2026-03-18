{
  participant_id: 'uss1',
  participant_requirements: 'UAS Flight Authorisation SDD V1',
  aggregate_participant_ids: ['uss1_core', 'uss1_dss'],

  // uss1 is mock_uss on uspacekeeper — same URLs for all environments
  local_env: self.common_env,
  staging_env: self.common_env,

  common_env: {
    flight_planner: {
      participant_id: 'uss1_core',
      v1_base_url: 'https://mock.dss.uspacekeeper.com/mock_uss_scdsc_a/flight_planning/v1',
    },
    test_env_version_provider: {
      participant_id: 'uss1_core',
      interuss: {
        base_url: 'https://mock.dss.uspacekeeper.com/mock_uss_scdsc_a/versioning',
      },
    },
    prod_env_version_provider: {
      participant_id: 'uss1_core',
      interuss: {
        base_url: 'https://mock.dss.uspacekeeper.com/mock_uss_scdsc_a/versioning',
      },
    },
    dss_instances: [
      {
        participant_id: 'uss1_dss',
        user_participant_ids: ['mock_uss'],
        base_url: 'https://dss.uspacekeeper.com',
        supports_ovn_request: true,
        datastore_nodes: [
          { host: 'ybdb.dss.uspacekeeper.com', port: 5433 },
        ],
      },
    ],
  },
}
