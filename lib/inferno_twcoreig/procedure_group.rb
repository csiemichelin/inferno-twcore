module InfernoTWCoreIG
  class ProcedureGroup < Inferno::TestGroup
    title 'Procedure(處置或手術) Tests'
    description 'Verify that the server makes Procedure resources available'
    id :procedure_group

    input_order :url, :procedure_id, :procedure_code, :procedure_status, :procedure_subject, :procedure_date, :procedure_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Procedure：
    test do
      title '[GET] Server returns valid results for Procedure search by _id'
      description %(
        A server SHALL support searching by _id on the Procedure resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-處置或手術（TW Core Procedure）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Procedure-twcore.html)
      )

      input_order :url

      input :procedure_id,
        title: 'Procedure _id',
        default: '13401'

      # Named requests can be used by other tests
      makes_request :procedure

      run do
        fhir_search('Procedure', params: { _id: procedure_id }, name: :procedure)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 code 查詢所有Procedure：
    test do
      title '[GET] Server returns valid results for Procedure search by code'
      description %(
        A server SHALL support searching by code on the Procedure resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-處置或手術（TW Core Procedure）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Procedure-twcore.html)
      )

      input_order :url

      input :procedure_code,
        title: 'Procedure code',
        default: '0016070'

      run do
        fhir_search('Procedure', params: { code: procedure_code })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有Procedure：
    test do
      title '[GET] Server returns valid results for Procedure search by status'
      description %(
        A server SHALL support searching by status on the Procedure resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-處置或手術（TW Core Procedure）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Procedure-twcore.html)
      )

      input_order :url

      input :procedure_status,
        title: 'Procedure status',
        default: 'preparation'

      run do
        fhir_search('Procedure', params: { status: procedure_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有Procedure：
    test do
      title '[GET] Server returns valid results for Procedure search by subject'
      description %(
        A server SHALL support searching by subject on the Procedure resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-處置或手術（TW Core Procedure）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Procedure-twcore.html)
      )

      input_order :url

      input :procedure_subject,
        title: 'Procedure subject',
        default: 'Patient/13384'

      run do
        fhir_search('Procedure', params: { subject: procedure_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 date 查詢所有Procedure：
    test do
      title '[GET] Server returns valid results for Procedure search by date'
      description %(
        A server SHALL support searching by date on the Procedure resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-處置或手術（TW Core Procedure）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Procedure-twcore.html)
      )

      input_order :url

      input :procedure_date,
        title: 'Procedure date',
        default: 'gt2022-08-11'

      run do
        fhir_search('Procedure', params: { date: procedure_date })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Procedure resource 是否合規
    test do
      title '[GET] Procedure resource is valid'
      description %(
        Verify that the Procedure resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-處置或手術（TW Core Procedure）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Procedure-twcore.html)
      )
      # This test will use the response from the :procedure request in the
      # previous test
      uses_request :procedure

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Procedure resource is valid'
      description %(
        Verify that the Procedure resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-處置或手術（TW Core Procedure）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Procedure-twcore.html)
      )

      input_order :url

      input :procedure_resource,
        title: 'Procedure Resource',
        default: '''{
          "resourceType" : "Procedure",
          "id" : "pro-appendectomy-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Procedure-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>處置或手術基本資料</b></h3><p><b>處置或手術狀態</b>：completed</p><p><b>處置或手術的識別碼</b>：闌尾切除術(Appendectomy) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#80146002)</span></p><p><b>病人</b>：<a href=\"Patient-pat-example.html\">Patient/pat-example</a> \"陳加玲\"</p><p><b>執行時間</b>：2023-11-10T14:00:00</p><p><b>處置或手術的結果識別碼</b>：闌尾成功切除(Appendix absent) <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#300309008)</span></p><p><b>追蹤說明識別碼</b>： Bone immobilization <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#274474001)</span></p></div>"
          },
          "status" : "completed",
          "code" : {
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "80146002",
              "display" : "Appendectomy"
            }],
            "text" : "闌尾切除術"
          },
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          },
          "performedDateTime" : "2023-11-10T14:00:00Z",
          "outcome" : {
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "300309008",
              "display" : "Appendix absent"
            }],
            "text" : "闌尾成功切除"
          },
          "followUp" : [{
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "code" : "274474001",
              "display" : "Bone immobilization"
            }]
          }]
        }'''
      
      output :procedure_value
      
      run do 
        assert_valid_json(procedure_resource) # For safety
        resource_hash = JSON.parse(procedure_resource)
        procedure_resource = FHIR::Procedure.new(resource_hash)
        # output procedure_value: procedure_resource
        assert_valid_resource(resource: procedure_resource)
        # if resource_is_valid?(resource: procedure_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Procedure Resource to FHIR Server'
      description %(
        Send a input Procedure resource to a FHIR server database.

        [臺灣核心-處置或手術（TW Core Procedure）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Procedure-twcore.html)
      )

      input_order :url
      
      input :procedure_resource,
        title: 'Procedure Resource'

      run do 
        resource_hash = JSON.parse(procedure_resource)
        response = fhir_create FHIR::Procedure.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
