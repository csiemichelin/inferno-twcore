module InfernoTWCoreIG
  class MedicationRequestGroup < Inferno::TestGroup
    title 'MedicationRequest(藥品請求) Tests'
    description 'Verify that the server makes MedicationRequest resources available'
    id :medicationRequest_group

    input_order :url, :medicationRequest_id, :medicationRequest_status, :medicationRequest_intent, :medicationRequest_subject, :medicationRequest_medication, :medicationRequest_encounter, :medicationRequest_authoredon, :medicationRequest_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有MedicationRequest：
    test do
      title '[GET] Server returns valid results for MedicationRequest search by _id'
      description %(
        A server SHALL support searching by _id on the MedicationRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
        )

      input :medicationRequest_id,
        title: 'MedicationRequest _id'

      # Named requests can be used by other tests
      makes_request :medicationRequest

      run do
        fhir_search('MedicationRequest', params: { _id: medicationRequest_id }, name: :medicationRequest)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有MedicationRequest：
    test do
      title '[GET] Server returns valid results for MedicationRequest search by status'
      description %(
        A server SHALL support searching by status on the MedicationRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
        )

      input :medicationRequest_status,
        title: 'MedicationRequest status'

      run do
        fhir_search('MedicationRequest', params: { status: medicationRequest_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 intent 查詢所有MedicationRequest：
    test do
      title '[GET] Server returns valid results for MedicationRequest search by intent'
      description %(
        A server SHALL support searching by intent on the MedicationRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
        )

      input :medicationRequest_intent,
        title: 'MedicationRequest intent'

      run do
        fhir_search('MedicationRequest', params: { intent: medicationRequest_intent })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有MedicationRequest：
    test do
      title '[GET] Server returns valid results for MedicationRequest search by subject'
      description %(
        A server SHALL support searching by subject on the MedicationRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
        )

      input :medicationRequest_subject,
        title: 'MedicationRequest subject'

      run do
        fhir_search('MedicationRequest', params: { subject: medicationRequest_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 medication 查詢所有MedicationRequest：
    test do
      title '[GET] Server returns valid results for MedicationRequest search by medication'
      description %(
        A server SHALL support searching by medication on the MedicationRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
        )

      input :medicationRequest_medication,
        title: 'MedicationRequest medication'

      run do
        fhir_search('MedicationRequest', params: { medication: medicationRequest_medication })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 encounter 查詢所有MedicationRequest：
    test do
      title '[GET] Server returns valid results for MedicationRequest search by encounter'
      description %(
        A server SHALL support searching by encounter on the MedicationRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
        )

      input :medicationRequest_encounter,
        title: 'MedicationRequest encounter'

      run do
        fhir_search('MedicationRequest', params: { encounter: medicationRequest_encounter })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 authoredon 查詢所有MedicationRequest：
    test do
      title '[GET] Server returns valid results for MedicationRequest search by authoredon'
      description %(
        A server SHALL support searching by authoredon on the MedicationRequest resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
        )

      input :medicationRequest_authoredon,
        title: 'MedicationRequest authoredon'

      run do
        fhir_search('MedicationRequest', params: { authoredon: medicationRequest_authoredon })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 MedicationRequest resource 是否合規
    test do
      title '[GET] MedicationRequest resource is valid'
      description %(
        Verify that the MedicationRequest resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
      )
      # This test will use the response from the :medicationRequest request in the
      # previous test
      uses_request :medicationRequest

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input MedicationRequest resource is valid'
      description %(
        Verify that the MedicationRequest resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
      )
      input :medicationRequest_resource,
            title: 'MedicationRequest Resource'
      
      output :medicationRequest_value
      
      run do 
        assert_valid_json(medicationRequest_resource) # For safety
        resource_hash = JSON.parse(medicationRequest_resource)
        medicationRequest_resource = FHIR::MedicationRequest.new(resource_hash)
        # output medicationRequest_value: medicationRequest_resource
        assert_valid_resource(resource: medicationRequest_resource)
        # if resource_is_valid?(resource: medicationRequest_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send MedicationRequest Resource to FHIR Server'
      description %(
        Send a input MedicationRequest resource to a FHIR server database.

        [臺灣核心-藥品請求（TW Core MedicationRequest）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationRequest-twcore.html)
      )

      input :medicationRequest_resource,
            title: 'MedicationRequest Resource'

      run do 
        resource_hash = JSON.parse(medicationRequest_resource)
        response = fhir_create FHIR::MedicationRequest.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
