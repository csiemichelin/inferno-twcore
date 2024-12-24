module InfernoTWCoreIG
  class ImmunizationGroup < Inferno::TestGroup
    title 'Immunization(疫苗接種) Tests'
    description 'Verify that the server makes Immunization resources available'
    id :immunization_group

    input_order :url, :immunization_patient, :immunization_date, :immunization_status, :immunization_resource

    # 必須（SHALL） 支援透過查詢參數 patient 查詢所有Immunization：
    test do
      title '[GET] Server returns valid results for Immunization search by patient'
      description %(
        A server SHALL support searching by patient on the Immunization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-疫苗接種（TW Core Immunization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Immunization-twcore.html)
      )

      input_order :url

      input :immunization_patient,
        title: 'Immunization patient',
        default: 'Patient/pat-nsysu-hd-1'

      # Named requests can be used by other tests
      makes_request :immunization

      run do
        fhir_search('Immunization', params: { 'patient': immunization_patient }, name: :immunization)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 date 查詢所有Immunization：
    test do
      title '[GET] Server returns valid results for Immunization search by patient and date'
      description %(
        A server SHALL support searching by patient and date on the Immunization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-疫苗接種（TW Core Immunization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Immunization-twcore.html)
      )

      input_order :url

      input :immunization_patient,
        title: 'Immunization patient',
        default: 'Patient/pat-nsysu-hd-1'
      
      input :immunization_date,
        title: 'Immunization date',
        default: 'gt2021-07-01'

      run do
        fhir_search('Immunization', params: { 'patient': immunization_patient, 'date': immunization_date })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 status 查詢所有Immunization：
    test do
      title '[GET] Server returns valid results for Immunization search by patient and status'
      description %(
        A server SHALL support searching by patient and status on the Immunization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-疫苗接種（TW Core Immunization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Immunization-twcore.html)
      )

      input_order :url

      input :immunization_patient,
        title: 'Immunization patient',
        default: 'Patient/pat-nsysu-hd-1'
      
      input :immunization_status,
        title: 'Immunization status',
        default: 'completed'

      run do
        fhir_search('Immunization', params: { 'patient': immunization_patient, 'status': immunization_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 patient 的 Immunization resource 是否合規
    test do
      title '[GET] Immunization resource is valid'
      description %(
        Verify that the Immunization resource search by patient returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-疫苗接種（TW Core Immunization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Immunization-twcore.html)
      )
      # This test will use the response from the :immunization request in the
      # previous test
      uses_request :immunization

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Immunization resource is valid'
      description %(
        Verify that the Immunization resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-疫苗接種（TW Core Immunization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Immunization-twcore.html)
      )

      input_order :url

      input :immunization_resource,
        title: 'Immunization Resource',
        default: '''{
          "resourceType" : "Immunization",
          "id" : "imm-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Immunization-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p class=\"res-header-id\"><b>Generated Narrative: Immunization imm-example</b></p><a name=\"imm-example\"> </a><a name=\"hcimm-example\"> </a><a name=\"imm-example-en-US\"> </a><p><b>status</b>: Completed</p><p><b>vaccineCode</b>: <span title=\"Codes:{http://hl7.org/fhir/sid/cvx 197}, {http://hl7.org/fhir/sid/ndc 49281012165}\">influenza, high-dose, quadrivalent</span></p><p><b>patient</b>: <a href=\"Patient-pat-example.html\">陳加玲(official) Female, DoB: 1990-01-01 ( Medical record number\u00a0(use:\u00a0official,\u00a0))</a></p><p><b>encounter</b>: <a href=\"Encounter-enc-example.html\">Encounter: identifier = http://healthcare.example.org/identifiers/enocunter#E22081702; status = finished; class = pre-admission (ActCode#PRENC); type = Annual diabetes mellitus screening; serviceType = Nephrology (qualifier value); period = 2022-08-01 17:00:14+0800 --&gt; 2022-08-01 18:00:14+0800; reasonCode = FH: Diabetes mellitus</a></p><p><b>occurrence</b>: 2020-11-19 12:46:57-0800</p><p><b>primarySource</b>: false</p><p><b>location</b>: <a href=\"Location-loc-ent-example.html\">Location 衛生福利部臺北醫院耳鼻喉科</a></p></div>"
          },
          "status" : "completed",
          "vaccineCode" : {
            "coding" : [{
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "197",
              "display" : "influenza, high-dose, quadrivalent"
            },
            {
              "system" : "http://hl7.org/fhir/sid/ndc",
              "code" : "49281012165",
              "display" : "FLUZONE High-Dose Quadrivalent Northern Hemisphere, 10 SYRINGE, GLASS in 1 PACKAGE (49281-121-65) > .7 mL in 1 SYRINGE, GLASS (49281-121-88) (package)"
            }],
            "text" : "influenza, high-dose, quadrivalent"
          },
          "patient" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          },
          "encounter" : {
            "reference" : "Encounter/13427"
          },
          "occurrenceDateTime" : "2020-11-19T12:46:57-08:00",
          "primarySource" : false,
          "location" : {
            "reference" : "Location/13386"
          }
        }'''
      
      output :immunization_value
      
      run do 
        assert_valid_json(immunization_resource) # For safety
        resource_hash = JSON.parse(immunization_resource)
        immunization_resource = FHIR::Immunization.new(resource_hash)
        # output immunization_value: immunization_resource
        assert_valid_resource(resource: immunization_resource)
        # if resource_is_valid?(resource: immunization_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction Immunizations(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send Immunization Resource to FHIR Server'
      description %(
        Send a input Transaction Immunization(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-疫苗接種（TW Core Immunization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Immunization-twcore.html)
      )

      input_order :url

      input :immunization_resource,
        title: 'Immunization Resource'

      run do 
        resource_hash = JSON.parse(immunization_resource)
        response = fhir_create FHIR::Immunization.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  