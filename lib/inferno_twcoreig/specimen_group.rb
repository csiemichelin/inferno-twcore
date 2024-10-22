module InfernoTWCoreIG
  class SpecimenGroup < Inferno::TestGroup
    title 'Specimen(檢體) Tests'
    description 'Verify that the server makes Specimen resources available'
    id :specimen_group

    input_order :url, :specimen_id, :specimen_status, :specimen_identifier, :specimen_subject, :specimen_resource 

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Specimen：
    test do
      title '[GET] Server returns valid results for Specimen search by _id'
      description %(
        A server SHALL support searching by _id on the Specimen resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_id,
        title: 'Specimen _id'

      # Named requests can be used by other tests
      makes_request :specimen

      run do
        fhir_search('Specimen', params: { _id: specimen_id }, name: :specimen)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有Specimen：
    test do
      title '[GET] Server returns valid results for Specimen search by status'
      description %(
        A server SHALL support searching by status on the Specimen resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_status,
        title: 'Specimen status'

      run do
        fhir_search('Specimen', params: { status: specimen_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有Specimen：
    test do
      title '[GET] Server returns valid results for Specimen search by identifier'
      description %(
        A server SHALL support searching by identifier on the Specimen resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_identifier,
        title: 'Specimen identifier'

      run do
        fhir_search('Specimen', params: { identifier: specimen_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有Specimen：
    test do
      title '[GET] Server returns valid results for Specimen search by subject'
      description %(
        A server SHALL support searching by subject on the Specimen resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_subject,
        title: 'Specimen subject'

      run do
        fhir_search('Specimen', params: { subject: specimen_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Specimen resource 是否合規
    test do
      title '[GET] Specimen resource is valid'
      description %(
        Verify that the Specimen resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )
      # This test will use the response from the :specimen request in the
      # previous test
      uses_request :specimen

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Specimen resource is valid'
      description %(
        Verify that the Specimen resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_resource,
            title: 'Specimen Resource'
      
      output :specimen_value
      
      run do 
        assert_valid_json(specimen_resource) # For safety
        resource_hash = JSON.parse(specimen_resource)
        specimen_resource = FHIR::Specimen.new(resource_hash)
        # output specimen_value: specimen_resource
        assert_valid_resource(resource: specimen_resource)
        # if resource_is_valid?(resource: specimen_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Specimen Resource to FHIR Server'
      description %(
        Send a input Specimen resource to a FHIR server database.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_resource,
            title: 'Specimen Resource'

      run do 
        resource_hash = JSON.parse(specimen_resource)
        response = fhir_create FHIR::Specimen.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
