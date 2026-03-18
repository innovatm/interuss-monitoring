{
  // Feature check table with real FOCA Swiss geozone coordinates.
  // These checks verify our USS correctly interprets ED-318 geozone data
  // ingested from the FOCA CISP source.
  feature_check_table: {
    resource_type: 'resources.interuss.geospatial_map.FeatureCheckTableResource',
    specification: {
      table: {
        rows: [
          {
            // Position inside KTUR001 Reussdelta nature protection zone (lat ~46.89, lng ~8.60)
            geospatial_check_id: 'FOCA_KTUR001_INSIDE',
            requirement_ids: [],
            description: 'Position inside KTUR001 Reussdelta nature protection zone',
            volumes: [{
              outline_circle: {
                center: { lng: 8.6028, lat: 46.8950 },
                radius: { value: 50, units: 'M' },
              },
              altitude_lower: { value: 0, units: 'M', reference: 'SFC' },
              altitude_upper: { value: 100, units: 'M', reference: 'SFC' },
            }],
            expected_result: 'Block',
          },
          {
            // Position inside VBS_15 Grolley military installation zone (lat ~46.83, lng ~7.06)
            geospatial_check_id: 'FOCA_VBS15_INSIDE',
            requirement_ids: [],
            description: 'Position inside VBS_15 Grolley military installation zone',
            volumes: [{
              outline_circle: {
                center: { lng: 7.0570, lat: 46.8315 },
                radius: { value: 50, units: 'M' },
              },
              altitude_lower: { value: 0, units: 'M', reference: 'SFC' },
              altitude_upper: { value: 100, units: 'M', reference: 'SFC' },
            }],
            expected_result: 'Block',
          },
          {
            // Position in open area near Lucerne, outside known FOCA zones (lat ~47.2, lng ~8.0)
            geospatial_check_id: 'NO_ZONE_OPEN',
            requirement_ids: [],
            description: 'Position in open area with no geospatial restrictions',
            volumes: [{
              outline_circle: {
                center: { lng: 8.0, lat: 47.2 },
                radius: { value: 50, units: 'M' },
              },
              altitude_lower: { value: 0, units: 'M', reference: 'SFC' },
              altitude_upper: { value: 50, units: 'M', reference: 'SFC' },
            }],
            expected_result: 'Neither',
          },
        ],
      },
    },
  },
}
