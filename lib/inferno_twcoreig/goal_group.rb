module InfernoTWCoreIG
  class GoalGroup < Inferno::TestGroup
    title 'Goal(目標) Tests'
    description 'Verify that the server makes Goal resources available'
    id :goal_group

    input_order :url, :goal_patient, :goal_lifecycleStatus, :goal_targetDate , :goal_description, :goal_resource

    # 必須（SHALL） 支援透過查詢參數 patient 查詢所有Goal：
    test do
      title '[GET] Server returns valid results for Goal search by patient'
      description %(
        A server SHALL support searching by patient on the Goal resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-目標（TW Core Goal）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Goal-twcore.html)
      )

      input :goal_patient,
        title: 'Goal patient'

      # Named requests can be used by other tests
      makes_request :goal

      run do
        fhir_search('Goal', params: { 'patient': goal_patient }, name: :goal)

        assert_response_status(200)
        assert_resource_type('Goal')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 lifecycle-status 查詢所有Goal：
    test do
      title '[GET] Server returns valid results for Goal search by patient and lifecycle-status'
      description %(
        A server SHALL support searching by patient and lifecycle-status on the Goal resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-目標（TW Core Goal）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Goal-twcore.html)
      )

      input :goal_patient,
        title: 'Goal patient'
      
      input :goal_lifecycleStatus,
        title: 'Goal lifecycleStatus'

      run do
        fhir_search('Goal', params: { 'patient': goal_patient, 'lifecycle-status': goal_lifecycleStatus })

        assert_response_status(200)
        assert_resource_type('Goal')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 target-date 查詢所有Goal：
    test do
      title '[GET] Server returns valid results for Goal search by patient and target-date'
      description %(
        A server SHALL support searching by patient and target-date on the Goal resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-目標（TW Core Goal）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Goal-twcore.html)
      )

      input :goal_patient,
        title: 'Goal patient'
      
      input :goal_targetDate,
        title: 'Goal targetDate'

      run do
        fhir_search('Goal', params: { 'patient': goal_patient, 'target-date': goal_targetDate })

        assert_response_status(200)
        assert_resource_type('Goal')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 description 查詢所有Goal：
    test do
      title '[GET] Server returns valid results for Goal search by patient and description'
      description %(
        A server SHALL support searching by patient and description on the Goal resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-目標（TW Core Goal）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Goal-twcore.html)
      )

      input :goal_patient,
        title: 'Goal patient'
      
      input :goal_description,
        title: 'Goal description'

      run do
        fhir_search('Goal', params: { 'patient': goal_patient, 'description': goal_description })

        assert_response_status(200)
        assert_resource_type('Goal')
      end
    end

    # 驗證查詢 patient 的 Goal resource 是否合規
    test do
      title '[GET] Goal resource is valid'
      description %(
        Verify that the Goal resource search by patient returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-目標（TW Core Goal）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Goal-twcore.html)
      )
      # This test will use the response from the :goal request in the
      # previous test
      uses_request :goal

      run do
        assert_response_status(200)
        assert_resource_type('Goal')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Goal resource is valid'
      description %(
        Verify that the Goal resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-目標（TW Core Goal）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Goal-twcore.html)
      )
      input :goal_resource,
        title: 'Goal Resource'
      
      output :goal_value
      
      run do 
        assert_valid_json(goal_resource) # For safety
        resource_hash = JSON.parse(goal_resource)
        goal_resource = FHIR::Goal.new(resource_hash)
        # output goal_value: goal_resource
        assert_valid_resource(resource: goal_resource)
        # if resource_is_valid?(resource: goal_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction Goals(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send Goal Resource to FHIR Server'
      description %(
        Send a input Transaction Goal(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-目標（TW Core Goal）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Goal-twcore.html)
      )

      input :goal_resource,
        title: 'Goal Resource'

      run do 
        resource_hash = JSON.parse(goal_resource)
        response = fhir_create FHIR::Goal.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  