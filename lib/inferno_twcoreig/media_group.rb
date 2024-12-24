module InfernoTWCoreIG
  class MediaGroup < Inferno::TestGroup
    title 'Media(多媒體) Tests'
    description 'Verify that the server makes Media resources available'
    id :media_group

    input_order :url, :media_id, :media_status, :media_subject, :media_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Media：
    test do
      title '[GET] Server returns valid results for Media search by _id'
      description %(
        A server SHALL support searching by _id on the Media resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
      )

      input_order :url

      input :media_id,
        title: 'Media _id',
        default: '13395'

      # Named requests can be used by other tests
      makes_request :media

      run do
        fhir_search('Media', params: { _id: media_id }, name: :media)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有Media：
    test do
      title '[GET] Server returns valid results for Media search by status'
      description %(
        A server SHALL support searching by status on the Media resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
      )

      input_order :url

      input :media_status,
        title: 'Media status',
        default: 'preparation'

      run do
        fhir_search('Media', params: { status: media_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有Media：
    test do
      title '[GET] Server returns valid results for Media search by subject'
      description %(
        A server SHALL support searching by subject on the Media resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
      )

      input_order :url

      input :media_subject,
        title: 'Media subject',
        default: 'Practitioner/13385'

      run do
        fhir_search('Media', params: { subject: media_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Media resource 是否合規
    test do
      title '[GET] Media resource is valid'
      description %(
        Verify that the Media resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
      )
      # This test will use the response from the :media request in the
      # previous test
      uses_request :media

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Media resource is valid'
      description %(
        Verify that the Media resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
      )

      input_order :url

      input :media_resource,
        title: 'Media Resource',
        default: '''{
          "resourceType" : "Media",
          "id" : "media-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Media-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>腦部MRI</b></h3><p><b>狀態</b>: Completed <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/R4/codesystem-event-status.html\">EventStatus</a>#completed)</span></p><p><b>多媒體種類</b>: Image <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/R4/valueset-media-type.html\">MediaType</a>#image)</span></p><p><b>病人</b>：<a href=\"Patient-pat-example.html\">Patient/pat-example</a> \"陳加玲\"</p><p><b>影像檢視</b>: Erect lateral <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#260442004)</span></p><p><b>記錄資料收集日期與時間</b>: 2023-11-04T15:30:00</p><p><b>資料發行日期與時間</b>: 2023-11-04T16:00:00</p><p><b>執行者</b>：<a href=\"Practitioner-pra-radio-example.html\">Practitioner/pra-radio-example</a> \"王曉明\"</p><p><b>記錄產生的原因識別</b>：Gonococcal meningitis <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#151004)</span></p><p><b>記錄的身體部位</b>：Ventral anterior nucleus <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#3295003)</span></p><p><b>記錄使用的設備</b>：MAGNETOM Skyra 3 Tesla</p><p><b>影像資料：</b></p><blockquote><p><b>ID</b>：image1</p><p><b>資料種類</b>：image/png</p><p><b>影像長</b>：512</p><p><b>影像寬</b>：512</p><p><b>data</b>：(base64 data - 1800 bytes)</p><p><b>影像產生日期</b>：2023-12-28</p></blockquote></div>"
          },
          "status" : "completed",
          "type" : {
            "coding" : [{
              "system" : "http://terminology.hl7.org/CodeSystem/media-type",
              "code" : "image"
            }]
          },
          "view" : {
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "260442004",
              "display" : "Erect lateral"
            }],
            "text" : "Erect lateral"
          },
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001",
            "display" : "陳加玲"
          },
          "createdDateTime" : "2023-11-04T15:30:00Z",
          "issued" : "2023-11-04T16:00:00Z",
          "operator" : {
            "reference" : "Practitioner/1004"
          },
          "reasonCode" : [{
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "151004",
              "display" : "Gonococcal meningitis"
            }]
          }],
          "bodySite" : {
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "3295003",
              "display" : "Ventral anterior nucleus"
            }]
          },
          "deviceName" : "MAGNETOM Skyra 3 Tesla",
          "height" : 512,
          "width" : 512,
          "content" : {
            "id" : "image1",
            "contentType" : "image/png",
            "data" : "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",
            "creation" : "2023-12-28"
          },
          "note" : [{
            "text" : "腦部MRI"
          }]
        }'''
      
      output :media_value
      
      run do 
        assert_valid_json(media_resource) # For safety
        resource_hash = JSON.parse(media_resource)
        media_resource = FHIR::Media.new(resource_hash)
        # output media_value: media_resource
        assert_valid_resource(resource: media_resource)
        # if resource_is_valid?(resource: media_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Media Resource to FHIR Server'
      description %(
        Send a input Media resource to a FHIR server database.

        [臺灣核心-多媒體（TW Core Media）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Media-twcore.html)
      )

      input_order :url

      input :media_resource,
        title: 'Media Resource'

      run do 
        resource_hash = JSON.parse(media_resource)
        response = fhir_create FHIR::Media.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
