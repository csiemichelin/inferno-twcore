module InfernoTWCoreIG
  class AllergyIntoleranceGroup < Inferno::TestGroup
    title 'AllergyIntolerance(過敏或不耐症) Tests'
    description 'Verify that the server makes AllergyIntolerance resources available'
    id :allergyIntolerance_group

    input_order :url, :allergyIntolerance_id, :allergyIntolerance_clinicalStatus, :allergyIntolerance_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有AllergyIntolerance：
    test do
      title '[GET] Server returns valid results for AllergyIntolerance search by _id'
      description %(
        A server SHALL support searching by _id on the AllergyIntolerance resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )
      
      input_order :url

      input :allergyIntolerance_id,
        title: 'AllergyIntolerance _id'

      # Named requests can be used by other tests
      makes_request :allergyIntolerance

      run do
        fhir_search('AllergyIntolerance', params: { _id: allergyIntolerance_id }, name: :allergyIntolerance)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 clinical-status 查詢所有AllergyIntolerance：
    test do
      title '[GET] Server returns valid results for AllergyIntolerance search by clinical-status'
      description %(
        A server SHALL support searching by clinical-status on the AllergyIntolerance resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )

      input_order :url

      input :allergyIntolerance_clinicalStatus,
            title: 'AllergyIntolerance clinical-status'

      run do
        fhir_search('AllergyIntolerance', params: { 'clinical-status': allergyIntolerance_clinicalStatus })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 AllergyIntolerance resource 是否合規
    test do
      title '[GET] AllergyIntolerance resource is valid'
      description %(
        Verify that the AllergyIntolerance resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )
      # This test will use the response from the :allergyIntolerance request in the
      # previous test
      uses_request :allergyIntolerance

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input AllergyIntolerance resource is valid'
      description %(
        Verify that the AllergyIntolerance resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )

      input_order :url

      input :allergyIntolerance_resource,
            title: 'AllergyIntolerance Resource'
      
      output :allergyIntolerance_value
      
      run do 
        assert_valid_json(allergyIntolerance_resource) # For safety
        resource_hash = JSON.parse(allergyIntolerance_resource)
        allergyIntolerance_resource = FHIR::AllergyIntolerance.new(resource_hash)
        # output allergyIntolerance_value: allergyIntolerance_resource
        assert_valid_resource(resource: allergyIntolerance_resource)
        # if resource_is_valid?(resource: allergyIntolerance_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send AllergyIntolerance Resource to FHIR Server'
      description %(
        Send a input AllergyIntolerance resource to a FHIR server database.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )

      input_order :url
      
      input :allergyIntolerance_resource,
            title: 'AllergyIntolerance Resource'

      run do 
        resource_hash = JSON.parse(allergyIntolerance_resource)
        response = fhir_create FHIR::AllergyIntolerance.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
