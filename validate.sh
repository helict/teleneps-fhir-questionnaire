#/usr/bin/env sh

# Check if ajv-cli for JSON schema validation is installed
[ -z "$(command -v ajv)" ] && echo "Please install ajv-cli: https://www.npmjs.com/package/ajv-cli" && exit 1

ajv -s fhir-schemas/fhir.schema.json \
    -d "Examples/*.json" \
    -d "Terminologies/**/*.json" \
    --remove-additional=failing

[ $? -eq 0 ] || exit 1

# Check if java runtime is installed
[ -z "$(command -v java)" ] && echo "Please install java runtime environment: https://openjdk.java.net/install" && exit 1

# Download FHIR validator if not exist and validate FHIR resources
[ ! -f ./validator_cli.jar ] && wget https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar

java -jar validator_cli.jar Examples/Questionnaire.json \
     -profile http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire \
     -ig ExtensionProfiles/StructureDefinition-sdc-questionnaire.json \
     -ig ExtensionProfiles/StructureDefinition-sdc-questionnaire-preferredTerminologyServer.json \
     -ig ExtensionProfiles/StructureDefinition-sdc-questionnaire-performerType.json \
     -ig ExtensionProfiles/StructureDefinition-sdc-questionnaire-answerExpression.json \
     -ig ExtensionProfiles/StructureDefinition-sdc-questionnaire-choiceConstraint.json \
     -ig ExtensionProfiles/extension-designnote.json \
     -ig ExtensionProfiles/extension-questionnaire-unit.json \
     -version 4.0.1 \
     -debug
