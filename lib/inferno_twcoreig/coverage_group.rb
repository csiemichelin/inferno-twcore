module InfernoTWCoreIG
  class CoverageGroup < Inferno::TestGroup
    title 'Coverage(給付範圍) Tests'
    description 'Verify that the server makes Coverage resources available'
    id :coverage_group

    input_order :url, :coverage_patient, :coverage_resource

    # 必須（SHALL） 支援透過查詢參數 patient：
    test do
      title '[GET] Server returns valid results for Coverage search by patient'
      description %(
        A server SHALL support searching by patient on the Coverage resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-給付範圍（TW Core Coverage）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Coverage-twcore.html)
      )

      input_order :url

      input :coverage_patient,
        title: 'Coverage patient'

      # Named requests can be used by other tests
      makes_request :coverage

      run do
        fhir_search('Coverage', params: { 'patient': coverage_patient }, name: :coverage)

        assert_response_status(200)
        assert_resource_type('Coverage')
      end
    end

    # 驗證查詢 patient 的 Coverage resource 是否合規
    test do
      title '[GET] Coverage resource is valid'
      description %(
        Verify that the Coverage resource search by patient returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-給付範圍（TW Core Coverage）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Coverage-twcore.html)
      )
      # This test will use the response from the :coverage request in the
      # previous test
      uses_request :coverage

      run do
        assert_response_status(200)
        assert_resource_type('Coverage')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Coverage resource is valid'
      description %(
        Verify that the Coverage resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-給付範圍（TW Core Coverage）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Coverage-twcore.html)
      )

      input_order :url

      input :coverage_resource,
        title: 'Coverage Resource'
      
      output :coverage_value
      
      run do 
        assert_valid_json(coverage_resource) # For safety
        resource_hash = JSON.parse(coverage_resource)
        coverage_resource = FHIR::Coverage.new(resource_hash)
        # output coverage_value: coverage_resource
        assert_valid_resource(resource: coverage_resource)
        # if resource_is_valid?(resource: coverage_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction Coverages(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send Coverage Resource to FHIR Server'
      description %(
        Send a input Transaction Coverage(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-給付範圍（TW Core Coverage）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Coverage-twcore.html)
      )

      input_order :url
      
      input :coverage_resource,
        title: 'Coverage Resource'

      run do 
        resource_hash = JSON.parse(coverage_resource)
        response = fhir_create FHIR::Coverage.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  