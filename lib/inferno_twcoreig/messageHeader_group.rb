module InfernoTWCoreIG
  class MessageHeaderGroup < Inferno::TestGroup
    title 'MessageHeader(訊息表頭) Tests'
    description 'Verify that the server makes MessageHeader resources available'
    id :messageHeader_group

    input_order :url, :messageHeader_id, :messageHeader_author, :messageHeader_sender, :messageHeader_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有MessageHeader：
    test do
      title '[GET] Server returns valid results for MessageHeader search by _id'
      description %(
        A server SHALL support searching by _id on the MessageHeader resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-訊息表頭（TW Core MessageHeader）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MessageHeader-twcore.html)
      )

      input_order :url

      input :messageHeader_id,
        title: 'MessageHeader _id'

      # Named requests can be used by other tests
      makes_request :messageHeader

      run do
        fhir_search('MessageHeader', params: { _id: messageHeader_id }, name: :messageHeader)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 author 查詢所有MessageHeader：
    test do
      title '[GET] Server returns valid results for MessageHeader search by author'
      description %(
        A server SHALL support searching by author on the MessageHeader resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-訊息表頭（TW Core MessageHeader）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MessageHeader-twcore.html)
      )

      input_order :url

      input :messageHeader_author,
        title: 'MessageHeader author'

      run do
        fhir_search('MessageHeader', params: { author: messageHeader_author })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 sender 查詢所有MessageHeader：
    test do
      title '[GET] Server returns valid results for MessageHeader search by sender'
      description %(
        A server SHALL support searching by sender on the MessageHeader resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-訊息表頭（TW Core MessageHeader）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MessageHeader-twcore.html)
      )

      input_order :url

      input :messageHeader_sender,
        title: 'MessageHeader sender'

      run do
        fhir_search('MessageHeader', params: { sender: messageHeader_sender })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 MessageHeader resource 是否合規
    test do
      title '[GET] MessageHeader resource is valid'
      description %(
        Verify that the MessageHeader resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-訊息表頭（TW Core MessageHeader）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MessageHeader-twcore.html)
      )
      # This test will use the response from the :messageHeader request in the
      # previous test
      uses_request :messageHeader

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input MessageHeader resource is valid'
      description %(
        Verify that the MessageHeader resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-訊息表頭（TW Core MessageHeader）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MessageHeader-twcore.html)
      )

      input_order :url

      input :messageHeader_resource,
            title: 'MessageHeader Resource'
      
      output :messageHeader_value
      
      run do 
        assert_valid_json(messageHeader_resource) # For safety
        resource_hash = JSON.parse(messageHeader_resource)
        messageHeader_resource = FHIR::MessageHeader.new(resource_hash)
        # output messageHeader_value: messageHeader_resource
        assert_valid_resource(resource: messageHeader_resource)
        # if resource_is_valid?(resource: messageHeader_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send MessageHeader Resource to FHIR Server'
      description %(
        Send a input MessageHeader resource to a FHIR server database.

        [臺灣核心-訊息表頭（TW Core MessageHeader）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-MessageHeader-twcore.html)
      )

      input_order :url
      
      input :messageHeader_resource,
            title: 'MessageHeader Resource'

      run do 
        resource_hash = JSON.parse(messageHeader_resource)
        response = fhir_create FHIR::MessageHeader.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
