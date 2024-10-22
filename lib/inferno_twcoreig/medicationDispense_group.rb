module InfernoTWCoreIG
  class MedicationDispenseGroup < Inferno::TestGroup
    title 'MedicationDispense(配藥或藥品調劑) Tests'
    description 'Verify that the server makes MedicationDispense resources available'
    id :medicationDispense_group

    input_order :url, :medicationDispense_id, :medicationDispense_status, :medicationDispense_subject, :medicationDispense_medication, :medicationDispense_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有MedicationDispense：
    test do
      title '[GET] Server returns valid results for MedicationDispense search by _id'
      description %(
        A server SHALL support searching by _id on the MedicationDispense resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
        )

      input :medicationDispense_id,
        title: 'MedicationDispense _id'

      # Named requests can be used by other tests
      makes_request :medicationDispense

      run do
        fhir_search('MedicationDispense', params: { _id: medicationDispense_id }, name: :medicationDispense)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有MedicationDispense：
    test do
      title '[GET] Server returns valid results for MedicationDispense search by status'
      description %(
        A server SHALL support searching by status on the MedicationDispense resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
        )

      input :medicationDispense_status,
        title: 'MedicationDispense status'

      run do
        fhir_search('MedicationDispense', params: { status: medicationDispense_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有MedicationDispense：
    test do
      title '[GET] Server returns valid results for MedicationDispense search by subject'
      description %(
        A server SHALL support searching by subject on the MedicationDispense resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
        )

      input :medicationDispense_subject,
        title: 'MedicationDispense subject'

      run do
        fhir_search('MedicationDispense', params: { subject: medicationDispense_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 medication 查詢所有MedicationDispense：
    test do
      title '[GET] Server returns valid results for MedicationDispense search by medication'
      description %(
        A server SHALL support searching by medication on the MedicationDispense resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
        )

      input :medicationDispense_medication,
        title: 'MedicationDispense medication'

      run do
        fhir_search('MedicationDispense', params: { medication: medicationDispense_medication })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 MedicationDispense resource 是否合規
    test do
      title '[GET] MedicationDispense resource is valid'
      description %(
        Verify that the MedicationDispense resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
      )
      # This test will use the response from the :medicationDispense request in the
      # previous test
      uses_request :medicationDispense

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input MedicationDispense resource is valid'
      description %(
        Verify that the MedicationDispense resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
      )
      input :medicationDispense_resource,
            title: 'MedicationDispense Resource'
      
      output :medicationDispense_value
      
      run do 
        assert_valid_json(medicationDispense_resource) # For safety
        resource_hash = JSON.parse(medicationDispense_resource)
        medicationDispense_resource = FHIR::MedicationDispense.new(resource_hash)
        # output medicationDispense_value: medicationDispense_resource
        assert_valid_resource(resource: medicationDispense_resource)
        # if resource_is_valid?(resource: medicationDispense_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send MedicationDispense Resource to FHIR Server'
      description %(
        Send a input MedicationDispense resource to a FHIR server database.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
      )

      input :medicationDispense_resource,
            title: 'MedicationDispense Resource'

      run do 
        resource_hash = JSON.parse(medicationDispense_resource)
        response = fhir_create FHIR::MedicationDispense.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
