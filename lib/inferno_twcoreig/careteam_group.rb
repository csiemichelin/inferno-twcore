module InfernoTWCoreIG
    class CareTeamGroup < Inferno::TestGroup
      title 'CareTeam(照護團隊) Tests'
      description 'Verify that the server makes CareTeam resources available'
      id :careTeam_group
  
      input_order :url, :careTeam_patient, :careTeam_status, :careTeam_role, :careTeam_resource
  
      # 必須（SHALL） 支援透過查詢參數 patient 及 status 查詢所有CareTeam：
      test do
        title '[GET] Server returns valid results for CareTeam search by patient and status'
        description %(
          A server SHALL support searching by patient and status on the CareTeam resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.
  
          Because this is the first search of the sequence, resources in the response will be used for subsequent tests.
  
          Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.
  
          [臺灣核心-照護團隊（TW Core CareTeam）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CareTeam-twcore.html)
        )
  
        input :careTeam_patient,
          title: 'CareTeam patient'
        
        input :careTeam_status,
          title: 'CareTeam status'
  
        # Named requests can be used by other tests
        makes_request :careTeam
  
        run do
          fhir_search('CareTeam', params: { 'patient': careTeam_patient, 'status': careTeam_status }, name: :careTeam)
  
          assert_response_status(200)
          assert_resource_type('CareTeam')
        end
      end
  
      # 建議應該（SHOULD） 支援透過查詢參數 patient 及 role 查詢所有CareTeam：
      test do
        title '[GET] Server returns valid results for CareTeam search by patient and role'
        description %(
          A server SHALL support searching by patient and role on the CareTeam resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.
  
          [臺灣核心-照護團隊（TW Core CareTeam）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CareTeam-twcore.html)
        )
  
        input :careTeam_patient,
          title: 'CareTeam patient'
        
        input :careTeam_role,
          title: 'CareTeam role'
  
        run do
          fhir_search('CareTeam', params: { 'patient': careTeam_patient, 'role': careTeam_role })
  
          assert_response_status(200)
          assert_resource_type('CareTeam')
        end
      end
  
      # 驗證查詢 patient 及 status 的 CareTeam resource 是否合規
      test do
        title '[GET] CareTeam resource is valid'
        description %(
          Verify that the CareTeam resource search by patient and status returned from the server is a valid FHIR resource.
  
          * Verifying the HTTP status code of a response.
          
          * Verifying that a string is valid JSON.
          
          * Validating a FHIR Resource.
  
          [臺灣核心-照護團隊（TW Core CareTeam）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CareTeam-twcore.html)
        )
        # This test will use the response from the :careTeam request in the
        # previous test
        uses_request :careTeam
  
        run do
          assert_response_status(200)
          assert_resource_type('CareTeam')
          assert_valid_resource
        end
      end
  
      # 驗證輸入的Resource是否合規
      test do 
        title '[POST] Input CareTeam resource is valid'
        description %(
          Verify that the CareTeam resource input is a valid FHIR resource.
  
          * Verifying the HTTP status code of a response.
          
          * Verifying that a string is valid JSON.
          
          * Validating a FHIR Resource.
  
          [臺灣核心-照護團隊（TW Core CareTeam）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CareTeam-twcore.html)
        )
        input :careTeam_resource,
          title: 'CareTeam Resource'
        
        output :careTeam_value
        
        run do 
          assert_valid_json(careTeam_resource) # For safety
          resource_hash = JSON.parse(careTeam_resource)
          careTeam_resource = FHIR::CareTeam.new(resource_hash)
          # output careTeam_value: careTeam_resource
          assert_valid_resource(resource: careTeam_resource)
          # if resource_is_valid?(resource: careTeam_resource)
          # end
        end 
      end 
  
      # 發送POST請求包含Transaction CareTeams(支援多個Resource驗證)的Body給FHIR Server
      test do 
        title '[POST] Send CareTeam Resource to FHIR Server'
        description %(
          Send a input Transaction CareTeam(Support multiple Resource verification) to a FHIR server database.
  
          [臺灣核心-照護團隊（TW Core CareTeam）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CareTeam-twcore.html)
        )
  
        input :careTeam_resource,
          title: 'CareTeam Resource'
  
        run do 
          resource_hash = JSON.parse(careTeam_resource)
          response = fhir_create FHIR::CareTeam.new(resource_hash)
          assert response.status == 201
        end
      end
    end
  end
  