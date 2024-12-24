module InfernoTWCoreIG
  class CompositionGroup < Inferno::TestGroup
    title 'Composition(臨床文件架構) Tests'
    description 'Verify that the server makes Composition resources available'
    id :composition_group

    input_order :url, :composition_id, :composition_status, :composition_type, :composition_subject, :composition_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Composition：
    test do
      title '[GET] Server returns valid results for Composition search by _id'
      description %(
        A server SHALL support searching by _id on the Composition resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-臨床文件架構（TW Core Composition）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Composition-twcore.html)
      )

      input_order :url

      input :composition_id,
        title: 'Composition _id',
        default: '14182'

      # Named requests can be used by other tests
      makes_request :composition

      run do
        fhir_search('Composition', params: { _id: composition_id }, name: :composition)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有Composition：
    test do
      title '[GET] Server returns valid results for Composition search by status'
      description %(
        A server SHALL support searching by status on the Composition resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-臨床文件架構（TW Core Composition）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Composition-twcore.html)
      )

      input_order :url

      input :composition_status,
        title: 'Composition status',
        default: 'final'

      run do
        fhir_search('Composition', params: { status: composition_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 type 查詢所有Composition：
    test do
      title '[GET] Server returns valid results for Composition search by type'
      description %(
        A server SHALL support searching by type on the Composition resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-臨床文件架構（TW Core Composition）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Composition-twcore.html)
      )

      input_order :url

      input :composition_type,
        title: 'Composition type',
        default: '11503-0'

      run do
        fhir_search('Composition', params: { type: composition_type })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有Condition：
    test do
      title '[GET] Server returns valid results for Composition search by subject'
      description %(
        A server SHALL support searching by subject on the Composition resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-臨床文件架構（TW Core Composition）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Composition-twcore.html)
      )

      input_order :url

      input :composition_subject,
        title: 'Composition subject',
        default: 'Patient/14157'

      run do
        fhir_search('Composition', params: { subject: composition_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Composition resource 是否合規
    test do
      title '[GET] Composition resource is valid'
      description %(
        Verify that the Composition resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-臨床文件架構（TW Core Composition）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Composition-twcore.html)
      )
      # This test will use the response from the :composition request in the
      # previous test
      uses_request :composition

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Composition resource is valid'
      description %(
        Verify that the Composition resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-臨床文件架構（TW Core Composition）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Composition-twcore.html)
      )

      input_order :url

      input :composition_resource,
        title: 'Composition Resource',
        default: '''{
          "resourceType": "Composition",
          "id": "14182",
          "meta": {
            "versionId": "1",
            "lastUpdated": "2024-08-22T08:54:02.707+00:00",
            "source": "#kbEXXai8vMJ7pGoY",
            "profile": [ "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Composition-twcore" ]
          },
          "status": "final",
          "type": {
            "coding": [ {
              "system": "http://loinc.org",
              "code": "11503-0",
              "display": "Medical records"
            } ]
          },
          "category": [ {
            "coding": [ {
              "system": "http://loinc.org",
              "code": "47039-3"
            } ]
          } ],
          "subject": {
            "reference": "Patient/14157"
          },
          "date": "2024-08-22T09:00:00Z",
          "author": [ {
            "reference": "Practitioner/14159"
          } ],
          "title": "王先森的診療診斷結果",
          "confidentiality": "R",
          "custodian": {
            "reference": "Organization/14153"
          },
          "section": [ {
            "entry": [ {
              "reference": "Condition/14176"
            }, {
              "reference": "Procedure/14179"
            }, {
              "reference": "MedicationRequest/14181"
            } ]
          } ]
        }'''
      
      output :composition_value
      
      run do 
        assert_valid_json(composition_resource) # For safety
        resource_hash = JSON.parse(composition_resource)
        composition_resource = FHIR::Composition.new(resource_hash)
        # output composition_value: composition_resource
        assert_valid_resource(resource: composition_resource)
        # if resource_is_valid?(resource: composition_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Composition Resource to FHIR Server'
      description %(
        Send a input Composition resource to a FHIR server database.

        [臺灣核心-臨床文件架構（TW Core Composition）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Composition-twcore.html)
      )

      input_order :url
      
      input :composition_resource,
        title: 'Composition Resource'

      run do 
        resource_hash = JSON.parse(composition_resource)
        response = fhir_create FHIR::Composition.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
