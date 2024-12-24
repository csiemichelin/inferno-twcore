module InfernoTWCoreIG
  class AllergyIntoleranceGroup < Inferno::TestGroup
    title 'AllergyIntolerance(過敏或不耐症) Tests'
    description 'Verify that the server makes AllergyIntolerance resources available'
    id :allergyIntolerance_group

    input_order :url, :allergyIntolerance_id, :allergyIntolerance_clinicalStatus, :allergyIntolerance_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有AllergyIntolerance：
    test do
      title '[GET] Server returns valid results for AllergyIntolerance search by _id'
      description %(
        A server SHALL support searching by _id on the AllergyIntolerance resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )
      
      input_order :url

      input :allergyIntolerance_id,
        title: 'AllergyIntolerance _id',
        default: 'allint-nsysu-hd-1'

      # Named requests can be used by other tests
      makes_request :allergyIntolerance

      run do
        fhir_search('AllergyIntolerance', params: { _id: allergyIntolerance_id }, name: :allergyIntolerance)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 clinical-status 查詢所有AllergyIntolerance：
    test do
      title '[GET] Server returns valid results for AllergyIntolerance search by clinical-status'
      description %(
        A server SHALL support searching by clinical-status on the AllergyIntolerance resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )

      input_order :url

      input :allergyIntolerance_clinicalStatus,
        title: 'AllergyIntolerance clinical-status',
        default: 'Active'

      run do
        fhir_search('AllergyIntolerance', params: { 'clinical-status': allergyIntolerance_clinicalStatus })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 AllergyIntolerance resource 是否合規
    test do
      title '[GET] AllergyIntolerance resource is valid'
      description %(
        Verify that the AllergyIntolerance resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )
      # This test will use the response from the :allergyIntolerance request in the
      # previous test
      uses_request :allergyIntolerance

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input AllergyIntolerance resource is valid'
      description %(
        Verify that the AllergyIntolerance resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )

      input_order :url

      input :allergyIntolerance_resource,
        title: 'AllergyIntolerance Resource',
        default: '''{
          "resourceType" : "AllergyIntolerance",
          "id" : "all-seafood-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/AllergyIntolerance-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>海鮮過敏</b></h3><p><b>臨床狀態</b>：Active <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical\">AllergyIntoleranceClinicalStatusCodes</a>#active)</span></p><p><b>驗證狀態</b>：Confirmed <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://terminology.hl7.org/CodeSystem/allergyintolerance-verification\">AllergyIntoleranceVerificationStatusCodes</a>#confirmed)</span></p><p><b>根本原因或運作機制</b>：Allergy <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/allergy-intolerance-type\">AllergyIntoleranceType</a>#allergy)</span></p><p><b>確定的物質的類別</b>：Food <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/allergy-intolerance-category\">AllergyIntoleranceCategory</a>#food)</span></p><p><b>嚴重程度</b>：High Risk <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/allergy-intolerance-criticality\">AllergyIntoleranceCriticality</a>#high)</span></p><p><b>過敏或不耐症的識別</b>：海鮮過敏(Seafood allergy) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#91937001)</span></p><p><b>過敏或不耐症被識別的時間</b>：2023-02-10T18:45:00</p><p><b>病人</b>：<a href=\"Patient-pat-example.html\">Patient/pat-example</a> \"陳加玲\"</p><p><b>紀錄者</b>：<a href=\"Practitioner-pra-dr-example.html\">Practitioner/pra-dr-example</a> \"王依昇\"</p><p><b>被記錄的日期</b>：2023-02-11T10:00:00</p><p><b>關於過敏的資訊來源</b>：<a href=\"Practitioner-pra-nurse-example.html\">Practitioner/pra-nurse-example</a> \"陳莉\"</p><p><b>最後一次已知反應發生的日期與時間</b>：2023-09-03T14:30:00</p><p><b>暴露於此過敏或不耐症物質的不良反應</b>：</p><blockquote><p><b>過敏產生的特定物質或醫藥產品</b>：海鮮(Seafood)<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\"> ( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#44027008)</span></p><p><b>與此事件相關的臨床症狀/體徵</b>：Upper respiratory tract hypersensitivity reaction <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#490008)</span></p><p><b>對整個過敏事件的描述</b>：皮膚發癢、呼吸急促</p><p><b>嚴重程度</b>：Severe <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/reaction-event-severity\">AllergyIntoleranceSeverity</a>#severe)</span></p><p><b>如何接觸到該物質</b>：口服(Oral use) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#26643006)</span></p><p><b>備註</b>：患者食用海鮮後出現皮膚發癢和呼吸急促，症狀於2023年2月11日上午10:00發作</p></blockquote></div>"
          },
          "clinicalStatus" : {
            "coding" : [{
              "system" : "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical",
              "code" : "active",
              "display" : "Active"
            }],
            "text" : "Active"
          },
          "verificationStatus" : {
            "coding" : [{
              "system" : "http://terminology.hl7.org/CodeSystem/allergyintolerance-verification",
              "code" : "confirmed",
              "display" : "Confirmed"
            }],
            "text" : "Confirmed"
          },
          "type" : "allergy",
          "category" : ["food"],
          "criticality" : "high",
          "code" : {
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "91937001",
              "display" : "Seafood allergy"
            }],
            "text" : "海鮮過敏"
          },
          "patient" : {
            "reference" : "Patient/pat-nsysu-hd-001",
            "display" : "陳加玲"
          },
          "onsetDateTime" : "2023-02-10T18:45:00Z",
          "recordedDate" : "2023-02-11T10:00:00Z",
          "recorder" : {
            "reference" : "Practitioner/1004",
            "display" : "王依昇"
          },
          "asserter" : {
            "reference" : "Practitioner/13192",
            "display" : "陳莉"
          },
          "lastOccurrence" : "2024-02-11T10:00:00Z",
          "note" : [{
            "text" : "患者對海鮮過敏，可能導致皮膚發癢、呼吸急促"
          }],
          "reaction" : [{
            "substance" : {
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "44027008",
                "display" : "Seafood"
              }],
              "text" : "海鮮"
            },
            "manifestation" : [{
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "490008",
                "display" : "Upper respiratory tract hypersensitivity reaction"
              }]
            }],
            "description" : "皮膚發癢、呼吸急促",
            "severity" : "severe",
            "exposureRoute" : {
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "26643006",
                "display" : "Oral use"
              }],
              "text" : "口服"
            },
            "note" : [{
              "text" : "患者食用海鮮後出現皮膚發癢和呼吸急促，症狀於2023年2月11日上午10:00發作"
            }]
          }]
        }'''
      
      output :allergyIntolerance_value
      
      run do 
        assert_valid_json(allergyIntolerance_resource) # For safety
        resource_hash = JSON.parse(allergyIntolerance_resource)
        allergyIntolerance_resource = FHIR::AllergyIntolerance.new(resource_hash)
        # output allergyIntolerance_value: allergyIntolerance_resource
        assert_valid_resource(resource: allergyIntolerance_resource)
        # if resource_is_valid?(resource: allergyIntolerance_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send AllergyIntolerance Resource to FHIR Server'
      description %(
        Send a input AllergyIntolerance resource to a FHIR server database.

        [臺灣核心-過敏或不耐症（TW Core AllergyIntolerance）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-AllergyIntolerance-twcore.html)
      )

      input_order :url
      
      input :allergyIntolerance_resource,
        title: 'AllergyIntolerance Resource'

      run do 
        resource_hash = JSON.parse(allergyIntolerance_resource)
        response = fhir_create FHIR::AllergyIntolerance.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
