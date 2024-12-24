module InfernoTWCoreIG
  class MedicationStatementGroup < Inferno::TestGroup
    title 'MedicationStatement(用藥聲明) Tests'
    description 'Verify that the server makes MedicationStatement resources available'
    id :medicationStatement_group

    input_order :url, :medicationStatement_id, :medicationStatement_status, :medicationStatement_medication, :medicationStatement_subject, :medicationStatement_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有MedicationStatement：
    test do
      title '[GET] Server returns valid results for MedicationStatement search by _id'
      description %(
        A server SHALL support searching by _id on the MedicationStatement resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
      )

      input_order :url

      input :medicationStatement_id,
        title: 'MedicationStatement _id',
        default: '14616'

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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
      )

      input_order :url

      input :medicationStatement_status,
        title: 'MedicationStatement status',
        default: 'active'

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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
      )

      input_order :url

      input :medicationStatement_medication,
        title: 'MedicationStatement medication',
        default: 'Medication/13506'

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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-用藥聲明（TW Core MedicationStatement）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationStatement-twcore.html)
      )

      input_order :url

      input :medicationStatement_subject,
        title: 'MedicationStatement subject',
        default: 'Patient/13384'

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

      input_order :url

      input :medicationStatement_resource,
        title: 'MedicationStatement Resource',
        default: '''{
          "resourceType": "MedicationStatement",
          "id": "14616",
          "meta": {
              "versionId": "1",
              "lastUpdated": "2024-08-29T02:44:44.774+00:00",
              "source": "#YKB8hJb5eI79D37g",
              "profile": [
                  "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/MedicationStatement-twcore"
              ]
          },
          "identifier": [
              {
                  "use": "official",
                  "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
                  "value": "EN"
              }
          ],
          "status": "active",
          "category": {
              "coding": [
                  {
                      "system": "http://terminology.hl7.org/CodeSystem/medication-statement-category",
                      "code": "inpatient",
                      "display": "Inpatient"
                  }
              ],
              "text": "123"
          },
          "medicationReference": {
              "reference": "Medication/13506"
          },
          "subject": {
              "reference": "Patient/13384"
          },
          "context": {
              "reference": "Encounter/13388"
          },
          "effectiveDateTime": "2024-01-01",
          "dosage": [
              {
                  "sequence": 3,
                  "text": "SIG",
                  "patientInstruction": "不用吃",
                  "timing": {
                      "repeat": {
                          "count": 5,
                          "duration": 10,
                          "durationUnit": "d",
                          "frequency": 5,
                          "period": 3,
                          "periodUnit": "d",
                          "dayOfWeek": [
                              "mon",
                              "tue",
                              "wed",
                              "thu",
                              "fri"
                          ],
                          "timeOfDay": [
                              "12:00:00"
                          ]
                      },
                      "code": {
                          "coding": [
                              {
                                  "system": "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/medication-frequency-nhi-tw",
                                  "code": "AC",
                                  "display": "飯前"
                              }
                          ],
                          "text": "123"
                      }
                  },
                  "route": {
                      "coding": [
                          {
                              "system": "http://snomed.info/sct",
                              "code": "78421000",
                              "display": "Intramuscular route"
                          }
                      ],
                      "text": "123"
                  },
                  "doseAndRate": [
                      {
                          "doseRange": {
                              "low": {
                                  "value": 5
                              }
                          },
                          "rateRange": {
                              "low": {
                                  "value": 5
                              }
                          }
                      }
                  ]
              }
          ]
      }'''
      
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

      input_order :url

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
