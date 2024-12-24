module InfernoTWCoreIG
  class CarePlanGroup < Inferno::TestGroup
    title 'CarePlan(照護計畫) Tests'
    description 'Verify that the server makes CarePlan resources available'
    id :carePlan_group

    input_order :url, :carePlan_patient, :carePlan_category, :carePlan_status, :carePlan_date, :carePlan_resource

    # 必須（SHALL） 支援透過查詢參數 patient 及 category 查詢所有CarePlan：
    test do
      title '[GET] Server returns valid results for CarePlan search by patient and category'
      description %(
        A server SHALL support searching by patient and category on the CarePlan resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-照護計畫（TW Core CarePlan）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CarePlan-twcore.html)
      )

      input_order :url

      input :carePlan_patient,
        title: 'CarePlan patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :carePlan_category,
        title: 'CarePlan category',
        default: 'assess-plan'

      # Named requests can be used by other tests
      makes_request :carePlan

      run do
        fhir_search('CarePlan', params: { 'patient': carePlan_patient, 'category': carePlan_category }, name: :carePlan)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient、category 及 date 查詢所有CarePlan：
    test do
      title '[GET] Server returns valid results for CarePlan search by patient, category and date'
      description %(
        A server SHALL support searching by patient, category and date on the CarePlan resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-照護計畫（TW Core CarePlan）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CarePlan-twcore.html)
      )

      input_order :url

      input :carePlan_patient,
        title: 'CarePlan patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :carePlan_category,
        title: 'CarePlan category',
        default: 'assess-plan'
      
      input :carePlan_date,
        title: 'CarePlan date',
        optional: true  # 將 date 設置為選填項

      run do
        fhir_search('CarePlan', params: { 'patient': carePlan_patient, 'category': carePlan_category, 'date': carePlan_date })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient、category 及 status 查詢所有CarePlan：
    test do
      title '[GET] Server returns valid results for CarePlan search by patient, category and status'
      description %(
        A server SHALL support searching by patient, category and status on the CarePlan resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-照護計畫（TW Core CarePlan）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CarePlan-twcore.html)
      )

      input_order :url

      input :carePlan_patient,
        title: 'CarePlan patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :carePlan_category,
        title: 'CarePlan category',
        default: 'assess-plan'
      
      input :carePlan_status,
        title: 'CarePlan status',
        default: 'active'

      run do
        fhir_search('CarePlan', params: { 'patient': carePlan_patient, 'category': carePlan_category, 'status': carePlan_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient、category、status 及 date 查詢所有CarePlan：
    test do
      title '[GET] Server returns valid results for CarePlan search by patient, category, status and date'
      description %(
        A server SHALL support searching by patient, category, status and date on the CarePlan resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-照護計畫（TW Core CarePlan）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CarePlan-twcore.html)
      )

      input_order :url

      input :carePlan_patient,
        title: 'CarePlan patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :carePlan_category,
        title: 'CarePlan category',
        default: 'assess-plan'
      
      input :carePlan_status,
        title: 'CarePlan status',
        default: 'active'
      
      input :carePlan_date,
        title: 'CarePlan date',
        optional: true  # 將 date 設置為選填項

      run do
        fhir_search('CarePlan', params: { 'patient': carePlan_patient, 'category': carePlan_category, 'status': carePlan_status, 'date': carePlan_date })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 patient 及 category 的 CarePlan resource 是否合規
    test do
      title '[GET] CarePlan resource is valid'
      description %(
        Verify that the CarePlan resource search by patient and category returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-照護計畫（TW Core CarePlan）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CarePlan-twcore.html)
      )
      
      # This test will use the response from the :carePlan request in the
      # previous test
      uses_request :carePlan

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input CarePlan resource is valid'
      description %(
        Verify that the CarePlan resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-照護計畫（TW Core CarePlan）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CarePlan-twcore.html)
      )

      input_order :url

      input :carePlan_resource,
        title: 'CarePlan Resource',
        default: '''{
          "resourceType" : "CarePlan",
          "id" : "careplan-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/CarePlan-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p class=\"res-header-id\"><b>Generated Narrative: CarePlan careplan-example</b></p><a name=\"careplan-example\"> </a><a name=\"hccareplan-example\"> </a><a name=\"careplan-example-en-US\"> </a><p><b>status</b>: Active</p><p><b>intent</b>: Order</p><p><b>category</b>: <span title=\"Codes:{https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/careplan-category-tw assess-plan}\">Assessment and Plan of Treatment</span></p><p><b>subject</b>: <a href=\"Patient-pat-example.html\">陳加玲(official) Female, DoB: 1990-01-01 ( Medical record number\u00a0(use:\u00a0official,\u00a0))</a></p></div>"
          },
          "status" : "active",
          "intent" : "order",
          "category" : [{
            "coding" : [{
              "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/careplan-category-tw",
              "code" : "assess-plan"
            }]
          }],
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          }
        }'''
      
      output :carePlan_value
      
      run do 
        assert_valid_json(carePlan_resource) # For safety
        resource_hash = JSON.parse(carePlan_resource)
        carePlan_resource = FHIR::CarePlan.new(resource_hash)
        # output carePlan_value: carePlan_resource
        assert_valid_resource(resource: carePlan_resource)
        # if resource_is_valid?(resource: carePlan_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction CarePlans(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send CarePlan Resource to FHIR Server'
      description %(
        Send a input Transaction CarePlan(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-照護計畫（TW Core CarePlan）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-CarePlan-twcore.html)
      )

      input_order :url

      input :carePlan_resource,
        title: 'CarePlan Resource'

      run do 
        resource_hash = JSON.parse(carePlan_resource)
        response = fhir_create FHIR::CarePlan.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  