module InfernoTWCoreIG
  class PatientGroup < Inferno::TestGroup
    title 'Patient(病人) Tests '
    description 'Verify that the server makes Patient resources available'
    id :patient_group

    input_order :url, :patient_id, :patient_birthdate, :patient_gender, :patient_identifier, :patient_name, :patient_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Patient：
    test do
      title '[GET] Server returns valid results for Patient search by _id'
      description %(
        A server SHALL support searching by _id on the Patient resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-病人（TW Core Patient）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Patient-twcore.html)
      )

      input_order :url

      input :patient_id,
        title: 'Patient _id',
        default: 'pat-nsysu-hd-001'

      # Named requests can be used by other tests
      makes_request :patient

      run do
        fhir_search('Patient', params: { _id: patient_id }, name: :patient)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 birthdate 查詢所有Patient：
    test do
      title '[GET] Server returns valid results for Patient search by birthdate'
      description %(
        A server SHALL support searching by birthdate on the Patient resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-病人（TW Core Patient）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Patient-twcore.html)
      )

      input_order :url

      input :patient_birthdate,
        title: 'Patient birthdate',
        default: '2005'

      run do
        fhir_search('Patient', params: { birthdate: patient_birthdate })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 gender 查詢所有Patient：
    test do
      title '[GET] Server returns valid results for Patient search by gender'
      description %(
        A server SHALL support searching by gender on the Patient resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-病人（TW Core Patient）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Patient-twcore.html)
      )

      input_order :url

      input :patient_gender,
        title: 'Patient gender',
        default: 'male'

      run do
        fhir_search('Patient', params: { gender: patient_gender })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有Patient：
    test do
      title '[GET] Server returns valid results for Patient search by identifier'
      description %(
        A server SHALL support searching by identifier on the Patient resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-病人（TW Core Patient）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Patient-twcore.html)
      )

      input_order :url

      input :patient_identifier,
        title: 'Patient identifier',
        default: '1'

      run do
        fhir_search('Patient', params: { identifier: patient_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 name 查詢所有Patient：
    test do
      title '[GET] Server returns valid results for Patient search by name'
      description %(
        A server SHALL support searching by name on the Patient resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-病人（TW Core Patient）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Patient-twcore.html)
      )

      input_order :url

      input :patient_name,
        title: 'Patient name',
        default: 'pt'

      run do
        fhir_search('Patient', params: { name: patient_name })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Patient resource 是否合規
    test do
      title '[GET] Patient resource is valid'
      description %(
        Verify that the Patient resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-病人（TW Core Patient）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Patient-twcore.html)
      )
      # This test will use the response from the :patient request in the
      # previous test
      uses_request :patient

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Patient resource is valid'
      description %(
        Verify that the Patient resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-病人（TW Core Patient）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Patient-twcore.html)
      )

      input_order :url

      input :patient_resource,
        title: 'Patient Resource',
        default: '''{
          "resourceType" : "Patient",
          "id" : "pat-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Patient-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>病人基本資料-身分證字號及病歷號</b></h3><blockquote><p><b>識別碼型別</b>：National Person Identifier <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://terminology.hl7.org/CodeSystem/v2-0203\">Identifier Type Codes</a>#NNxxx <b>[extension: <a href=\"StructureDefinition-identifier-suffix.html\">Identifier Suffix</a>]：</b>TWN）</span><br/><b>身分證字號（official）</b>：A123456789 （http://www.moi.gov.tw）</p></blockquote><blockquote><p><b>識別碼型別</b>：Medical record number <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://terminology.hl7.org/CodeSystem/v2-0203\">Identifier Type Codes</a>#MR）</span><br/><b>病歷號（official）</b>：8862168 （https://www.tph.mohw.gov.tw）</p></blockquote><p><b>病人的紀錄（active）</b>：使用中</p><p><b>姓名（official）</b>：陳加玲 Chan, Chia Lin</p><p><b>性別</b>：女性</p><p><b>出生日期</b>：1990-01-01</p><p><b>年齡[extension: <a href=\"StructureDefinition-person-age.html\">person-age</a>]</b>：32</p><p><b>國籍[extension: <a href=\"http://hl7.org/fhir/StructureDefinition/patient-nationality\">patient-nationality</a>]</b>：<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\"> （ <a href=\"https://terminology.hl7.org/CodeSystem-ISO3166Part1.html\">ISO3166Part1</a>#TW）</span></p><p><b>聯絡方式</b>：Phone <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"https://hl7.org/fhir/R4/valueset-contact-point-system.html\">ContactPointSystem</a>#phone）</span><br/><b>聯絡電話</b>：（Mobile）0911327999 <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"https://build.fhir.org/codesystem-contact-point-use.html\">ContactPointUse</a>#mobile）</span><br/><b>聯絡電話使用效期</b>：2022-07-31至2024-07-31</p><p><b>聯絡地址</b>：(103)臺北市大同區大有里19鄰承德路三段52巷6弄210號2樓B室<br/><b>郵遞區號（postalCode） [extension: <a href=\"StructureDefinition-tw-postal-code.html\">tw-postal-code</a>] </b>： <a href=\"CodeSystem-postal-code3-tw.html\">103</a><br/><b>縣/市（district）</b>：臺北市<br/><b>鄉/鎮/市/區（city）</b>：大同區<br/><b>村(里)（village） [extension: <a href=\"StructureDefinition-tw-village.html\">tw-village</a>] </b>：大有里<br/><b>鄰（neighborhood） [extension: <a href=\"StructureDefinition-tw-neighborhood.html\">tw-neighborhood</a>] </b>：19鄰<br/><b>路/街（line）</b>：承德路<br/><b>段(section) [extension: <a href=\"StructureDefinition-tw-section.html\">tw-section</a>] </b>：三段<br/><b>巷/衖（lane） [extension: <a href=\"StructureDefinition-tw-lane.html\">tw-lane</a>] </b>：52巷<br/><b>弄（alley） [extension: <a href=\"StructureDefinition-tw-alley.html\">tw-alley</a>] </b>：6弄<br/><b>號（number） [extension: <a href=\"StructureDefinition-tw-number.html\">tw-number</a>] </b>：210號<br/><b>樓（floor） [extension: <a href=\"StructureDefinition-tw-floor.html\">tw-floor</a>] </b>：2樓<br/><b>室（room） [extension: <a href=\"StructureDefinition-tw-room.html\">tw-room</a>] </b>：B室<br/><b>國家（country）</b>：臺灣<br/><br/></p><p><b>婚姻狀態</b>：unmarried <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://terminology.hl7.org/CodeSystem/v3-MaritalStatus\">臺灣婚姻狀態值集</a>#U）</span></p><p><b>聯絡人（official）</b>：李立偉 Li, Li Wei<br/><b>關係</b>：father <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://terminology.hl7.org/CodeSystem/v3-RoleCode\">PatientRelationshipType</a>#FTH）</span><br/><b>聯絡方式</b>：Phone <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"https://hl7.org/fhir/R4/valueset-contact-point-system.html\">ContactPointSystem</a>#phone）</span><br/><b>聯絡電話</b>：（Mobile）0917159753 <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"https://build.fhir.org/codesystem-contact-point-use.html\">ContactPointUse</a>#mobile）</span><br/><b>聯絡電話使用效期</b>：2022-07-31至2024-07-31</p><p><b>向病人說明健康狀態時所使用的語言</b>：中文</p><p><b>紀錄的保管機構</b>： <a href=\"Organization-org-hosp-example.html\">Organization/org-hosp-example</a> \"衛生福利部臺北醫院\"</p><p><b>病人影像</b>： <a href=\"https://2.bp.blogspot.com/-v3yEwItkXKQ/VaMN_1Nx6TI/AAAAAAAAvhM/zDXN_eZw_UE/s800/youngwoman_42.png\">patient.png</a><br/><img src=\"https://2.bp.blogspot.com/-v3yEwItkXKQ/VaMN_1Nx6TI/AAAAAAAAvhM/zDXN_eZw_UE/s800/youngwoman_42.png\" width=\"250px\"/></p></div>"
          },
          "extension" : [{
            "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/person-age",
            "valueAge" : {
              "value" : 32,
              "system" : "http://unitsofmeasure.org",
              "code" : "a"
            }
          },
          {
            "extension" : [{
              "url" : "code",
              "valueCodeableConcept" : {
                "coding" : [{
                  "system" : "urn:iso:std:iso:3166",
                  "code" : "TW"
                }]
              }
            }],
            "url" : "http://hl7.org/fhir/StructureDefinition/patient-nationality"
          }],
          "identifier" : [{
            "use" : "official",
            "type" : {
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/v2-0203",
                "code" : "NNxxx",
                "_code" : {
                  "extension" : [{
                    "extension" : [{
                      "url" : "suffix",
                      "valueString" : "TWN"
                    },
                    {
                      "url" : "valueSet",
                      "valueCanonical" : "http://hl7.org/fhir/ValueSet/iso3166-1-3"
                    }],
                    "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/identifier-suffix"
                  }]
                }
              }]
            },
            "system" : "http://www.moi.gov.tw",
            "value" : "A123456789"
          },
          {
            "use" : "official",
            "type" : {
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/v2-0203",
                "code" : "MR"
              }]
            },
            "system" : "https://www.tph.mohw.gov.tw",
            "value" : "8862168"
          }],
          "active" : true,
          "name" : [{
            "use" : "official",
            "text" : "陳加玲",
            "family" : "Chen",
            "given" : ["Chia Lin"]
          }],
          "telecom" : [{
            "system" : "phone",
            "value" : "0911327999",
            "use" : "mobile",
            "period" : {
              "start" : "2022-07-31",
              "end" : "2024-07-31"
            }
          }],
          "gender" : "female",
          "birthDate" : "1990-01-01",
          "address" : [{
            "extension" : [{
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-section",
              "valueString" : "三段"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-number",
              "valueString" : "210號"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-village",
              "valueString" : "大有里"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-neighborhood",
              "valueString" : "19鄰"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-lane",
              "valueString" : "52巷"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-alley",
              "valueString" : "6弄"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-floor",
              "valueString" : "2樓"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-room",
              "valueString" : "B室"
            }],
            "text" : "臺北市大同區大有里19鄰承德路三段52巷6弄210號2樓B室",
            "line" : ["承德路"],
            "city" : "大同區",
            "district" : "臺北市",
            "_postalCode" : {
              "extension" : [{
                "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-postal-code",
                "valueCodeableConcept" : {
                  "coding" : [{
                    "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/postal-code3-tw",
                    "code" : "103"
                  }]
                }
              }]
            },
            "country" : "TW"
          }],
          "maritalStatus" : {
            "coding" : [{
              "system" : "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus",
              "code" : "U"
            }]
          },
          "photo" : [{
            "contentType" : "image/jpeg",
            "url" : "patient.png"
          }],
          "contact" : [{
            "relationship" : [{
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
                "code" : "FTH"
              }]
            }],
            "name" : {
              "use" : "official",
              "text" : "李立偉",
              "family" : "Li",
              "given" : ["Li Wei"]
            },
            "telecom" : [{
              "system" : "phone",
              "value" : "0917159753",
              "use" : "mobile",
              "period" : {
                "start" : "2022-07-31",
                "end" : "2024-07-31"
              }
            }]
          }],
          "communication" : [{
            "language" : {
              "coding" : [{
                "system" : "urn:ietf:bcp:47",
                "code" : "zh-TW"
              }]
            }
          }],
          "managingOrganization" : {
            "reference" : "Organization/org-nsysu"
          }
        }'''
      
      output :patient_value
      
      run do 
        assert_valid_json(patient_resource) # For safety
        resource_hash = JSON.parse(patient_resource)
        patient_resource = FHIR::Patient.new(resource_hash)
        # output patient_value: patient_resource
        assert_valid_resource(resource: patient_resource)
        # if resource_is_valid?(resource: patient_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Patient Resource to FHIR Server'
      description %(
        Send a input Patient resource to a FHIR server database.

        [臺灣核心-病人（TW Core Patient）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Patient-twcore.html)
      )

      input_order :url
      
      input :patient_resource,
        title: 'Patient Resource'

      run do 
        resource_hash = JSON.parse(patient_resource)
        response = fhir_create FHIR::Patient.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
