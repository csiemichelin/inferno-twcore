module InfernoTWCoreIG
  class PractitionerRoleGroup < Inferno::TestGroup
    title 'PractitionerRole(健康照護服務提供者角色) Tests'
    description 'Verify that the server makes PractitionerRole resources available'
    id :practitionerRole_group

    input_order :url, :practitionerRole_id, :practitionerRole_identifier, :practitionerRole_specialty, :practitionerRole_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有PractitionerRole：
    test do
      title '[GET] Server returns valid results for PractitionerRole search by _id'
      description %(
        A server SHALL support searching by _id on the PractitionerRole resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url

      input :practitionerRole_id,
        title: 'PractitionerRole _id',
        default: '13400'

      # Named requests can be used by other tests
      makes_request :practitionerRole

      run do
        fhir_search('PractitionerRole', params: { _id: practitionerRole_id }, name: :practitionerRole)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有PractitionerRole：
    test do
      title '[GET] Server returns valid results for PractitionerRole search by identifier'
      description %(
        A server SHALL support searching by identifier on the PractitionerRole resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url

      input :practitionerRole_identifier,
        title: 'PractitionerRole identifier',
        default: 'DL'

      run do
        fhir_search('PractitionerRole', params: { identifier: practitionerRole_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 specialty 查詢所有PractitionerRole：
    test do
      title '[GET] Server returns valid results for PractitionerRole search by specialty'
      description %(
        A server SHALL support searching by specialty on the PractitionerRole resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url

      input :practitionerRole_specialty,
        title: 'PractitionerRole specialty',
        default: '419772000'

      run do
        fhir_search('PractitionerRole', params: { specialty: practitionerRole_specialty })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 PractitionerRole resource 是否合規
    test do
      title '[GET] PractitionerRole resource is valid'
      description %(
        Verify that the PractitionerRole resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )
      # This test will use the response from the :practitionerRole request in the
      # previous test
      uses_request :practitionerRole

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input PractitionerRole resource is valid'
      description %(
        Verify that the PractitionerRole resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url

      input :practitionerRole_resource,
        title: 'PractitionerRole Resource',
        default: '''{
          "resourceType" : "PractitionerRole",
          "id" : "praro-dr-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/PractitionerRole-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>醫師角色基本資料</b></h3><p><b>識別碼型別</b>：Medical License number <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://terminology.hl7.org/CodeSystem/v2-0203\">Identifier Type Codes</a>#MD）</span><br/><b>員工編號（official）</b>：KP00017 （https://www.tph.mohw.gov.tw）</p><p><b>紀錄狀態（active）</b>：使用中</p><p><b>授權可執業時間範圍</b>：2022-07-31 ～ 2024-07-31</p><p><b>健康照護服務提供者</b>：<a href=\"Practitioner-pra-dr-example.html\">Practitioner/pra-dr-example</a> \"王依昇\"</p><p><b>地點</b>：<a href=\"Location-loc-ent-example.html\">Location/loc-ent-example</a> \"衛生福利部臺北醫院耳鼻喉科\"</p><p><b>角色</b>：西醫師(General medicine) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://snomed.info/sct\">SNOMED CT</a>#394802001）</span></p><p><b>角色專業</b>：耳鼻喉科(Otolaryngology (qualifier value)) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://snomed.info/sct\">SNOMED CT</a>#418960008）</span></p><p><b>聯絡方式</b>：Phone<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\"> （ <a href=\"https://hl7.org/fhir/R4/valueset-contact-point-system.html\">ContactPointSystem</a>#phone）</span><br/><b>聯絡電話</b>：（Mobile）0993277826<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\"> （ <a href=\"https://build.fhir.org/codesystem-contact-point-use.html\">ContactPointUse</a>#mobile）</span><br/><b>聯絡時間</b>：週一 ～ 週五 ， 08:00-16:00<br/><b>聯絡注意事項</b>：若遇到緊急狀況可能會影響工作日。</p><p><b>此期間無提供服務</b>：2023-08-01 ～ 2023-08-15<br/><b>無法提供原因</b>：家中有事請假。<br/></p></div>"
          },
          "identifier" : [{
            "use" : "official",
            "type" : {
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/v2-0203",
                "code" : "MD"
              }]
            },
            "system" : "https://www.tph.mohw.gov.tw",
            "value" : "KP00017"
          }],
          "active" : true,
          "period" : {
            "start" : "2022-07-31",
            "end" : "2024-07-31"
          },
          "practitioner" : {
            "reference" : "Practitioner/1004",
            "display" : "王依昇"
          },
          "code" : [{
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "394802001",
              "display" : "General medicine"
            }]
          }],
          "specialty" : [{
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "418960008",
              "display" : "Otolaryngology (qualifier value)"
            }]
          }],
          "location" : [{
            "reference" : "Location/13386",
            "display" : "衛生福利部臺北醫院耳鼻喉科"
          }],
          "telecom" : [{
            "system" : "phone",
            "value" : "0993277826",
            "use" : "mobile"
          }],
          "availableTime" : [{
            "daysOfWeek" : ["mon",
            "tue",
            "wed",
            "thu",
            "fri"],
            "allDay" : false,
            "availableStartTime" : "08:00:00",
            "availableEndTime" : "16:00:00"
          }],
          "notAvailable" : [{
            "description" : "家中有事請假",
            "during" : {
              "start" : "2023-08-01",
              "end" : "2023-08-15"
            }
          }],
          "availabilityExceptions" : "若遇到緊急狀況可能會影響工作日"
        }'''
      
      output :practitionerRole_value
      
      run do 
        assert_valid_json(practitionerRole_resource) # For safety
        resource_hash = JSON.parse(practitionerRole_resource)
        practitionerRole_resource = FHIR::PractitionerRole.new(resource_hash)
        # output practitionerRole_value: practitionerRole_resource
        assert_valid_resource(resource: practitionerRole_resource)
        # if resource_is_valid?(resource: practitionerRole_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send PractitionerRole Resource to FHIR Server'
      description %(
        Send a input PractitionerRole resource to a FHIR server database.

        [臺灣核心-健康照護服務提供者角色（TW Core PractitionerRole）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-PractitionerRole-twcore.html)
      )

      input_order :url
      
      input :practitionerRole_resource,
        title: 'PractitionerRole Resource'

      run do 
        resource_hash = JSON.parse(practitionerRole_resource)
        response = fhir_create FHIR::PractitionerRole.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
