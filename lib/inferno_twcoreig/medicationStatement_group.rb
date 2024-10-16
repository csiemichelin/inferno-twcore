module InfernoTWCoreIG
  class MedicationStatementGroup < Inferno::TestGroup
    title 'MedicationStatement(用藥聲明) Tests'
    description 'Verify that the server makes MedicationStatement resources available'
    id :medicationStatement_group

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有MedicationStatement：
    test do
      title '[GET] Server returns valid results for MedicationStatement search by _id'
      description %(
        A server SHALL support searching by _id on the MedicationStatement resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
        )

      input :medicationStatement_id,
        title: 'MedicationStatement _id'

      # Named requests can be used by other tests
      makes_request :medicationStatement

      run do
        fhir_search('MedicationStatement', params: { _id: medicationStatement_id }, name: :medicationStatement)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有MedicationStatement：
    test do
      title '[GET] Server returns valid results for MedicationStatement search by status'
      description %(
        A server SHALL support searching by status on the MedicationStatement resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
        )

      input :medicationStatement_status,
        title: 'MedicationStatement status'

      run do
        fhir_search('MedicationStatement', params: { status: medicationStatement_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 medication 查詢所有MedicationStatement：
    test do
      title '[GET] Server returns valid results for MedicationStatement search by medication'
      description %(
        A server SHALL support searching by medication on the MedicationStatement resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
        )

      input :medicationStatement_medication,
        title: 'MedicationStatement medication'

      run do
        fhir_search('MedicationStatement', params: { medication: medicationStatement_medication })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有MedicationStatement：
    test do
      title '[GET] Server returns valid results for MedicationStatement search by subject'
      description %(
        A server SHALL support searching by subject on the MedicationStatement resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.2.2.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
        )

      input :medicationStatement_subject,
        title: 'MedicationStatement subject'

      run do
        fhir_search('MedicationStatement', params: { subject: medicationStatement_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 MedicationStatement resource 是否合規
    test do
      title '[GET] MedicationStatement resource is valid'
      description %(
        Verify that the MedicationStatement resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
      )
      # This test will use the response from the :medicationStatement request in the
      # previous test
      uses_request :medicationStatement

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input MedicationStatement resource is valid'
      description %(
        Verify that the MedicationStatement resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
      )
      input :medicationStatement_resource,
            title: 'MedicationStatement Resource'
      
      output :medicationStatement_value
      
      run do 
        assert_valid_json(medicationStatement_resource) # For safety
        resource_hash = JSON.parse(medicationStatement_resource)
        medicationStatement_resource = FHIR::MedicationStatement.new(resource_hash)
        # output medicationStatement_value: medicationStatement_resource
        assert_valid_resource(resource: medicationStatement_resource)
        # if resource_is_valid?(resource: medicationStatement_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send MedicationStatement Resource to FHIR Server'
      description %(
        Send a input MedicationStatement resource to a FHIR server database.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
      )

      input :medicationStatement_resource,
            title: 'MedicationStatement Resource'

      run do 
        resource_hash = JSON.parse(medicationStatement_resource)
        response = fhir_create FHIR::MedicationStatement.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
