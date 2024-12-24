module InfernoTWCoreIG
  class BundleGroup < Inferno::TestGroup
    title 'Bundle(資料交換基本單位) Tests'
    description 'Verify that the server makes Bundle resources available'
    id :bundle_group

    input_order :url, :bundle_id, :bundle_identifier, :bundle_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Bundle：
    test do
      title '[GET] Server returns valid results for Bundle search by _id'
      description %(
        A server SHALL support searching by _id on the Bundle resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-資料交換基本單位（TW Core Bundle）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-twcore.html)
        
        [臺灣核心-資料交換基本單位-文件（TW Core Bundle Document）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-document-twcore.html)
        
        [臺灣核心-資料交換基本單位-信息（TW Core Bundle Message）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-message-twcore.html)
      )

      input_order :url

      input :bundle_id,
        title: 'Bundle _id',
        default: '15784'

      # Named requests can be used by other tests
      makes_request :bundle

      run do
        fhir_search('Bundle', params: { _id: bundle_id }, name: :bundle)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有Bundle：
    test do
      title '[GET] Server returns valid results for Bundle search by identifier'
      description %(
        A server SHALL support searching by identifier on the Bundle resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-資料交換基本單位（TW Core Bundle）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-twcore.html)
        
        [臺灣核心-資料交換基本單位-文件（TW Core Bundle Document）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-document-twcore.html)
        
        [臺灣核心-資料交換基本單位-信息（TW Core Bundle Message）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-message-twcore.html)
      )

      input_order :url

      input :bundle_identifier,
        title: 'Bundle identifier',
        default: '01010905170415100000000'

      run do
        fhir_search('Bundle', params: { 'identifier': bundle_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Bundle resource 是否合規
    test do
      title '[GET] Bundle resource is valid'
      description %(
        Verify that the Bundle resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-資料交換基本單位（TW Core Bundle）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-twcore.html)
        
        [臺灣核心-資料交換基本單位-文件（TW Core Bundle Document）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-document-twcore.html)
        
        [臺灣核心-資料交換基本單位-信息（TW Core Bundle Message）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-message-twcore.html)
      )
      # This test will use the response from the :bundle request in the
      # previous test
      uses_request :bundle
      
      output :bundle

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource

        # assert_valid_json(bundle) # 確認JSON有效性
        # resource_hash = JSON.parse(bundle)
        # tw_bundle_resource = FHIR::Bundle.new(resource_hash)
        # assert_valid_resource(resource: tw_bundle_resource)
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Bundle resource is valid'
      description %(
        Verify that the Bundle resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-資料交換基本單位（TW Core Bundle）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-twcore.html)
        
        [臺灣核心-資料交換基本單位-文件（TW Core Bundle Document）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-document-twcore.html)
        
        [臺灣核心-資料交換基本單位-信息（TW Core Bundle Message）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-message-twcore.html)
      )

      input_order :url

      input :bundle_resource,
        title: 'Bundle Resource',
        default: '''{"resourceType" : "Bundle",
          "id" : "bun-message-response-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Bundle-message-twcore"]
          },
          "identifier" : {
            "system" : "https://www.tph.mohw.gov.tw",
            "value" : "01014857930415100000000"
          },
          "type" : "message",
          "timestamp" : "2023-12-02T12:34:56.000Z",
          "entry" : [{
            "fullUrl" : "https://twcore.mohw.gov.tw/ig/twcore/MessageHeader/mes-response-example",
            "resource" : {
              "resourceType" : "MessageHeader",
              "id" : "mes-response-example",
              "meta" : {
                "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/MessageHeader-twcore"]
              },
              "text" : {
                "status" : "generated",
                "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>訊息表頭－response</b></h3><p><b>訊息回應識別碼</b>: efdd266b-0e09-4164-883e-35cf3871715f</p><p><b>訊息回應的事件代碼</b>: Laboratory report <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://loinc.org\">LOINC</a>#11502-2)</span></p><p><b>訊息回應來源</b>: https://www.cdc.gov.tw/</p><p><b>訊息回應類型</b>: OK <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/response-code\">ResponseType</a>#ok)</span></p></div>"
              },
              "eventCoding" : {
                "system" : "http://loinc.org",
                "code" : "11502-2",
                "display" : "Laboratory report"
              },
              "source" : {
                "endpoint" : "https://www.cdc.gov.tw/"
              },
              "response" : {
                "identifier" : "efdd266b-0e09-4164-883e-35cf3871715f",
                "code" : "ok"
              }
            }
          }]
        }'''
      
      output :bundle_value
      
      run do 
        assert_valid_json(bundle_resource) # For safety
        resource_hash = JSON.parse(bundle_resource)
        bundle_resource = FHIR::Bundle.new(resource_hash)
        # output bundle_value: bundle_resource
        assert_valid_resource(resource: bundle_resource)
        # if resource_is_valid?(resource: bundle_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction Bundles(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send Bundle Resource to FHIR Server'
      description %(
        Send a input Transaction Bundle(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-資料交換基本單位（TW Core Bundle）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-twcore.html)
        
        [臺灣核心-資料交換基本單位-文件（TW Core Bundle Document）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-document-twcore.html)
        
        [臺灣核心-資料交換基本單位-信息（TW Core Bundle Message）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Bundle-message-twcore.html)
      )

      input_order :url
      
      input :bundle_resource,
        title: 'Bundle Resource'

      run do 
        resource_hash = JSON.parse(bundle_resource)
        response = fhir_create FHIR::Bundle.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
