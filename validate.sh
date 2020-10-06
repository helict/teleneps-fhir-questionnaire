#/usr/bin/env sh

ajv -s fhir-schemas/fhir.schema.json \
    -d Questionnaire*.json \
    -d "Terminology/CodeSystems/*.json" \
    -d "Terminology/ValueSets/*.json" \
    --remove-additional=failing
