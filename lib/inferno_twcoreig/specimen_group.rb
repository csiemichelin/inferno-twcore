module InfernoTWCoreIG
  class SpecimenGroup < Inferno::TestGroup
    title 'Specimen(檢體) Tests'
    description 'Verify that the server makes Specimen resources available'
    id :specimen_group

    input_order :url, :specimen_id, :specimen_status, :specimen_identifier, :specimen_subject, :specimen_resource 

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Specimen：
    test do
      title '[GET] Server returns valid results for Specimen search by _id'
      description %(
        A server SHALL support searching by _id on the Specimen resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_id,
        title: 'Specimen _id',
        default: '13564'

      # Named requests can be used by other tests
      makes_request :specimen

      run do
        fhir_search('Specimen', params: { _id: specimen_id }, name: :specimen)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有Specimen：
    test do
      title '[GET] Server returns valid results for Specimen search by status'
      description %(
        A server SHALL support searching by status on the Specimen resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_status,
        title: 'Specimen status',
        default: 'available'

      run do
        fhir_search('Specimen', params: { status: specimen_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有Specimen：
    test do
      title '[GET] Server returns valid results for Specimen search by identifier'
      description %(
        A server SHALL support searching by identifier on the Specimen resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_identifier,
        title: 'Specimen identifier',
        default: 'm202408113e'

      run do
        fhir_search('Specimen', params: { identifier: specimen_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有Specimen：
    test do
      title '[GET] Server returns valid results for Specimen search by subject'
      description %(
        A server SHALL support searching by subject on the Specimen resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_subject,
        title: 'Specimen subject',
        default: 'Patient/13390'

      run do
        fhir_search('Specimen', params: { subject: specimen_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Specimen resource 是否合規
    test do
      title '[GET] Specimen resource is valid'
      description %(
        Verify that the Specimen resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )
      # This test will use the response from the :specimen request in the
      # previous test
      uses_request :specimen

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Specimen resource is valid'
      description %(
        Verify that the Specimen resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_resource,
        title: 'Specimen Resource',
        default: '''{
          "resourceType" : "Specimen",
          "id" : "spe-ur-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Specimen-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>尿液樣本</b></h3><p><b>檢體狀態</b>：Available <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/specimen-status\">SpecimenStatus</a>#available)</span></p><p><b>檢體類型</b>：Urine <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SpecimenType</a>#122575003)</span></p><p><b>病人</b>：<a href=\"Patient-pat-example.html\">Patient/pat-example</a> \"陳加玲\"</p><p><b>病人採檢前禁食狀況</b>：Patient was fasting prior to the procedure. <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://terminology.hl7.org/CodeSystem/v2-0916\">v2 Relevant Clincial Information</a>#F)</span></p><p><b>檢查者</b>：<a href=\"Practitioner-pra-dr-example.html\">Practitioner/pra-dr-example</a> \"王依昇\"</p><blockquote><p><b>檢體資料</b></p><p><b>採集檢體的時間</b>：2023-11-06T09:00:00<br/><b>執行檢體採集的技術</b>：尿液採集(Urine examination) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#167217005)</span><br/><b>解剖採集部位</b>：尿道(Urethra part) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#119222001)</span><br/><b>採集檢體的數量</b>：50 mL</p></blockquote><blockquote><p><b>檢體處理資料</b></p><b>處理步驟</b>：尿液檢驗試紙分析<br/><b>檢體處理的日期和時間</b>：2023-11-06T09:30:00<br/><p><b>檢體容器資料</b></p><p><b>容器類別</b>：Urine specimen container <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#706054001)</span><br/><b>容器說明</b>：尿液檢體容器<br/><b>容器的大小</b>：60 mL<br/><b>容器內的檢體量</b>：50 mL</p></blockquote><p><b>備註</b>：此尿液樣本來自患者的尿液分析</p></div>"
          },
          "status" : "available",
          "type" : {
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "122575003",
              "display" : "Urine specimen"
            }]
          },
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001",
            "display" : "陳加玲"
          },
          "receivedTime" : "2023-11-06T09:00:00.000Z",
          "collection" : {
            "collector" : {
              "reference" : "Practitioner/1004",
              "display" : "王依昇"
            },
            "collectedDateTime" : "2023-11-06T08:30:08.000Z",
            "quantity" : {
              "value" : 50,
              "unit" : "mL"
            },
            "method" : {
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "167217005",
                "display" : "Urine examination"
              }],
              "text" : "尿液採集"
            },
            "bodySite" : {
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "119222001",
                "display" : "Urethra part"
              }],
              "text" : "尿道"
            },
            "fastingStatusCodeableConcept" : {
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/v2-0916",
                "code" : "F",
                "display" : "Patient was fasting prior to the procedure."
              }]
            }
          },
          "processing" : [{
            "description" : "尿液檢驗試紙分析",
            "timeDateTime" : "2023-11-06T09:30:00Z"
          }],
          "container" : [{
            "description" : "尿液檢體容器",
            "type" : {
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "706054001",
                "display" : "Urine specimen container"
              }]
            },
            "capacity" : {
              "value" : 60,
              "unit" : "mL"
            },
            "specimenQuantity" : {
              "value" : 50,
              "unit" : "mL"
            }
          }],
          "note" : [{
            "text" : "此尿液樣本來自患者的尿液分析"
          }]
        }'''
      
      output :specimen_value
      
      run do 
        assert_valid_json(specimen_resource) # For safety
        resource_hash = JSON.parse(specimen_resource)
        specimen_resource = FHIR::Specimen.new(resource_hash)
        # output specimen_value: specimen_resource
        assert_valid_resource(resource: specimen_resource)
        # if resource_is_valid?(resource: specimen_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Specimen Resource to FHIR Server'
      description %(
        Send a input Specimen resource to a FHIR server database.

        [臺灣核心-地點（TW Core Specimen）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Specimen-twcore.html)
      )

      input_order :url

      input :specimen_resource,
        title: 'Specimen Resource'

      run do 
        resource_hash = JSON.parse(specimen_resource)
        response = fhir_create FHIR::Specimen.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
