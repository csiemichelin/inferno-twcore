module InfernoTWCoreIG
  class ImagingStudyGroup < Inferno::TestGroup
    title 'ImagingStudy(影像檢查) Tests'
    description 'Verify that the server makes ImagingStudy resources available'
    id :imagingStudy_group

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by _id'
      description %(
        A server SHALL support searching by _id on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
        )

      input :imagingStudy_id,
        title: 'ImagingStudy _id'

      # Named requests can be used by other tests
      makes_request :imagingStudy

      run do
        fhir_search('ImagingStudy', params: { _id: imagingStudy_id }, name: :imagingStudy)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by status'
      description %(
        A server SHALL support searching by status on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
        )

      input :imagingStudy_status,
        title: 'ImagingStudy status'

      run do
        fhir_search('ImagingStudy', params: { 'status': imagingStudy_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by subject'
      description %(
        A server SHALL support searching by subject on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
        )

      input :imagingStudy_subject,
        title: 'ImagingStudy subject'

      run do
        fhir_search('ImagingStudy', params: { subject: imagingStudy_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 encounter 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by encounter'
      description %(
        A server SHALL support searching by encounter on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
        )

      input :imagingStudy_encounter,
        title: 'ImagingStudy encounter'

      run do
        fhir_search('ImagingStudy', params: { 'encounter': imagingStudy_encounter })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 started 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by started'
      description %(
        A server SHALL support searching by started on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
        )

      input :imagingStudy_started,
        title: 'ImagingStudy started'

      run do
        fhir_search('ImagingStudy', params: { 'started': imagingStudy_started })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 ImagingStudy resource 是否合規
    test do
      title '[GET] ImagingStudy resource is valid'
      description %(
        Verify that the ImagingStudy resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )
      # This test will use the response from the :imagingStudy request in the
      # previous test
      uses_request :imagingStudy

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input ImagingStudy resource is valid'
      description %(
        Verify that the ImagingStudy resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )
      input :imagingStudy_resource,
            title: 'ImagingStudy Resource'
      
      output :imagingStudy_value
      
      run do 
        assert_valid_json(imagingStudy_resource) # For safety
        resource_hash = JSON.parse(imagingStudy_resource)
        imagingStudy_resource = FHIR::ImagingStudy.new(resource_hash)
        # output imagingStudy_value: imagingStudy_resource
        assert_valid_resource(resource: imagingStudy_resource)
        # if resource_is_valid?(resource: imagingStudy_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send ImagingStudy Resource to FHIR Server'
      description %(
        Send a input ImagingStudy resource to a FHIR server database.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )

      input :imagingStudy_resource,
            title: 'ImagingStudy Resource'

      run do 
        resource_hash = JSON.parse(imagingStudy_resource)
        response = fhir_create FHIR::ImagingStudy.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
