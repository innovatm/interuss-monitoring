# Remote Identification test baseline

This folder contains the U-Space Network Remote Identification test suite.

It is composed of:
- the test configuration: [che_uspace_netrid.jsonnet](che_uspace_netrid.jsonnet) which imports:
    - the test baseline: [che_uspace_netrid_lib/baseline.jsonnet](che_uspace_netrid_lib/baseline.jsonnet)
    - the local test environment: [che_uspace_netrid_lib/local/env_all.jsonnet](che_uspace_netrid_lib/local/env_all.jsonnet)

- Expected interuss/monitoring docker image version: v0.19.0


## Self testing

The on-boarding requires USSPs to self validate themselves and provide a report
showing successful run. To achieve it, InterUSS mock implementation can be used.
The following sections describe how to start the mock components on a local environment
and run the uss qualifier with the expected test baseline provided in this repository.

### Start a local UTM ecosystem

- Follow the quick start provided by InterUSS to start the components: https://github.com/interuss/monitoring/tree/main/monitoring/uss_qualifier#quick-start
- Make sure you have checked out the expected version (see top of this document for expected version), for instance: `git checkout interuss/monitoring/v0.19.0` inside the monitoring folder.

### Run the USS qualifier with the baseline

- Copy the content of this folder to `monitoring/uss_qualifier/configurations/dev/`.
- Edit `local/uss2.libsonnet` with the URLs of your service.
- Run the USS qualifier: `monitoring/uss_qualifer/run_locally.sh configurations.dev.che_uspace_netrid`
- Review the report by opening `monitoring/uss_qualifier/output/che_uspace_netrid`


