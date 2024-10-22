module InfernoTWCoreIG
  class OrganizationGroup < Inferno::TestGroup
    title 'Organization(機構-政府機構&醫事機構&公司行號) Tests'
    description 'Verify that the server makes Organization resources available'
    id :organization_group

    input_order :url, :organization_id, :organization_identifier, :organization_name, :organization_type, :organization_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Organization：
    test do
      title '[GET] Server returns valid results for Organization search by _id'
      description %(
        A server SHALL support searching by _id on the Organization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-機構-政府機構&醫事機構&公司行號（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Organization-twcore.html)
      )

      input_order :url

      input :organization_id,
        title: 'Organization _id'

      # Named requests can be used by other tests
      makes_request :organization

      run do
        fhir_search('Organization', params: { _id: organization_id }, name: :organization)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有Organization：
    test do
      title '[GET] Server returns valid results for Organization search by identifier'
      description %(
        A server SHALL support searching by identifier on the Organization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-機構-政府機構&醫事機構&公司行號（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Organization-twcore.html)
      )

      input_order :url

      input :organization_identifier,
        title: 'Organization identifier'

      run do
        fhir_search('Organization', params: { identifier: organization_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 name 查詢所有Organization：
    test do
      title '[GET] Server returns valid results for Organization search by name'
      description %(
        A server SHALL support searching by name on the Organization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-機構-政府機構&醫事機構&公司行號（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Organization-twcore.html)
      )

      input_order :url

      input :organization_name,
        title: 'Organization name'

      run do
        fhir_search('Organization', params: { name: organization_name })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 type 查詢所有Organization：
    test do
      title '[GET] Server returns valid results for Organization search by type'
      description %(
        A server SHALL support searching by type on the Organization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-機構-政府機構&醫事機構&公司行號（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Organization-twcore.html)
      )

      input_order :url

      input :organization_type,
        title: 'Organization type'

      run do
        fhir_search('Organization', params: { type: organization_type })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Organization resource 是否合規
    test do
      title '[GET] Organization resource is valid'
      description %(
        Verify that the Organization resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-機構-政府機構&醫事機構&公司行號（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Organization-twcore.html)
      )
      # This test will use the response from the :organization request in the
      # previous test
      uses_request :organization

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Organization resource is valid'
      description %(
        Verify that the Organization resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-機構-政府機構&醫事機構&公司行號（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Organization-twcore.html)
      )

      input_order :url

      input :organization_resource,
            title: 'Organization Resource'
      
      output :organization_value
      
      run do 
        assert_valid_json(organization_resource) # For safety
        resource_hash = JSON.parse(organization_resource)
        organization_resource = FHIR::Organization.new(resource_hash)
        # output organization_value: organization_resource
        assert_valid_resource(resource: organization_resource)
        # if resource_is_valid?(resource: organization_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Organization Resource to FHIR Server'
      description %(
        Send a input Organization resource to a FHIR server database.

        [臺灣核心-機構-政府機構&醫事機構&公司行號（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Organization-twcore.html)
      )

      input_order :url

      input :organization_resource,
            title: 'Organization Resource'

      run do 
        resource_hash = JSON.parse(organization_resource)
        response = fhir_create FHIR::Organization.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
