module InfernoTWCoreIG
  class OrganizationGroup < Inferno::TestGroup
    title 'Organization(機構) Tests'
    description 'Verify that the server makes Organization resources available'
    id :organization_group

    input_order :url, :organization_id, :organization_identifier, :organization_name, :organization_type, :organization_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Organization：
    test do
      title '[GET] Server returns valid results for Organization search by _id'
      description %(
        A server SHALL support searching by _id on the Organization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-機構（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-twcore.html)

        [臺灣核心-政府機構（TW Core Organization Government）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-govt-twcore.html)

        [臺灣核心-醫事機構（TW Core Organization Hospital Department）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-hosp-twcore.html)

        [臺灣核心-公司行號（TW Core Organization Company）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-co-twcore.html)
      )

      input_order :url

      input :organization_id,
        title: 'Organization _id',
        default: 'org-hosp-example'

      # Named requests can be used by other tests
      makes_request :organization

      run do
        fhir_search('Organization', params: { _id: organization_id }, name: :organization)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 identifier 查詢所有Organization：
    test do
      title '[GET] Server returns valid results for Organization search by identifier'
      description %(
        A server SHALL support searching by identifier on the Organization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-機構（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-twcore.html)

        [臺灣核心-政府機構（TW Core Organization Government）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-govt-twcore.html)

        [臺灣核心-醫事機構（TW Core Organization Hospital Department）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-hosp-twcore.html)

        [臺灣核心-公司行號（TW Core Organization Company）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-co-twcore.html)
      )

      input_order :url

      input :organization_identifier,
        title: 'Organization identifier',
        default: '0131060029'

      run do
        fhir_search('Organization', params: { identifier: organization_identifier })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 name 查詢所有Organization：
    test do
      title '[GET] Server returns valid results for Organization search by name'
      description %(
        A server SHALL support searching by name on the Organization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-機構（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-twcore.html)

        [臺灣核心-政府機構（TW Core Organization Government）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-govt-twcore.html)

        [臺灣核心-醫事機構（TW Core Organization Hospital Department）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-hosp-twcore.html)

        [臺灣核心-公司行號（TW Core Organization Company）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-co-twcore.html)
      )

      input_order :url

      input :organization_name,
        title: 'Organization name',
        default: '衛生福利部臺北醫院'

      run do
        fhir_search('Organization', params: { name: organization_name })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 type 查詢所有Organization：
    test do
      title '[GET] Server returns valid results for Organization search by type'
      description %(
        A server SHALL support searching by type on the Organization resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-機構（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-twcore.html)

        [臺灣核心-政府機構（TW Core Organization Government）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-govt-twcore.html)

        [臺灣核心-醫事機構（TW Core Organization Hospital Department）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-hosp-twcore.html)

        [臺灣核心-公司行號（TW Core Organization Company）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-co-twcore.html)
      )

      input_order :url

      input :organization_type,
        title: 'Organization type',
        default: 'prov'

      run do
        fhir_search('Organization', params: { type: organization_type })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Organization resource 是否合規
    test do
      title '[GET] Organization resource is valid'
      description %(
        Verify that the Organization resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-機構（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-twcore.html)

        [臺灣核心-政府機構（TW Core Organization Government）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-govt-twcore.html)

        [臺灣核心-醫事機構（TW Core Organization Hospital Department）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-hosp-twcore.html)

        [臺灣核心-公司行號（TW Core Organization Company）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-co-twcore.html)
      )
      # This test will use the response from the :organization request in the
      # previous test
      uses_request :organization

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Organization resource is valid'
      description %(
        Verify that the Organization resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-機構（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-twcore.html)

        [臺灣核心-政府機構（TW Core Organization Government）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-govt-twcore.html)

        [臺灣核心-醫事機構（TW Core Organization Hospital Department）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-hosp-twcore.html)

        [臺灣核心-公司行號（TW Core Organization Company）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-co-twcore.html)
      )

      input_order :url

      input :organization_resource,
        title: 'Organization Resource',
        default: '''{
          "resourceType" : "Organization",
          "id" : "org-co-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Organization-co-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>公司行號基本資料</b></h3><p><b>機構名稱</b>：莉梓股份有限公司</p><p><b>識別碼型別</b>：Unified Business number<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"CodeSystem-v2-0203.html\">臺灣識別碼類型值集</a>#UBN）</span><br/><b>公司或企業統一編號（official）</b>：06100268 (https://gcis.nat.gov.tw)</p><p><b>機構種類</b>：Non-Healthcare Business or Corporation <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">（ <a href=\"http://hl7.org/fhir/R4/codesystem-organization-type.html\">OrganizationType</a>#bus）</span></p><p><b>聯絡方式</b>：Email<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\"> （ <a href=\"https://hl7.org/fhir/R4/valueset-contact-point-system.html\">ContactPointSystem</a>#email）</span><br/><b>聯絡信箱</b>：litzu@qmail.com</p></div>"
          },
          "identifier" : [{
            "use" : "official",
            "type" : {
              "coding" : [{
                "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/v2-0203",
                "code" : "UBN"
              }]
            },
            "system" : "https://gcis.nat.gov.tw",
            "value" : "06100268"
          }],
          "type" : [{
            "coding" : [{
              "system" : "http://terminology.hl7.org/CodeSystem/organization-type",
              "code" : "bus"
            }]
          }],
          "name" : "莉梓股份有限公司",
          "telecom" : [{
            "system" : "email",
            "value" : "litzu@qmail.com"
          }]
        }'''
      
      output :organization_value
      
      run do 
        assert_valid_json(organization_resource) # For safety
        resource_hash = JSON.parse(organization_resource)
        organization_resource = FHIR::Organization.new(resource_hash)
        # output organization_value: organization_resource
        assert_valid_resource(resource: organization_resource)
        # if resource_is_valid?(resource: organization_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Organization Resource to FHIR Server'
      description %(
        Send a input Organization resource to a FHIR server database.

        [臺灣核心-機構（TW Core Organization）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-twcore.html)

        [臺灣核心-政府機構（TW Core Organization Government）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-govt-twcore.html)

        [臺灣核心-醫事機構（TW Core Organization Hospital Department）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-hosp-twcore.html)

        [臺灣核心-公司行號（TW Core Organization Company）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Organization-co-twcore.html)
      )

      input_order :url

      input :organization_resource,
        title: 'Organization Resource'

      run do 
        resource_hash = JSON.parse(organization_resource)
        response = fhir_create FHIR::Organization.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
