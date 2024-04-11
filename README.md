# Initial Setup
- Don't forget to authorize the CLI!
gcloud config set project
gcloud auth login
gcloud auth application-default login


# Bucket Behaviour
Default Behaviours?
- should we test for things like:
    - uniform_bucket_level_access = true
    - storage_class = "STANDARD"
- is this behaviour that we always want for buckets on the platform?

Expected Failures (unit)
- test_failure_when_1_dual_region_passed


Outputs(probably integration only)
- test_bucket_created_with_random_4_character_suffix
- test_self_link_is_correct
- test_url
- test_notifications





