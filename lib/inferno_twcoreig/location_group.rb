module InfernoTWCoreIG
  class LocationGroup < Inferno::TestGroup
    title 'Location(地點) Tests'
    description 'Verify that the server makes Location resources available'
    id :location_group

    input_order :url, :location_id, :location_address, :location_name, :location_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Location：
    test do
      title '[GET] Server returns valid results for Location search by _id'
      description %(
        A server SHALL support searching by _id on the Location resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_id,
        title: 'Location _id'

      # Named requests can be used by other tests
      makes_request :location

      run do
        fhir_search('Location', params: { _id: location_id }, name: :location)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 address 查詢所有Location：
    test do
      title '[GET] Server returns valid results for Location search by address'
      description %(
        A server SHALL support searching by address on the Location resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_address,
        title: 'Location address'

      run do
        fhir_search('Location', params: { address: location_address })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 name 查詢所有Location：
    test do
      title '[GET] Server returns valid results for Location search by name'
      description %(
        A server SHALL support searching by name on the Location resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_name,
        title: 'Location name'

      run do
        fhir_search('Location', params: { name: location_name })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Location resource 是否合規
    test do
      title '[GET] Location resource is valid'
      description %(
        Verify that the Location resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )
      # This test will use the response from the :location request in the
      # previous test
      uses_request :location

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Location resource is valid'
      description %(
        Verify that the Location resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_resource,
            title: 'Location Resource'
      
      output :location_value
      
      run do 
        assert_valid_json(location_resource) # For safety
        resource_hash = JSON.parse(location_resource)
        location_resource = FHIR::Location.new(resource_hash)
        # output location_value: location_resource
        assert_valid_resource(resource: location_resource)
        # if resource_is_valid?(resource: location_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Location Resource to FHIR Server'
      description %(
        Send a input Location resource to a FHIR server database.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_resource,
            title: 'Location Resource'

      run do 
        resource_hash = JSON.parse(location_resource)
        response = fhir_create FHIR::Location.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
