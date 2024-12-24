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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-照護團隊（TW Core CareTeam）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CareTeam-twcore.html)
      )

      input_order :url

      input :careTeam_patient,
        title: 'CareTeam patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :careTeam_status,
        title: 'CareTeam status',
        default: 'active'

      # Named requests can be used by other tests
      makes_request :careTeam

      run do
        fhir_search('CareTeam', params: { 'patient': careTeam_patient, 'status': careTeam_status }, name: :careTeam)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 role 查詢所有CareTeam：
    test do
      title '[GET] Server returns valid results for CareTeam search by patient and role'
      description %(
        A server SHALL support searching by patient and role on the CareTeam resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-照護團隊（TW Core CareTeam）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CareTeam-twcore.html)
      )

      input_order :url
      
      input :careTeam_patient,
        title: 'CareTeam patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :careTeam_role,
        title: 'CareTeam role',
        default: '46255001'

      run do
        fhir_search('CareTeam', params: { 'patient': careTeam_patient, 'role': careTeam_role })

        assert_response_status(200)
        assert_resource_type('Bundle')
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
        assert_resource_type('Bundle')
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

      input_order :url

      input :careTeam_resource,
        title: 'CareTeam Resource',
        default: '''{
          "resourceType" : "CareTeam",
          "id" : "careteam-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/CareTeam-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p class=\"res-header-id\"><b>Generated Narrative: CareTeam careteam-example</b></p><a name=\"careteam-example\"> </a><a name=\"hccareteam-example\"> </a><a name=\"careteam-example-en-US\"> </a><p><b>status</b>: Active</p><p><b>subject</b>: <a href=\"Patient-pat-example.html\">陳加玲(official) Female, DoB: 1990-01-01 ( Medical record number\u00a0(use:\u00a0official,\u00a0))</a></p><blockquote><p><b>participant</b></p><p><b>role</b>: <span title=\"Codes:{http://snomed.info/sct 21450003}\">Neuropsychiatrist</span></p><p><b>member</b>: <a href=\"Practitioner-pra-dr-example.html\">Practitioner 王依昇(official)</a></p></blockquote><blockquote><p><b>participant</b></p><p><b>role</b>: <span title=\"Codes:{http://snomed.info/sct 224535009}\">Registered nurse</span></p><p><b>member</b>: <a href=\"Practitioner-pra-nurse-example.html\">Practitioner 陳莉(official)</a></p></blockquote><blockquote><p><b>participant</b></p><p><b>role</b>: <span title=\"Codes:{http://snomed.info/sct 46255001}\">Pharmacist</span></p><p><b>member</b>: <a href=\"Practitioner-pra-phc-example.html\">Practitioner 陳耀詩(official)</a></p></blockquote><blockquote><p><b>participant</b></p><p><b>role</b>: <span title=\"Codes:{http://snomed.info/sct 159016003}\">Medical radiographer</span></p><p><b>member</b>: <a href=\"Practitioner-pra-radio-example.html\">Practitioner 王曉明(official)</a></p></blockquote></div>"
          },
          "status" : "active",
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          },
          "participant" : [{
            "role" : [{
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "21450003",
                "display" : "Neuropsychiatrist"
              }]
            }],
            "member" : {
              "reference" : "Practitioner/1004"
            }
          },
          {
            "role" : [{
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "224535009",
                "display" : "Registered nurse"
              }]
            }],
            "member" : {
              "reference" : "Practitioner/13192"
            }
          },
          {
            "role" : [{
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "46255001",
                "display" : "Pharmacist"
              }]
            }],
            "member" : {
              "reference" : "Practitioner/1004"
            }
          },
          {
            "role" : [{
              "coding" : [{
                "system" : "http://snomed.info/sct",
                "code" : "159016003",
                "display" : "Medical radiographer"
              }]
            }],
            "member" : {
              "reference" : "Practitioner/13192"
            }
          }]
        }'''
      
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

      input_order :url
      
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
  