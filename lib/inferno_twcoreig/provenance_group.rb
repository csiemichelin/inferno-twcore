module InfernoTWCoreIG
  class ProvenanceGroup < Inferno::TestGroup
    title 'Provenance(出處) Tests'
    description 'Verify that the server makes Provenance resources available'
    id :provenance_group

    input_order :url, :provenance_patient, :provenance_revinclude, :provenance_id, :provenance_resource

    # 必須（SHALL） 支援透過查詢參數 patient 及 _revinclude 查詢所有Provenance：
    test do
      title '[GET] Server returns valid results for Provenance search by patient and _revinclude'
      description %(
        A server SHALL support searching by patient and _revinclude on the Provenance resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-出處（TW Core Provenance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Provenance-twcore.html)
      )

      input_order :url

      input :provenance_patient,
        title: 'Provenance patient'
      
      input :provenance_revinclude,
        title: 'Provenance _revinclude'

      # Named requests can be used by other tests
      makes_request :provenance

      run do
        fhir_search('Provenance', params: { 'patient': provenance_patient, '_revinclude': provenance_revinclude }, name: :provenance)

        assert_response_status(200)
        assert_resource_type('Provenance')
      end
    end

    # 必須（SHALL） 支援透過查詢參數 _id 及 _revinclude 查詢所有Provenance：
    test do
      title '[GET] Server returns valid results for Provenance search by _id and _revinclude'
      description %(
        A server SHALL support searching by _id and _revinclude on the Provenance resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-出處（TW Core Provenance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Provenance-twcore.html)
      )

      input_order :url

      input :provenance_id,
        title: 'Provenance _id'
      
      input :provenance_revinclude,
        title: 'Provenance _revinclude'

      run do
        fhir_search('Provenance', params: { '_id': provenance_id, '_revinclude': provenance_revinclude })

        assert_response_status(200)
        assert_resource_type('Provenance')
      end
    end

    # 驗證查詢 patient 及 _revinclude 的 Provenance resource 是否合規
    test do
      title '[GET] Provenance resource is valid'
      description %(
        Verify that the Provenance resource search by patient and _revinclude returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-出處（TW Core Provenance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Provenance-twcore.html)
      )
      
      # This test will use the response from the :provenance request in the
      # previous test
      uses_request :provenance

      run do
        assert_response_status(200)
        assert_resource_type('Provenance')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Provenance resource is valid'
      description %(
        Verify that the Provenance resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-出處（TW Core Provenance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Provenance-twcore.html)
      )

      input_order :url

      input :provenance_resource,
        title: 'Provenance Resource'
      
      output :provenance_value
      
      run do 
        assert_valid_json(provenance_resource) # For safety
        resource_hash = JSON.parse(provenance_resource)
        provenance_resource = FHIR::Provenance.new(resource_hash)
        # output provenance_value: provenance_resource
        assert_valid_resource(resource: provenance_resource)
        # if resource_is_valid?(resource: provenance_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction Provenances(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send Provenance Resource to FHIR Server'
      description %(
        Send a input Transaction Provenance(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-出處（TW Core Provenance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Provenance-twcore.html)
      )

      input_order :url

      input :provenance_resource,
        title: 'Provenance Resource'

      run do 
        resource_hash = JSON.parse(provenance_resource)
        response = fhir_create FHIR::Provenance.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  