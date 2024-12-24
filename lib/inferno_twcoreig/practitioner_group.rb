module InfernoTWCoreIG
  class PractitionerGroup < Inferno::TestGroup
    title 'Practitioner(健康照護服務提供者) Tests'
    description 'Verify that the server makes Practitioner resources available'
    id :practitioner_group

    input_order :url, :practitioner_id, :practitioner_identifier, :practitioner_name, :practitioner_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Practitioner：
    test do
      title '[GET] Server returns valid results for Practitioner search by _id'
      description %(
        A server SHALL support searching by _id on the Practitioner resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-健康照護服務提供者（TW Core Practitioner）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Practitioner-twcore.html)
      )

      input_order :url

      input :practitioner_id,
        title: 'Practitioner _id',
        default: '13192'

      # Named requests can be used by other tests
      makes_request :practitioner

      run do
        fhir_search('Practitioner', params: { _id: practitioner_id }, name: :practitioner)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有Practitioner：
    test do
      title '[GET] Server returns valid results for Practitioner search by identifier'
      description %(
        A server SHALL support searching by identifier on the Practitioner resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-健康照護服務提供者（TW Core Practitioner）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Practitioner-twcore.html)
      )

      input_order :url

      input :practitioner_identifier,
        title: 'Practitioner identifier',
        default: 'D123456789'

      run do
        fhir_search('Practitioner', params: { identifier: practitioner_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 name 查詢所有Practitioner：
    test do
      title '[GET] Server returns valid results for Practitioner search by name'
      description %(
        A server SHALL support searching by name on the Practitioner resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-健康照護服務提供者（TW Core Practitioner）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Practitioner-twcore.html)
      )

      input_order :url

      input :practitioner_name,
        title: 'Practitioner name',
        default: '王依昇'

      run do
        fhir_search('Practitioner', params: { name: practitioner_name })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Practitioner resource 是否合規
    test do
      title '[GET] Practitioner resource is valid'
      description %(
        Verify that the Practitioner resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-健康照護服務提供者（TW Core Practitioner）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Practitioner-twcore.html)
      )
      # This test will use the response from the :practitioner request in the
      # previous test
      uses_request :practitioner

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Practitioner resource is valid'
      description %(
        Verify that the Practitioner resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-健康照護服務提供者（TW Core Practitioner）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Practitioner-twcore.html)
      )

      input_order :url

      input :practitioner_resource,
        title: 'Practitioner Resource',
        default: '''{
          "resourceType" : "Practitioner",
          "id" : "pra-radio-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Practitioner-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>醫事放射師基本資料</b></h3><p><b>識別碼型別</b>：Medical License number <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://terminology.hl7.org/CodeSystem/v2-0203\">Identifier Type Codes</a>#MD）</span><br/><b>員工編號（official）</b>：KP00018 （https://www.tph.mohw.gov.tw）</p><p><b>健康照護服務提供者的紀錄（active）</b>：使用中</p><p><b>姓名（official）</b>：王曉明 Wang, Xiao Ming</p><p><b>性別</b>：男性</p><p><b>出生日期</b>：1988-01-16</p><p><b>聯絡方式</b>：Phone<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\"> （ <a href=\"https://hl7.org/fhir/R4/valueset-contact-point-system.html\">ContactPointSystem</a>#phone）</span><br/><b>聯絡電話</b>：（Mobile）0993277827<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\"> （ <a href=\"https://build.fhir.org/codesystem-contact-point-use.html\">ContactPointUse</a>#mobile）</span><br/><b>聯絡電話使用效期</b>：2022-07-31至2024-07-31</p><p><b>聯絡地址</b>：(330)桃園市桃園區五福五街31號<br/><b>郵遞區號（postalCode）</b>[extension: <a href=\"StructureDefinition-tw-postal-code.html\">tw-postal-code</a>]： <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"CodeSystem-postal-code3-tw.html\">330</a>#</span><br/><b>縣/市（district）</b>：桃園市<br/><b>鄉/鎮/市/區（city）</b>：桃園區<br/><b>路/街（line）</b>：五福五街<br/><b>號（number）</b>[extension: <a href=\"StructureDefinition-tw-number.html\">tw-number</a>]：31號<br/><b>國家（country）</b>：臺灣<br/></p><p><b>資格證書的型別</b>：醫事放射師(Radiologist) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://snomed.info/sct\">SNOMED CT</a>#66862007）</span><br/><b>資格證書的開始日期</b>：2005-01-01</p><p><b>照護服務提供人員影像</b>： <a href=\"https://1.bp.blogspot.com/-aee3S1fF82s/Xtt6fVkK9rI/AAAAAAABZQk/YEZzdVTp_w4kHSLtq4oZt8z6qyrqagC1wCNcBGAsYHQ/s1600/medical_scrub_man_darkblue.png\">https://1.bp.blogspot.com/-aee3S1fF82s/Xtt6fVkK9rI/AAAAAAABZQk/YEZzdVTp_w4kHSLtq4oZt8z6qyrqagC1wCNcBGAsYHQ/s1600/medical_scrub_man_darkblue.png</a><br/><img src=\"https://1.bp.blogspot.com/-aee3S1fF82s/Xtt6fVkK9rI/AAAAAAABZQk/YEZzdVTp_w4kHSLtq4oZt8z6qyrqagC1wCNcBGAsYHQ/s1600/medical_scrub_man_darkblue.png\" width=\"250px\"/></p></div>"
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
            "value" : "KP00018"
          }],
          "active" : true,
          "name" : [{
            "use" : "official",
            "text" : "王曉明",
            "family" : "Wang",
            "given" : ["Xiao Ming"]
          }],
          "telecom" : [{
            "system" : "phone",
            "value" : "0993277827",
            "use" : "mobile",
            "period" : {
              "start" : "2022-07-31",
              "end" : "2024-07-31"
            }
          }],
          "address" : [{
            "extension" : [{
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-number",
              "valueString" : "31號"
            }],
            "text" : "桃園市桃園區五福五街31號",
            "line" : ["五福五街"],
            "city" : "桃園區",
            "district" : "桃園市",
            "_postalCode" : {
              "extension" : [{
                "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-postal-code",
                "valueCodeableConcept" : {
                  "coding" : [{
                    "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/postal-code3-tw",
                    "code" : "330"
                  }]
                }
              }]
            },
            "country" : "TW"
          }],
          "gender" : "male",
          "birthDate" : "1988-01-16",
          "photo" : [{
            "contentType" : "image/jpeg",
            "data" : "TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=",
            "url" : "https://1.bp.blogspot.com/-aee3S1fF82s/Xtt6fVkK9rI/AAAAAAABZQk/YEZzdVTp_w4kHSLtq4oZt8z6qyrqagC1wCNcBGAsYHQ/s1600/medical_scrub_man_darkblue.png"
          }],
          "qualification" : [{
            "code" : {
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "66862007",
                "display" : "Radiologist"
              }]
            },
            "period" : {
              "start" : "2005-01-01"
            }
          }]
        }'''
      
      output :practitioner_value
      
      run do 
        assert_valid_json(practitioner_resource) # For safety
        resource_hash = JSON.parse(practitioner_resource)
        practitioner_resource = FHIR::Practitioner.new(resource_hash)
        # output practitioner_value: practitioner_resource
        assert_valid_resource(resource: practitioner_resource)
        # if resource_is_valid?(resource: practitioner_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Practitioner Resource to FHIR Server'
      description %(
        Send a input Practitioner resource to a FHIR server database.

        [臺灣核心-健康照護服務提供者（TW Core Practitioner）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Practitioner-twcore.html)
      )

      input_order :url
      
      input :practitioner_resource,
        title: 'Practitioner Resource'

      run do 
        resource_hash = JSON.parse(practitioner_resource)
        response = fhir_create FHIR::Practitioner.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
