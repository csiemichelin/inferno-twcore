module InfernoTWCoreIG
  class ServiceRequestGroup < Inferno::TestGroup
    title 'ServiceRequest(服務請求) Tests'
    description 'Verify that the server makes ServiceRequest resources available'
    id :serviceRequest_group

    input_order :url, :serviceRequest_id, :serviceRequest_patient, :serviceRequest_category, :serviceRequest_authored, :serviceRequest_status, :serviceRequest_code, :serviceRequest_resource

    # 必須（SHALL） 支援透過查詢參數 _id 查詢所有ServiceRequest：
    test do
      title '[GET] Server returns valid results for ServiceRequest search by _id'
      description %(
        A server SHALL support searching by _id on the ServiceRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_id,
        title: 'ServiceRequest _id'

      # Named requests can be used by other tests
      makes_request :serviceRequest

      run do
        fhir_search('ServiceRequest', params: { '_id': serviceRequest_id }, name: :serviceRequest)

        assert_response_status(200)
        assert_resource_type('ServiceRequest')
      end
    end

    # 必須（SHALL） 支援透過查詢參數 patient 查詢所有ServiceRequest：
    test do
      title '[GET] Server returns valid results for ServiceRequest search by patient'
      description %(
        A server SHALL support searching by patient on the ServiceRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_patient,
        title: 'ServiceRequest patient'

      # Named requests can be used by other tests
      makes_request :serviceRequest

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient }, name: :serviceRequest)

        assert_response_status(200)
        assert_resource_type('ServiceRequest')
      end
    end

    # 必須（SHALL） 支援透過查詢參數 patient 及 category 查詢所有ServiceRequest：
    test do
      title '[GET] Server returns valid results for ServiceRequest search by patient and category'
      description %(
        A server SHALL support searching by patient and category on the ServiceRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_patient,
        title: 'ServiceRequest patient'

      input :serviceRequest_category,
        title: 'ServiceRequest category'

      # Named requests can be used by other tests
      makes_request :serviceRequest

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient, 'category': serviceRequest_category }, name: :serviceRequest)

        assert_response_status(200)
        assert_resource_type('ServiceRequest')
      end
    end

    # 必須（SHALL） 支援透過查詢參數 patient 、 category 及 authored 查詢所有ServiceRequest：
    test do
      title '[GET] Server returns valid results for ServiceRequest search by patient, category and authored'
      description %(
        A server SHALL support searching by patient, category and authored on the ServiceRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_patient,
        title: 'ServiceRequest patient'

      input :serviceRequest_category,
        title: 'ServiceRequest category'

      input :serviceRequest_authored,
        title: 'ServiceRequest authored'

      # Named requests can be used by other tests
      makes_request :serviceRequest

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient, 'category': serviceRequest_category, 'authored': serviceRequest_authored }, name: :serviceRequest)

        assert_response_status(200)
        assert_resource_type('ServiceRequest')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 status 查詢所有ServiceRequest：
    test do
      title '[GET] Server returns valid results for ServiceRequest search by patient and status'
      description %(
        A server SHALL support searching by patient and status on the ServiceRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_patient,
        title: 'ServiceRequest patient'
      
      input :serviceRequest_status,
        title: 'ServiceRequest status'

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient, 'status': serviceRequest_status })

        assert_response_status(200)
        assert_resource_type('ServiceRequest')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 、 code 及 authored 查詢所有ServiceRequest：
    test do
      title '[GET] Server returns valid results for ServiceRequest search by patient, code and authored'
      description %(
        A server SHALL support searching by patient, code and authored on the ServiceRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_patient,
        title: 'ServiceRequest patient'
      
      input :serviceRequest_code,
        title: 'ServiceRequest patient'
      
      input :serviceRequest_authored,
        title: 'ServiceRequest authored'

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient, 'code': serviceRequest_code, 'authored': serviceRequest_authored })

        assert_response_status(200)
        assert_resource_type('ServiceRequest')
      end
    end

    # 驗證查詢 _id 的 ServiceRequest resource 是否合規
    test do
      title '[GET] ServiceRequest resource is valid'
      description %(
        Verify that the ServiceRequest resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )
      
      # This test will use the response from the :serviceRequest request in the
      # previous test
      uses_request :serviceRequest

      run do
        assert_response_status(200)
        assert_resource_type('ServiceRequest')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input ServiceRequest resource is valid'
      description %(
        Verify that the ServiceRequest resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_resource,
        title: 'ServiceRequest Resource'
      
      output :serviceRequest_value
      
      run do 
        assert_valid_json(serviceRequest_resource) # For safety
        resource_hash = JSON.parse(serviceRequest_resource)
        serviceRequest_resource = FHIR::ServiceRequest.new(resource_hash)
        # output serviceRequest_value: serviceRequest_resource
        assert_valid_resource(resource: serviceRequest_resource)
        # if resource_is_valid?(resource: serviceRequest_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction ServiceRequests(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send ServiceRequest Resource to FHIR Server'
      description %(
        Send a input Transaction ServiceRequest(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_resource,
        title: 'ServiceRequest Resource'

      run do 
        resource_hash = JSON.parse(serviceRequest_resource)
        response = fhir_create FHIR::ServiceRequest.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  