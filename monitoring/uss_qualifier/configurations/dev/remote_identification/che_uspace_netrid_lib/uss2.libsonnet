{
  // ID of participant
  participant_id: 'uss2',

  // Set of requirements this participant wants to satisfy
  participant_requirements: 'U-Space Network Identification',

  // (optional) IDs of subparticipants that make up this participant
  aggregate_participant_ids: [
    'uss2',
    'uss2_dss',
  ],

  // Definition of this participant's systems in the local environment
  local_env: {
    // (optional) Means by which to interact with the participant as a service provider
    service_provider: {
      participant_id: 'uss2',
      injection_base_url: 'http://host.docker.internal:8088/ridsp/injection',
    },

    // (optional) Means by which to interact with the participant as a display provider
    observer: {
      participant_id: 'uss2',
      observation_base_url: 'http://host.docker.internal:8088/riddp/observation',
    },

    // (optional) List of DSS instances hosted by this participant
    dss_instances: [
      {
        participant_id: 'uss2_dss',
        rid_version: 'F3411-22a',
        base_url: 'https://dss.uspacekeeper.com/rid/v2',
        user_participant_ids: [
          // Participants using a DSS instance they do not provide should be listed as users of that DSS (so that they can take credit for USS requirements enforced by the DSS)
          'mock_uss',  // mock_uss uses this DSS instance; it does not provide its own instance
        ],
        // (optional) List of datastore nodes of this DSS instance
        datastore_nodes: [
          {
            host: 'https://ybdb.dss.uspacekeeper.com',
            port: 5433,
          },
        ],
      },
    ],
  },
}
