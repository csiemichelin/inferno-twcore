module InfernoTWCoreIG
  class DiagnosticReportGroup < Inferno::TestGroup
    title 'DiagnosticReport(診斷報告) Tests'
    description 'Verify that the server makes DiagnosticReport resources available'
    id :diagnosticReport_group

    input_order :url, :diagnosticReport_id, :diagnosticReport_status, :diagnosticReport_subject, :diagnosticReport_category, :diagnosticReport_code, :diagnosticReport_date, :diagnosticReport_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有DiagnosticReport：
    test do
      title '[GET] Server returns valid results for DiagnosticReport search by _id'
      description %(
        A server SHALL support searching by _id on the DiagnosticReport resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-診斷報告（TW Core DiagnosticReport）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DiagnosticReport-twcore.html)
      )

      input_order :url

      input :diagnosticReport_id,
        title: 'DiagnosticReport _id',
        default: '13502'

      # Named requests can be used by other tests
      makes_request :diagnosticReport

      run do
        fhir_search('DiagnosticReport', params: { _id: diagnosticReport_id }, name: :diagnosticReport)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有DiagnosticReport：
    test do
      title '[GET] Server returns valid results for DiagnosticReport search by status'
      description %(
        A server SHALL support searching by status on the DiagnosticReport resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-診斷報告（TW Core DiagnosticReport）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DiagnosticReport-twcore.html)
      )

      input_order :url

      input :diagnosticReport_status,
        title: 'DiagnosticReport status',
        default: 'partial'

      run do
        fhir_search('DiagnosticReport', params: { 'status': diagnosticReport_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有DiagnosticReport：
    test do
      title '[GET] Server returns valid results for DiagnosticReport search by subject'
      description %(
        A server SHALL support searching by subject on the DiagnosticReport resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-診斷報告（TW Core DiagnosticReport）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DiagnosticReport-twcore.html)
      )

      input_order :url

      input :diagnosticReport_subject,
        title: 'DiagnosticReport subject',
        default: 'Patient/13390'

      run do
        fhir_search('DiagnosticReport', params: { subject: diagnosticReport_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 category 查詢所有DiagnosticReport：
    test do
      title '[GET] Server returns valid results for DiagnosticReport search by category'
      description %(
        A server SHALL support searching by category on the DiagnosticReport resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-診斷報告（TW Core DiagnosticReport）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DiagnosticReport-twcore.html)
      )

      input_order :url

      input :diagnosticReport_category,
        title: 'DiagnosticReport category',
        default: 'LAB'

      run do
        fhir_search('DiagnosticReport', params: { 'category': diagnosticReport_category })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 code 查詢所有DiagnosticReport：
    test do
      title '[GET] Server returns valid results for DiagnosticReport search by code'
      description %(
        A server SHALL support searching by code on the DiagnosticReport resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-診斷報告（TW Core DiagnosticReport）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DiagnosticReport-twcore.html)
      )

      input_order :url

      input :diagnosticReport_code,
        title: 'DiagnosticReport code',
        default: '59770-8'

      run do
        fhir_search('DiagnosticReport', params: { code: diagnosticReport_code })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 date 查詢所有DiagnosticReport：
    test do
      title '[GET] Server returns valid results for DiagnosticReport search by date'
      description %(
        A server SHALL support searching by date on the DiagnosticReport resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-診斷報告（TW Core DiagnosticReport）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DiagnosticReport-twcore.html)
      )

      input_order :url

      input :diagnosticReport_date,
        title: 'DiagnosticReport date',
        default: 'gt2022-07-01'

      run do
        fhir_search('DiagnosticReport', params: { 'date': diagnosticReport_date })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 DiagnosticReport resource 是否合規
    test do
      title '[GET] DiagnosticReport resource is valid'
      description %(
        Verify that the DiagnosticReport resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-診斷報告（TW Core DiagnosticReport）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DiagnosticReport-twcore.html)
      )
      # This test will use the response from the :diagnosticReport request in the
      # previous test
      uses_request :diagnosticReport

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input DiagnosticReport resource is valid'
      description %(
        Verify that the DiagnosticReport resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-診斷報告（TW Core DiagnosticReport）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DiagnosticReport-twcore.html)
      )

      input_order :url

      input :diagnosticReport_resource,
        title: 'DiagnosticReport Resource',
        default: '''{
          "resourceType": "DiagnosticReport",
          "id": "13408",
          "meta": {
              "versionId": "1",
              "lastUpdated": "2024-08-11T06:05:16.813+00:00",
              "source": "#KDAXn96iNFJNrRsY",
              "profile": [
                  "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/DiagnosticReport-twcore"
              ]
          },
          "status": "partial",
          "category": [
              {
                  "coding": [
                      {
                          "system": "http://terminology.hl7.org/CodeSystem/v2-0074",
                          "code": "LAB",
                          "display": "Laboratory"
                      }
                  ],
                  "text": "血液學"
              }
          ],
          "code": {
              "coding": [
                  {
                      "system": "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/loinc-tw",
                      "code": "59770-8",
                      "display": "Procedure estimated blood loss Narrativ"
                  }
              ],
              "text": "手術估計失血量"
          },
          "subject": {
              "reference": "Patient/13390"
          },
          "effectiveDateTime": "2024-07-30",
          "issued": "2024-08-10T16:23:19+12:00",
          "performer": [
              {
                  "reference": "Practitioner/13391"
              }
          ],
          "result": [
              {
                  "reference": "Observation/13406"
              }
          ],
          "conclusion": "500 ml"
      }'''
      
      output :diagnosticReport_value
      
      run do 
        assert_valid_json(diagnosticReport_resource) # For safety
        resource_hash = JSON.parse(diagnosticReport_resource)
        diagnosticReport_resource = FHIR::DiagnosticReport.new(resource_hash)
        # output diagnosticReport_value: diagnosticReport_resource
        assert_valid_resource(resource: diagnosticReport_resource)
        # if resource_is_valid?(resource: diagnosticReport_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send DiagnosticReport Resource to FHIR Server'
      description %(
        Send a input DiagnosticReport resource to a FHIR server database.

        [臺灣核心-診斷報告（TW Core DiagnosticReport）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-DiagnosticReport-twcore.html)
      )

      input_order :url
      
      input :diagnosticReport_resource,
        title: 'DiagnosticReport Resource'

      run do 
        resource_hash = JSON.parse(diagnosticReport_resource)
        response = fhir_create FHIR::DiagnosticReport.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
