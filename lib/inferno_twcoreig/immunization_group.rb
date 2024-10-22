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
  
          Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.
  
          [臺灣核心-疫苗接種（TW Core Immunization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Immunization-twcore.html)
        )
  
        input :immunization_patient,
          title: 'Immunization patient'
  
        # Named requests can be used by other tests
        makes_request :immunization
  
        run do
          fhir_search('Immunization', params: { 'patient': immunization_patient }, name: :immunization)
  
          assert_response_status(200)
          assert_resource_type('Immunization')
        end
      end
  
      # 建議應該（SHOULD） 支援透過查詢參數 patient 及 date 查詢所有Immunization：
      test do
        title '[GET] Server returns valid results for Immunization search by patient and date'
        description %(
          A server SHALL support searching by patient and date on the Immunization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.
  
          [臺灣核心-疫苗接種（TW Core Immunization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Immunization-twcore.html)
        )
  
        input :immunization_patient,
          title: 'Immunization patient'
        
        input :immunization_date,
          title: 'Immunization date'
  
        run do
          fhir_search('Immunization', params: { 'patient': immunization_patient, 'date': immunization_date })
  
          assert_response_status(200)
          assert_resource_type('Immunization')
        end
      end

      # 建議應該（SHOULD） 支援透過查詢參數 patient 及 status 查詢所有Immunization：
      test do
        title '[GET] Server returns valid results for Immunization search by patient and status'
        description %(
          A server SHALL support searching by patient and status on the Immunization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.
  
          [臺灣核心-疫苗接種（TW Core Immunization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Immunization-twcore.html)
        )
  
        input :immunization_patient,
          title: 'Immunization patient'
        
        input :immunization_status,
          title: 'Immunization status'
  
        run do
          fhir_search('Immunization', params: { 'patient': immunization_patient, 'status': immunization_status })
  
          assert_response_status(200)
          assert_resource_type('Immunization')
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
          assert_resource_type('Immunization')
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
        input :immunization_resource,
          title: 'Immunization Resource'
        
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
  