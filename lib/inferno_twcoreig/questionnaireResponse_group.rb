module InfernoTWCoreIG
  class QuestionnaireResponseGroup < Inferno::TestGroup
    title 'QuestionnaireResponse(問卷題目回覆) Tests'
    description 'Verify that the server makes QuestionnaireResponse resources available'
    id :questionnaireResponse_group

    input_order :url, :questionnaireResponse_id, :questionnaireResponse_patient, :questionnaireResponse_status, :questionnaireResponse_authored, :questionnaireResponse_questionnaire, :questionnaireResponse_resource

    # 必須（SHALL） 支援透過查詢參數 _id 查詢所有QuestionnaireResponse：
    test do
      title '[GET] Server returns valid results for QuestionnaireResponse search by _id'
      description %(
        A server SHALL support searching by _id on the QuestionnaireResponse resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-問卷題目回覆（TW Core QuestionnaireResponse）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-QuestionnaireResponse-twcore.html)
      )

      input_order :url

      input :questionnaireResponse_id,
        title: 'QuestionnaireResponse _id'

      # Named requests can be used by other tests
      makes_request :questionnaireResponse

      run do
        fhir_search('QuestionnaireResponse', params: { '_id': questionnaireResponse_id }, name: :questionnaireResponse)

        assert_response_status(200)
        assert_resource_type('QuestionnaireResponse')
      end
    end

    # 必須（SHALL） 支援透過查詢參數 patient 查詢所有QuestionnaireResponse：
    test do
      title '[GET] Server returns valid results for QuestionnaireResponse search by patient'
      description %(
        A server SHALL support searching by patient on the QuestionnaireResponse resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-問卷題目回覆（TW Core QuestionnaireResponse）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-QuestionnaireResponse-twcore.html)
      )

      input_order :url

      input :questionnaireResponse_patient,
        title: 'QuestionnaireResponse patient'

      # Named requests can be used by other tests
      makes_request :questionnaireResponse

      run do
        fhir_search('QuestionnaireResponse', params: { 'patient': questionnaireResponse_patient }, name: :questionnaireResponse)

        assert_response_status(200)
        assert_resource_type('QuestionnaireResponse')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 status 查詢所有QuestionnaireResponse：
    test do
      title '[GET] Server returns valid results for QuestionnaireResponse search by patient and status'
      description %(
        A server SHALL support searching by patient and status on the QuestionnaireResponse resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-問卷題目回覆（TW Core QuestionnaireResponse）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-QuestionnaireResponse-twcore.html)
      )

      input_order :url

      input :questionnaireResponse_patient,
        title: 'QuestionnaireResponse patient'
      
      input :questionnaireResponse_status,
        title: 'QuestionnaireResponse status'

      run do
        fhir_search('QuestionnaireResponse', params: { 'patient': questionnaireResponse_patient, 'status': questionnaireResponse_status })

        assert_response_status(200)
        assert_resource_type('QuestionnaireResponse')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 authored 查詢所有QuestionnaireResponse：
    test do
      title '[GET] Server returns valid results for QuestionnaireResponse search by patient and authored'
      description %(
        A server SHALL support searching by patient and authored on the QuestionnaireResponse resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-問卷題目回覆（TW Core QuestionnaireResponse）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-QuestionnaireResponse-twcore.html)
      )

      input_order :url

      input :questionnaireResponse_patient,
        title: 'QuestionnaireResponse patient'
      
      input :questionnaireResponse_authored,
        title: 'QuestionnaireResponse authored'

      run do
        fhir_search('QuestionnaireResponse', params: { 'patient': questionnaireResponse_patient, 'authored': questionnaireResponse_authored })

        assert_response_status(200)
        assert_resource_type('QuestionnaireResponse')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 questionnaire 查詢所有QuestionnaireResponse：
    test do
      title '[GET] Server returns valid results for QuestionnaireResponse search by patient and questionnaire'
      description %(
        A server SHALL support searching by patient and questionnaire on the QuestionnaireResponse resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-問卷題目回覆（TW Core QuestionnaireResponse）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-QuestionnaireResponse-twcore.html)
      )

      input_order :url

      input :questionnaireResponse_patient,
        title: 'QuestionnaireResponse patient'
      
      input :questionnaireResponse_questionnaire,
        title: 'QuestionnaireResponse questionnaire'

      run do
        fhir_search('QuestionnaireResponse', params: { 'patient': questionnaireResponse_patient, 'questionnaire': questionnaireResponse_questionnaire })

        assert_response_status(200)
        assert_resource_type('QuestionnaireResponse')
      end
    end

    # 驗證查詢 _id 的 QuestionnaireResponse resource 是否合規
    test do
      title '[GET] QuestionnaireResponse resource is valid'
      description %(
        Verify that the QuestionnaireResponse resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-問卷題目回覆（TW Core QuestionnaireResponse）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-QuestionnaireResponse-twcore.html)
      )
      
      # This test will use the response from the :questionnaireResponse request in the
      # previous test
      uses_request :questionnaireResponse

      run do
        assert_response_status(200)
        assert_resource_type('QuestionnaireResponse')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input QuestionnaireResponse resource is valid'
      description %(
        Verify that the QuestionnaireResponse resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-問卷題目回覆（TW Core QuestionnaireResponse）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-QuestionnaireResponse-twcore.html)
      )

      input_order :url

      input :questionnaireResponse_resource,
        title: 'QuestionnaireResponse Resource'
      
      output :questionnaireResponse_value
      
      run do 
        assert_valid_json(questionnaireResponse_resource) # For safety
        resource_hash = JSON.parse(questionnaireResponse_resource)
        questionnaireResponse_resource = FHIR::QuestionnaireResponse.new(resource_hash)
        # output questionnaireResponse_value: questionnaireResponse_resource
        assert_valid_resource(resource: questionnaireResponse_resource)
        # if resource_is_valid?(resource: questionnaireResponse_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction QuestionnaireResponses(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send QuestionnaireResponse Resource to FHIR Server'
      description %(
        Send a input Transaction QuestionnaireResponse(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-問卷題目回覆（TW Core QuestionnaireResponse）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-QuestionnaireResponse-twcore.html)
      )

      input_order :url

      input :questionnaireResponse_resource,
        title: 'QuestionnaireResponse Resource'

      run do 
        resource_hash = JSON.parse(questionnaireResponse_resource)
        response = fhir_create FHIR::QuestionnaireResponse.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  