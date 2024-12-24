module InfernoTWCoreIG
  class EncounterGroup < Inferno::TestGroup
    title 'Encounter(就醫事件) Tests'
    description 'Verify that the server makes Encounter resources available'
    id :encounter_group

    input_order :url, :encounter_id, :encounter_class, :encounter_date, :encounter_identifier, :encounter_location, :encounter_subject, :encounter_status, :encounter_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Encounter：
    test do
      title '[GET] Server returns valid results for Encounter search by _id'
      description %(
        A server SHALL support searching by _id on the Encounter resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )

      input_order :url

      input :encounter_id,
        title: 'Encounter _id',
        default: 'enc-nsysu-hd-past-1-0608'

      # Named requests can be used by other tests
      makes_request :encounter

      run do
        fhir_search('Encounter', params: { _id: encounter_id }, name: :encounter)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 class 查詢所有Encounter：
    test do
      title '[GET] Server returns valid results for Encounter search by class'
      description %(
        A server SHALL support searching by class on the Encounter resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )

      input_order :url

      input :encounter_class,
        title: 'Encounter class',
        default: 'HH'

      run do
        fhir_search('Encounter', params: { 'class': encounter_class })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 date 查詢所有Encounter：
    test do
      title '[GET] Server returns valid results for Encounter search by date'
      description %(
        A server SHALL support searching by date on the Encounter resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )

      input_order :url

      input :encounter_date,
        title: 'Encounter date',
        default: 'gt2020-07-01'

      run do
        fhir_search('Encounter', params: { date: encounter_date })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有Encounter：
    test do
      title '[GET] Server returns valid results for Encounter search by identifier'
      description %(
        A server SHALL support searching by identifier on the Encounter resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )

      input_order :url

      input :encounter_identifier,
        title: 'Encounter identifier',
        default: '12345'

      run do
        fhir_search('Encounter', params: { 'identifier': encounter_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 location 查詢所有Encounter：
    test do
      title '[GET] Server returns valid results for Encounter search by location'
      description %(
        A server SHALL support searching by location on the Encounter resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )

      input_order :url

      input :encounter_location,
        title: 'Encounter location',
        default: 'Location/13386',
        optional: true  # 將 location 設置為選填項

      run do
        fhir_search('Encounter', params: { 'location': encounter_location })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有Encounter：
    test do
      title '[GET] Server returns valid results for Encounter search by subject'
      description %(
        A server SHALL support searching by subject on the Encounter resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )

      input_order :url

      input :encounter_subject,
        title: 'Encounter subject',
        default: 'Patient/13384'

      run do
        fhir_search('Encounter', params: { subject: encounter_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有Encounter：
    test do
      title '[GET] Server returns valid results for Encounter search by status'
      description %(
        A server SHALL support searching by status on the Encounter resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )

      input_order :url

      input :encounter_status,
        title: 'Encounter status',
        default: 'arrived'

      run do
        fhir_search('Encounter', params: { status: encounter_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Encounter resource 是否合規
    test do
      title '[GET] Encounter resource is valid'
      description %(
        Verify that the Encounter resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )
      # This test will use the response from the :encounter request in the
      # previous test
      uses_request :encounter

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Encounter resource is valid'
      description %(
        Verify that the Encounter resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )

      input_order :url

      input :encounter_resource,
        title: 'Encounter Resource',
        default: '''{
          "resourceType" : "Encounter",
          "id" : "enc-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Encounter-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>就醫資料</b></h3><p><b>識別碼</b>：E22081702</p><p><b>就醫現況</b>：finished</p><p><b>就醫分類</b>：pre-admission <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"https://terminology.hl7.org/4.0.0/ValueSet-v3-ActEncounterCode.html\">ActEncounterCode</a>#PRENC)</span></p><p><b>就醫種類</b>：Annual diabetes mellitus screening <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/R4/codesystem-encounter-type.html\">Encounter type</a>#ADMS)</span></p><p><b>服務型別</b>：腎臟內科(Nephrology (qualifier value)) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">Service type</a>#394589003)</span></p><p><b>病人</b>：<a href=\"Patient-pat-example.html\">Patient/pat-example</a> \"陳加玲\"</p><p><b>出院後的地點</b>：Home <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/R4/codesystem-encounter-discharge-disposition.html\">Discharge disposition</a>#home)</span></p><p><b>就醫發生的地點</b>：<a href=\"Location-loc-ent-example.html\">Location/loc-ent-example</a> \"衛生福利部臺北醫院\"</p><h3>參與就醫的健康照護服務提供者</h3><table class=\"grid\"><tr><td>-</td><td><b>角色</b></td><td><b>參與時段</b></td><td><b>參與人</b></td></tr><tr><td>*</td><td>primary performer <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"https://terminology.hl7.org/4.0.0/CodeSystem-v3-ParticipationType.html\">ParticipationType</a>#PPRF)</span></td><td>2022-08-01 05:00:14-0500 --&gt; 2022-08-01 06:00:14-0500</td><td><a href=\"Practitioner-pra-dr-example.html\">Practitioner/pra-dr-example</a> \"王依昇\"</td></tr></table><p><b>就醫的開始和結束時間</b>：2022-08-01 05:00:14-0500 --&gt; 2022-08-01 06:00:14-0500</p><p><b>就醫原因</b>：FH: Diabetes mellitus <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"https://browser.ihtsdotools.org/\">SNOMED CT</a>#160303001)</span></p></div>"
          },
          "identifier" : [{
            "system" : "http://healthcare.test.org/identifiers/enocunter",
            "value" : "E22081702"
          }],
          "status" : "finished",
          "class" : {
            "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
            "code" : "PRENC"
          },
          "type" : [{
            "coding" : [{
              "system" : "http://terminology.hl7.org/CodeSystem/encounter-type",
              "code" : "ADMS"
            }]
          }],
          "serviceType" : {
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "394589003",
              "display" : "Nephrology (qualifier value)"
            }],
            "text" : "腎臟內科"
          },
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          },
          "participant" : [{
            "type" : [{
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/v3-ParticipationType",
                "code" : "PPRF"
              }]
            }],
            "period" : {
              "start" : "2022-08-01T17:00:14+08:00",
              "end" : "2022-08-01T18:00:14+08:00"
            },
            "individual" : {
              "reference" : "Practitioner/1004"
            }
          }],
          "period" : {
            "start" : "2022-08-01T17:00:14+08:00",
            "end" : "2022-08-01T18:00:14+08:00"
          },
          "reasonCode" : [{
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "160303001",
              "display" : "FH: Diabetes mellitus"
            }]
          }],
          "hospitalization" : {
            "dischargeDisposition" : {
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/discharge-disposition",
                "code" : "home"
              }]
            }
          },
          "location" : [{
            "location" : {
              "reference" : "Location/13386"
            }
          }]
        }'''
      
      output :encounter_value
      
      run do 
        assert_valid_json(encounter_resource) # For safety
        resource_hash = JSON.parse(encounter_resource)
        encounter_resource = FHIR::Encounter.new(resource_hash)
        # output encounter_value: encounter_resource
        assert_valid_resource(resource: encounter_resource)
        # if resource_is_valid?(resource: encounter_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Encounter Resource to FHIR Server'
      description %(
        Send a input Encounter resource to a FHIR server database.

        [臺灣核心-就醫事件（TW Core Encounter）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Encounter-twcore.html)
      )

      input_order :url
      
      input :encounter_resource,
        title: 'Encounter Resource'

      run do 
        resource_hash = JSON.parse(encounter_resource)
        response = fhir_create FHIR::Encounter.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
