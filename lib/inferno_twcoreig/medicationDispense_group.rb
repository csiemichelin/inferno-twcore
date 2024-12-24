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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
      )

      input_order :url

      input :medicationDispense_id,
        title: 'MedicationDispense _id',
        default: '14021'

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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
      )

      input_order :url

      input :medicationDispense_status,
        title: 'MedicationDispense status',
        default: 'preparation'

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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
      )

      input_order :url

      input :medicationDispense_subject,
        title: 'MedicationDispense subject',
        default: 'Patient/13674'

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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-配藥或藥品調劑（TW Core MedicationDispense）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MedicationDispense-twcore.html)
      )

      input_order :url

      input :medicationDispense_medication,
        title: 'MedicationDispense medication',
        default: 'Medication/14017'

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

      input_order :url

      input :medicationDispense_resource,
        title: 'MedicationDispense Resource',
        default: '''{
          "resourceType" : "MedicationDispense",
          "id" : "med-dis-ref-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/MedicationDispense-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>阿立批挫藥品配藥資料</b></h3><p><b>配藥的狀態</b>：Completed <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/R4/valueset-medicationdispense-status.html\">MedicationDispense Status Codes</a>#completed)</span></p><p><b>配藥的分類</b>： Inpatient <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/R4/valueset-medicationdispense-category.html\">MedicationDispense Category Codes</a>#inpatient)</span></p><p><b>配藥的類型</b>：Daily Fill <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/implement/standards/fhir/R4/v3/ActPharmacySupplyType/vs.html\">V3 Value SetActPharmacySupplyType</a>#DF)</span></p><p><b>藥品</b>：<a href=\"Medication-med-example.html\">Medication/med-example</a></p><p><b>病人</b>：<a href=\"Patient-pat-example.html\">Patient/pat-example</a> \"陳加玲\"</p><p><b>就醫資料</b>：<a href=\"Encounter-enc-example.html\">Encounter/enc-example</a></p><p><b>配藥者</b>：<a href=\"Practitioner-pra-phc-example.html\">Practitioner/pra-phc-example</a> \"陳耀詩\"</p><blockquote><p><b>配藥資料</b>：</p><p><b>藥品總劑量</b>：30 Tablet <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm\">OrderableDrugForm</a>#TAB)</span><br/><b>藥品天數</b>：30 days<br/><b>藥品使用方法</b>：每天早上口服一次<br/><b>藥品包裝和審核時間</b>：2022-08-01T07:00:14<br/><b>藥品發放的時間</b>：2022-08-01T08:15:14</p></blockquote><blockquote><p><b>藥品替代資料</b>：</p><p><b>配藥時是否進行了藥品替代</b>： 否<br/><b>配藥是否與處方要求不同</b>：none <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://terminology.hl7.org/CodeSystem/v3-substanceAdminSubstitution\">SubstanceAdminSubstitution</a>#N)</span><br/><b>替代原因</b>：formulary policy <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://terminology.hl7.org/CodeSystem/v3-ActReason\">ActReason</a>#FP)</span></p></blockquote></div>"
          },
          "status" : "completed",
          "category" : {
            "coding" : [{
              "system" : "http://terminology.hl7.org/fhir/CodeSystem/medicationdispense-category",
              "code" : "inpatient"
            }]
          },
          "medicationReference" : {
            "reference" : "Medication/14017"
          },
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          },
          "context" : {
            "reference" : "Encounter/13427"
          },
          "performer" : [{
            "actor" : {
              "reference" : "Practitioner/1004"
            }
          }],
          "type" : {
            "coding" : [{
              "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
              "code" : "DF",
              "display" : "Daily Fill"
            }]
          },
          "quantity" : {
            "value" : 30,
            "unit" : "TAB",
            "system" : "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
            "code" : "TAB"
          },
          "daysSupply" : {
            "value" : 30,
            "unit" : "days"
          },
          "whenPrepared" : "2022-08-01T07:00:14+08:00",
          "whenHandedOver" : "2022-08-01T08:15:14+08:00",
          "dosageInstruction" : [{
            "text" : "每天早上口服一次",
            "timing" : {
              "repeat" : {
                "frequency" : 1,
                "period" : 1,
                "periodUnit" : "d"
              }
            }
          }],
          "substitution" : {
            "wasSubstituted" : false,
            "type" : {
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/v3-substanceAdminSubstitution",
                "code" : "N",
                "display" : "none"
              }]
            },
            "reason" : [{
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
                "code" : "FP",
                "display" : "formulary policy"
              }]
            }]
          }
        }'''
      
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

      input_order :url

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
