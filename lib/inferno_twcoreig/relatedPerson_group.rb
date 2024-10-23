module InfernoTWCoreIG
  class RelatedPersonGroup < Inferno::TestGroup
    title 'RelatedPerson(相關人士) Tests'
    description 'Verify that the server makes RelatedPerson resources available'
    id :relatedPerson_group

    input_order :url, :relatedPerson_id, :relatedPerson_patient, :relatedPerson_name, :relatedPerson_resource

    # 必須（SHALL） 支援透過查詢參數 _id 查詢所有RelatedPerson：
    test do
      title '[GET] Server returns valid results for RelatedPerson search by _id'
      description %(
        A server SHALL support searching by _id on the RelatedPerson resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_id,
        title: 'RelatedPerson _id'

      # Named requests can be used by other tests
      makes_request :relatedPerson

      run do
        fhir_search('RelatedPerson', params: { '_id': relatedPerson_id }, name: :relatedPerson)

        assert_response_status(200)
        assert_resource_type('RelatedPerson')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 查詢所有RelatedPerson：
    test do
      title '[GET] Server returns valid results for RelatedPerson search by patient'
      description %(
        A server SHALL support searching by patient on the RelatedPerson resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_patient,
        title: 'RelatedPerson patient'

      # Named requests can be used by other tests
      makes_request :relatedPerson

      run do
        fhir_search('RelatedPerson', params: { 'patient': relatedPerson_patient }, name: :relatedPerson)

        assert_response_status(200)
        assert_resource_type('RelatedPerson')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 name 查詢所有RelatedPerson：
    test do
      title '[GET] Server returns valid results for RelatedPerson search by patient and name'
      description %(
        A server SHALL support searching by patient and name on the RelatedPerson resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_patient,
        title: 'RelatedPerson patient'
      
      input :relatedPerson_name,
        title: 'RelatedPerson name'

      run do
        fhir_search('RelatedPerson', params: { 'patient': relatedPerson_patient, 'name': relatedPerson_name })

        assert_response_status(200)
        assert_resource_type('RelatedPerson')
      end
    end

    # 驗證查詢 _id 的 RelatedPerson resource 是否合規
    test do
      title '[GET] RelatedPerson resource is valid'
      description %(
        Verify that the RelatedPerson resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )
      
      # This test will use the response from the :relatedPerson request in the
      # previous test
      uses_request :relatedPerson

      run do
        assert_response_status(200)
        assert_resource_type('RelatedPerson')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input RelatedPerson resource is valid'
      description %(
        Verify that the RelatedPerson resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_resource,
        title: 'RelatedPerson Resource'
      
      output :relatedPerson_value
      
      run do 
        assert_valid_json(relatedPerson_resource) # For safety
        resource_hash = JSON.parse(relatedPerson_resource)
        relatedPerson_resource = FHIR::RelatedPerson.new(resource_hash)
        # output relatedPerson_value: relatedPerson_resource
        assert_valid_resource(resource: relatedPerson_resource)
        # if resource_is_valid?(resource: relatedPerson_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction RelatedPersons(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send RelatedPerson Resource to FHIR Server'
      description %(
        Send a input Transaction RelatedPerson(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_resource,
        title: 'RelatedPerson Resource'

      run do 
        resource_hash = JSON.parse(relatedPerson_resource)
        response = fhir_create FHIR::RelatedPerson.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  