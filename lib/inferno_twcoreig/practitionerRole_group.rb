module InfernoTWCoreIG
  class PractitionerRoleGroup < Inferno::TestGroup
    title 'PractitionerRole(健康照護服務提供者角色) Tests'
    description 'Verify that the server makes PractitionerRole resources available'
    id :practitionerRole_group

    input_order :url, :practitionerRole_id, :practitionerRole_identifier, :practitionerRole_specialty, :practitionerRole_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有PractitionerRole：
    test do
      title '[GET] Server returns valid results for PractitionerRole search by _id'
      description %(
        A server SHALL support searching by _id on the PractitionerRole resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url

      input :practitionerRole_id,
        title: 'PractitionerRole _id'

      # Named requests can be used by other tests
      makes_request :practitionerRole

      run do
        fhir_search('PractitionerRole', params: { _id: practitionerRole_id }, name: :practitionerRole)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有PractitionerRole：
    test do
      title '[GET] Server returns valid results for PractitionerRole search by identifier'
      description %(
        A server SHALL support searching by identifier on the PractitionerRole resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url

      input :practitionerRole_identifier,
        title: 'PractitionerRole identifier'

      run do
        fhir_search('PractitionerRole', params: { identifier: practitionerRole_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 specialty 查詢所有PractitionerRole：
    test do
      title '[GET] Server returns valid results for PractitionerRole search by specialty'
      description %(
        A server SHALL support searching by specialty on the PractitionerRole resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url

      input :practitionerRole_specialty,
        title: 'PractitionerRole specialty'

      run do
        fhir_search('PractitionerRole', params: { specialty: practitionerRole_specialty })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 PractitionerRole resource 是否合規
    test do
      title '[GET] PractitionerRole resource is valid'
      description %(
        Verify that the PractitionerRole resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )
      # This test will use the response from the :practitionerRole request in the
      # previous test
      uses_request :practitionerRole

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input PractitionerRole resource is valid'
      description %(
        Verify that the PractitionerRole resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url

      input :practitionerRole_resource,
            title: 'PractitionerRole Resource'
      
      output :practitionerRole_value
      
      run do 
        assert_valid_json(practitionerRole_resource) # For safety
        resource_hash = JSON.parse(practitionerRole_resource)
        practitionerRole_resource = FHIR::PractitionerRole.new(resource_hash)
        # output practitionerRole_value: practitionerRole_resource
        assert_valid_resource(resource: practitionerRole_resource)
        # if resource_is_valid?(resource: practitionerRole_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send PractitionerRole Resource to FHIR Server'
      description %(
        Send a input PractitionerRole resource to a FHIR server database.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url
      
      input :practitionerRole_resource,
            title: 'PractitionerRole Resource'

      run do 
        resource_hash = JSON.parse(practitionerRole_resource)
        response = fhir_create FHIR::PractitionerRole.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
