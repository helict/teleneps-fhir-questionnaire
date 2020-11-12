#/usr/bin/env sh

curl -sL https://github.com/mledoze/countries/raw/master/dist/countries.json | jq '
{
  resourceType: "ValueSet",
  meta: {
    profile: ["http://hl7.org/fhir/StructureDefinition/shareablevalueset"]
  }, 
  url: "http://tele-neps.de/fhir/ValueSet/Iso3166-1-2", 
  name: "Iso3166-1-2", 
  title: "ISO 3166 Part 1: 2 Letter Codes", 
  status: "draft", 
  experimental: "true", 
  publisher: "Telemedizinisches Netzwerk Psychotraumatologie Sachsen (Tele-NePS)", 
  contact: [
    {
      telecom: [
        {
          system: "url",
          value: "https://www.telehealth-ostsachsen.de/projekte/tele-neps"
        },
        {
          system: "phone",
          value: "+49 351 458 6726"
        },
        {
          system: "fax",
          value: "+49 351 458 7211"
        }
      ]
    }
  ],
  description : "This value set defines the ISO 3166 Part 1 2-letter codes",
  compose: {
    include: [
      {
        system: "urn:iso:std:iso:3166", 
	      concept: map({
          code: .cca2, 
	        display: .name.common, 
	        designation: [
	          {
	            language: "de", 
	            value: .translations.deu.common
	          }
          ]
        })
      }
    ]
  }
}' > ValueSet.Iso3166-1-2.json
