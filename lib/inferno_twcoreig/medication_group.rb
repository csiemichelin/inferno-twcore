module InfernoTWCoreIG
  class MedicationGroup < Inferno::TestGroup
    title 'Medication(藥品) Tests'
    description 'Verify that the server makes Medication resources available'
    id :medication_group

    input_order :url, :medication_id, :medication_code, :medication_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Medication：
    test do
      title '[GET] Server returns valid results for Medication search by _id'
      description %(
        A server SHALL support searching by _id on the Medication resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-藥品（TW Core Medication）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Medication-twcore.html)
      )

      input_order :url

      input :medication_id,
        title: 'Medication _id'

      # Named requests can be used by other tests
      makes_request :medication

      run do
        fhir_search('Medication', params: { _id: medication_id }, name: :medication)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 code 查詢所有Medication：
    test do
      title '[GET] Server returns valid results for Medication search by code'
      description %(
        A server SHALL support searching by code on the Medication resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-藥品（TW Core Medication）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Medication-twcore.html)
      )

      input_order :url

      input :medication_code,
        title: 'Medication code'

      run do
        fhir_search('Medication', params: { code: medication_code })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Medication resource 是否合規
    test do
      title '[GET] Medication resource is valid'
      description %(
        Verify that the Medication resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-藥品（TW Core Medication）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Medication-twcore.html)
      )
      # This test will use the response from the :medication request in the
      # previous test
      uses_request :medication

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Medication resource is valid'
      description %(
        Verify that the Medication resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-藥品（TW Core Medication）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Medication-twcore.html)
      )

      input_order :url

      input :medication_resource,
            title: 'Medication Resource'
      
      output :medication_value
      
      run do 
        assert_valid_json(medication_resource) # For safety
        resource_hash = JSON.parse(medication_resource)
        medication_resource = FHIR::Medication.new(resource_hash)
        # output medication_value: medication_resource
        assert_valid_resource(resource: medication_resource)
        # if resource_is_valid?(resource: medication_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Medication Resource to FHIR Server'
      description %(
        Send a input Medication resource to a FHIR server database.

        [臺灣核心-藥品（TW Core Medication）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Medication-twcore.html)
      )

      input_order :url

      input :medication_resource,
            title: 'Medication Resource'

      run do 
        resource_hash = JSON.parse(medication_resource)
        response = fhir_create FHIR::Medication.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
