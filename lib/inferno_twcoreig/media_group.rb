module InfernoTWCoreIG
  class MediaGroup < Inferno::TestGroup
    title 'Media(多媒體) Tests'
    description 'Verify that the server makes Media resources available'
    id :media_group

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Media：
    test do
      title '[GET] Server returns valid results for Media search by _id'
      description %(
        A server SHALL support searching by _id on the Media resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
        )

      input :media_id,
        title: 'Media _id'

      # Named requests can be used by other tests
      makes_request :media

      run do
        fhir_search('Media', params: { _id: media_id }, name: :media)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有Media：
    test do
      title '[GET] Server returns valid results for Media search by status'
      description %(
        A server SHALL support searching by status on the Media resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
        )

      input :media_status,
        title: 'Media status'

      run do
        fhir_search('Media', params: { status: media_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有Media：
    test do
      title '[GET] Server returns valid results for Media search by subject'
      description %(
        A server SHALL support searching by subject on the Media resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
        )

      input :media_subject,
        title: 'Media subject'

      run do
        fhir_search('Media', params: { subject: media_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Media resource 是否合規
    test do
      title '[GET] Media resource is valid'
      description %(
        Verify that the Media resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
      )
      # This test will use the response from the :media request in the
      # previous test
      uses_request :media

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Media resource is valid'
      description %(
        Verify that the Media resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
      )
      input :media_resource,
            title: 'Media Resource'
      
      output :media_value
      
      run do 
        assert_valid_json(media_resource) # For safety
        resource_hash = JSON.parse(media_resource)
        media_resource = FHIR::Media.new(resource_hash)
        # output media_value: media_resource
        assert_valid_resource(resource: media_resource)
        # if resource_is_valid?(resource: media_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Media Resource to FHIR Server'
      description %(
        Send a input Media resource to a FHIR server database.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
      )

      input :media_resource,
            title: 'Media Resource'

      run do 
        resource_hash = JSON.parse(media_resource)
        response = fhir_create FHIR::Media.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
