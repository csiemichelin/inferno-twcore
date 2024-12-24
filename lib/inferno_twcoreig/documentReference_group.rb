module InfernoTWCoreIG
  class DocumentReferenceGroup < Inferno::TestGroup
    title 'DocumentReference(文件參照) Tests'
    description 'Verify that the server makes DocumentReference resources available'
    id :documentReference_group

    input_order :url, :documentReference_id, :documentReference_status, :documentReference_subject, :documentReference_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有DocumentReference：
    test do
      title '[GET] Server returns valid results for DocumentReference search by _id'
      description %(
        A server SHALL support searching by _id on the DocumentReference resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-文件參照（TW Core DocumentReference）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DocumentReference-twcore.html)
      )

      input_order :url

      input :documentReference_id,
        title: 'DocumentReference _id',
        default: '13396'

      # Named requests can be used by other tests
      makes_request :documentReference

      run do
        fhir_search('DocumentReference', params: { _id: documentReference_id }, name: :documentReference)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有DocumentReference：
    test do
      title '[GET] Server returns valid results for DocumentReference search by status'
      description %(
        A server SHALL support searching by status on the DocumentReference resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-文件參照（TW Core DocumentReference）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DocumentReference-twcore.html)
      )

      input_order :url

      input :documentReference_status,
        title: 'DocumentReference status',
        default: 'current'

      run do
        fhir_search('DocumentReference', params: { 'status': documentReference_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有DocumentReference：
    test do
      title '[GET] Server returns valid results for DocumentReference search by subject'
      description %(
        A server SHALL support searching by subject on the DocumentReference resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-文件參照（TW Core DocumentReference）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DocumentReference-twcore.html)
      )

      input_order :url

      input :documentReference_subject,
        title: 'DocumentReference subject',
        default: 'Practitioner/13385'

      run do
        fhir_search('DocumentReference', params: { subject: documentReference_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 DocumentReference resource 是否合規
    test do
      title '[GET] DocumentReference resource is valid'
      description %(
        Verify that the DocumentReference resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-文件參照（TW Core DocumentReference）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DocumentReference-twcore.html)
      )
      # This test will use the response from the :documentReference request in the
      # previous test
      uses_request :documentReference

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input DocumentReference resource is valid'
      description %(
        Verify that the DocumentReference resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-文件參照（TW Core DocumentReference）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DocumentReference-twcore.html)
      )

      input_order :url

      input :documentReference_resource,
        title: 'DocumentReference Resource',
        default: '''{
          "resourceType" : "DocumentReference",
          "id" : "doc-wound-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/DocumentReference-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>驗傷報告</b></h3><p><b>狀態</b>：Current <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/R4/codesystem-document-reference-status.html\">DocumentReferenceStatus</a>#current)</span></p><p><b>類型(type)</b>：驗傷報告(Injury event summary Document) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://loinc.org\">LOINC</a>#74209-8)</span></p><p><b>病人</b>：<a href=\"Patient-pat-example.html\">Patient/pat-example</a> \"陳加玲\"</p><p><b>日期</b>：2024-01-23T15:45:00</p><p><b>紀錄者</b>：<a href=\"Practitioner-pra-dr-example.html\">Practitioner/pra-dr-example</a> \"王依昇\"</p><p><b>就醫資料</b>：<a href=\"Encounter-enc-example.html\">Encounter/enc-example</a> \"就醫資料\"</p><p><b>紀錄中使用的檔案</b>：</p><blockquote><p><b>檔案類型(type)</b>：image/jpeg</p><p><b>檔案</b>：<a href=\"https://obs.line-scdn.net/0hJczFr9HRFUxHPzhi5CVqG31pFiN0UwZPIwlETwRRS3g5ClpKL1wPImRrSCg6D1ISKQlYKGY7Dn1jBlZPf1sP/w1200\"> Wound Photo</a></p></blockquote></div>"
          },
          "status" : "current",
          "type" : {
            "coding" : [{
              "system" : "http://loinc.org",
              "code" : "74209-8",
              "display" : "Injury event summary Document"
            }],
            "text" : "驗傷報告"
          },
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          },
          "date" : "2024-01-23T15:45:00Z",
          "author" : [{
            "reference" : "Practitioner/1004"
          }],
          "custodian" : {
            "reference" : "Organization/org-nsysu"
          },
          "content" : [{
            "attachment" : {
              "contentType" : "image/jpeg",
              "url" : "https://obs.line-scdn.net/0hJczFr9HRFUxHPzhi5CVqG31pFiN0UwZPIwlETwRRS3g5ClpKL1wPImRrSCg6D1ISKQlYKGY7Dn1jBlZPf1sP/w1200",
              "title" : "Wound Photo"
            }
          }],
          "context" : {
            "encounter" : [{
              "reference" : "Encounter/13427"
            }]
          }
        }'''
      
      output :documentReference_value
      
      run do 
        assert_valid_json(documentReference_resource) # For safety
        resource_hash = JSON.parse(documentReference_resource)
        documentReference_resource = FHIR::DocumentReference.new(resource_hash)
        # output documentReference_value: documentReference_resource
        assert_valid_resource(resource: documentReference_resource)
        # if resource_is_valid?(resource: documentReference_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send DocumentReference Resource to FHIR Server'
      description %(
        Send a input DocumentReference resource to a FHIR server database.

        [臺灣核心-文件參照（TW Core DocumentReference）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DocumentReference-twcore.html)
      )

      input_order :url
      
      input :documentReference_resource,
        title: 'DocumentReference Resource'

      run do 
        resource_hash = JSON.parse(documentReference_resource)
        response = fhir_create FHIR::DocumentReference.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
