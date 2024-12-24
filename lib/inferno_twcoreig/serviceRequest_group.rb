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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_id,
        title: 'ServiceRequest _id',
        default: '15931'

      # Named requests can be used by other tests
      makes_request :serviceRequest

      run do
        fhir_search('ServiceRequest', params: { '_id': serviceRequest_id }, name: :serviceRequest)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 必須（SHALL） 支援透過查詢參數 patient 查詢所有ServiceRequest：
    test do
      title '[GET] Server returns valid results for ServiceRequest search by patient'
      description %(
        A server SHALL support searching by patient on the ServiceRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_patient,
        title: 'ServiceRequest patient',
        default: 'Patient/pat-nsysu-hd-001'

      # Named requests can be used by other tests
      makes_request :serviceRequest

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient }, name: :serviceRequest)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 必須（SHALL） 支援透過查詢參數 patient 及 category 查詢所有ServiceRequest：
    test do
      title '[GET] Server returns valid results for ServiceRequest search by patient and category'
      description %(
        A server SHALL support searching by patient and category on the ServiceRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_patient,
        title: 'ServiceRequest patient',
        default: 'Patient/pat-nsysu-hd-001'

      input :serviceRequest_category,
        title: 'ServiceRequest category',
        default: '387713003'

      # Named requests can be used by other tests
      makes_request :serviceRequest

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient, 'category': serviceRequest_category }, name: :serviceRequest)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 必須（SHALL） 支援透過查詢參數 patient 、 category 及 authored 查詢所有ServiceRequest：
    test do
      title '[GET] Server returns valid results for ServiceRequest search by patient, category and authored'
      description %(
        A server SHALL support searching by patient, category and authored on the ServiceRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-服務請求（TW Core ServiceRequest）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-ServiceRequest-twcore.html)
      )

      input_order :url

      input :serviceRequest_patient,
        title: 'ServiceRequest patient',
        default: 'Patient/pat-nsysu-hd-001'

      input :serviceRequest_category,
        title: 'ServiceRequest category',
        default: '387713003'

      input :serviceRequest_authored,
        title: 'ServiceRequest authored',
        default: 'ge2021'

      # Named requests can be used by other tests
      makes_request :serviceRequest

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient, 'category': serviceRequest_category, 'authored': serviceRequest_authored }, name: :serviceRequest)

        assert_response_status(200)
        assert_resource_type('Bundle')
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
        title: 'ServiceRequest patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :serviceRequest_status,
        title: 'ServiceRequest status',
        default: 'active'

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient, 'status': serviceRequest_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
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
        title: 'ServiceRequest patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :serviceRequest_code,
        title: 'ServiceRequest code',
        default: '104001'
      
      input :serviceRequest_authored,
        title: 'ServiceRequest authored',
        default: 'ge2021'

      run do
        fhir_search('ServiceRequest', params: { 'patient': serviceRequest_patient, 'code': serviceRequest_code, 'authored': serviceRequest_authored })

        assert_response_status(200)
        assert_resource_type('Bundle')
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
        assert_resource_type('Bundle')
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
        title: 'ServiceRequest Resource',
        default: '''{
          "resourceType" : "ServiceRequest",
          "id" : "sr-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/ServiceRequest-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p class=\"res-header-id\"><b>Generated Narrative: ServiceRequest sr-example</b></p><a name=\"sr-example\"> </a><a name=\"hcsr-example\"> </a><a name=\"sr-example-en-US\"> </a><p><b>status</b>: Active</p><p><b>intent</b>: Order</p><p><b>category</b>: <span title=\"Codes:{http://snomed.info/sct 387713003}\">Surgical procedure (procedure)</span></p><p><b>code</b>: <span title=\"Codes:{http://snomed.info/sct 104001}\">Excision of lesion of patella (procedure)</span></p><p><b>subject</b>: <a href=\"Patient-pat-example.html\">陳加玲(official) Female, DoB: 1990-01-01 ( Medical record number\u00a0(use:\u00a0official,\u00a0))</a></p><p><b>occurrence</b>: 2021-11-20</p><p><b>authoredOn</b>: 2021-11-12 10:59:38-0800</p><p><b>requester</b>: <a href=\"Practitioner-pra-dr-example.html\">Practitioner 王依昇(official)</a></p></div>"
          },
          "status" : "active",
          "intent" : "order",
          "category" : [{
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "387713003",
              "display" : "Surgical procedure (procedure)"
            }]
          }],
          "code" : {
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "104001",
              "display" : "Excision of lesion of patella (procedure)"
            }]
          },
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          },
          "occurrenceDateTime" : "2021-11-20",
          "authoredOn" : "2021-11-12T10:59:38-08:00",
          "requester" : {
            "reference" : "Practitioner/1004"
          }
        }'''
      
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
  