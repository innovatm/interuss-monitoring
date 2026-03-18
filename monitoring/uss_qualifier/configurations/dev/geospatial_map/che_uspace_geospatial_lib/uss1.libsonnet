{
  // uspace-services as the geospatial map provider under test
  participant_id: 'uspace_services',

  participant_requirements: 'Geospatial Map Provider',

  local_env: {
    geospatial_info_provider: {
      participant_id: 'uspace_services',
      geospatial_map_v1_base_url: 'http://localhost:8090/geospatial_map/v1',
    },
  },

  staging_env: {
    geospatial_info_provider: {
      participant_id: 'uspace_services',
      geospatial_map_v1_base_url: 'https://staging.uspace.uspacekeeper.com/geospatial_map/v1',
    },
  },
}
