#/usr/bin/env sh

ajv -s fhir-schemas/fhir.schema.json \
    -d "Example/*.json" \
    -d "Terminology/CodeSystems/*.json" \
    -d "Terminology/ValueSets/**/*.json" \
    --remove-additional=failing
