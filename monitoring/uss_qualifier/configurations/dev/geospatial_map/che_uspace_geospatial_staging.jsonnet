local baseline = import 'che_uspace_geospatial_lib/baseline.libsonnet';
local uss1 = import 'che_uspace_geospatial_lib/uss1.libsonnet';
local env = import 'che_uspace_geospatial_lib/staging/env.libsonnet';

baseline(env([uss1]))
