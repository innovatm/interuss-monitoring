{
  participant_id: 'uss1',
  participant_requirements: 'U-Space Network Identification',
  aggregate_participant_ids: ['uss1', 'uss1_dss'],

  // uss1 is mock_uss on uspacekeeper — same URLs for all environments
  local_env: self.common_env,
  staging_env: self.common_env,

  common_env: {
    service_provider: {
      participant_id: 'uss1',
      injection_base_url: 'https://mock.dss.uspacekeeper.com/mock_uss_ridsp/ridsp/injection',
    },
    observer: {
      participant_id: 'uss1',
      observation_base_url: 'https://mock.dss.uspacekeeper.com/mock_uss_riddp/riddp/observation',
    },
    dss_instances: [
      {
        participant_id: 'uss1_dss',
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
