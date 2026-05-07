// Local environment: uspace-services running on localhost:8090 with NoAuth
function(participants) {
  resource_declarations: {
    utm_auth: {
      resource_type: 'resources.communications.AuthAdapterResource',
      specification: {
        environment_variable_containing_auth_spec: 'AUTH_SPEC',
        scopes_authorized: [
          'interuss.geospatial_map.query',
          'interuss.geospatial_map.direct_automated_test',
        ],
      },
    },

    geospatial_info_provider: {
      resource_type: 'resources.geospatial_info.GeospatialInfoProviderResource',
      dependencies: { auth_adapter: 'utm_auth' },
      specification: {
        geospatial_info_provider: participants[0].local_env.geospatial_info_provider,
      },
    },
  },
}
