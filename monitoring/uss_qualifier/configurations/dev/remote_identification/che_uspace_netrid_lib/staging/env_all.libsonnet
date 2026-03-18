local env_staging = import 'env.libsonnet';
local uss1 = import '../uss1.libsonnet';
local uss2 = import '../uss2.libsonnet';

env_staging([uss1, uss2])
