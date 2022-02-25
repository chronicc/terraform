# Elastic Kubernetes Service

## File Content Concept

* Resources are bundled inside resource and provider specific files. Files are named with the pattern `<provider-abbreviation>_<resource>.tf`.
  * Having few resources of the same type or having resources strongly connected to each other (e.g. when creating accounts and roles), such resources can be contained in on file. Files are named with the pattern `<provider-abbreviation>_<topic>.tf`.
* General definitions are kept in their belonging files respectively:
  * Outputs: `outputs.tf`
  * Provider Definition: `providers.tf`
  * Dependencies and Versions: `requirements.tf`
  * Variables: `variables.tf`
