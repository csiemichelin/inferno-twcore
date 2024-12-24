module InfernoTWCoreIG
  class RelatedPersonGroup < Inferno::TestGroup
    title 'RelatedPerson(相關人士) Tests'
    description 'Verify that the server makes RelatedPerson resources available'
    id :relatedPerson_group

    input_order :url, :relatedPerson_id, :relatedPerson_patient, :relatedPerson_name, :relatedPerson_resource

    # 必須（SHALL） 支援透過查詢參數 _id 查詢所有RelatedPerson：
    test do
      title '[GET] Server returns valid results for RelatedPerson search by _id'
      description %(
        A server SHALL support searching by _id on the RelatedPerson resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_id,
        title: 'RelatedPerson _id',
        default: '15928'

      # Named requests can be used by other tests
      makes_request :relatedPerson

      run do
        fhir_search('RelatedPerson', params: { '_id': relatedPerson_id }, name: :relatedPerson)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 查詢所有RelatedPerson：
    test do
      title '[GET] Server returns valid results for RelatedPerson search by patient'
      description %(
        A server SHALL support searching by patient on the RelatedPerson resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_patient,
        title: 'RelatedPerson patient',
        default: 'Patient/pat-nsysu-hd-001'

      # Named requests can be used by other tests
      makes_request :relatedPerson

      run do
        fhir_search('RelatedPerson', params: { 'patient': relatedPerson_patient }, name: :relatedPerson)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 name 查詢所有RelatedPerson：
    test do
      title '[GET] Server returns valid results for RelatedPerson search by patient and name'
      description %(
        A server SHALL support searching by patient and name on the RelatedPerson resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_patient,
        title: 'RelatedPerson patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :relatedPerson_name,
        title: 'RelatedPerson name',
        default: '陳簡伊'

      run do
        fhir_search('RelatedPerson', params: { 'patient': relatedPerson_patient, 'name': relatedPerson_name })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 RelatedPerson resource 是否合規
    test do
      title '[GET] RelatedPerson resource is valid'
      description %(
        Verify that the RelatedPerson resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )
      
      # This test will use the response from the :relatedPerson request in the
      # previous test
      uses_request :relatedPerson

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input RelatedPerson resource is valid'
      description %(
        Verify that the RelatedPerson resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_resource,
        title: 'RelatedPerson Resource',
        default: '''{
          "resourceType" : "RelatedPerson",
          "id" : "rel-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/RelatedPerson-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p class=\"res-header-id\"><b>Generated Narrative: RelatedPerson rel-example</b></p><a name=\"rel-example\"> </a><a name=\"hcrel-example\"> </a><a name=\"rel-example-en-US\"> </a><p><b>active</b>: true</p><p><b>patient</b>: <a href=\"Patient-pat-example.html\">陳加玲(official) Female, DoB: 1990-01-01 ( Medical record number\u00a0(use:\u00a0official,\u00a0))</a></p><p><b>relationship</b>: <span title=\"Codes:{http://terminology.hl7.org/CodeSystem/v3-RoleCode NIECE}\">niece</span></p><p><b>name</b>: 陳簡伊(Official)</p><p><b>telecom</b>: ph: 0911595995(Mobile)</p><p><b>birthDate</b>: 1996-01-28</p><p><b>address</b>: 臺北市大同區大有里19鄰承德路三段52巷6弄210號2樓C室</p></div>"
          },
          "active" : true,
          "patient" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          },
          "relationship" : [{
            "coding" : [{
              "system" : "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
              "code" : "NIECE",
              "display" : "niece"
            }]
          }],
          "name" : [{
            "use" : "official",
            "text" : "陳簡伊",
            "family" : "Chen",
            "given" : ["Jian Yi"]
          }],
          "telecom" : [{
            "system" : "phone",
            "value" : "0911595995",
            "use" : "mobile"
          }],
          "birthDate" : "1996-01-28",
          "address" : [{
            "extension" : [{
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-section",
              "valueString" : "三段"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-number",
              "valueString" : "210號"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-village",
              "valueString" : "大有里"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-neighborhood",
              "valueString" : "19鄰"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-lane",
              "valueString" : "52巷"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-alley",
              "valueString" : "6弄"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-floor",
              "valueString" : "2樓"
            },
            {
              "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-room",
              "valueString" : "C室"
            }],
            "text" : "臺北市大同區大有里19鄰承德路三段52巷6弄210號2樓C室",
            "line" : ["承德路"],
            "city" : "臺北市",
            "district" : "大同區",
            "_postalCode" : {
              "extension" : [{
                "url" : "https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/tw-postal-code",
                "valueCodeableConcept" : {
                  "coding" : [{
                    "system" : "https://twcore.mohw.gov.tw/ig/twcore/CodeSystem/postal-code3-tw",
                    "code" : "103"
                  }]
                }
              }]
            },
            "country" : "TW"
          }]
        }'''
      
      output :relatedPerson_value
      
      run do 
        assert_valid_json(relatedPerson_resource) # For safety
        resource_hash = JSON.parse(relatedPerson_resource)
        relatedPerson_resource = FHIR::RelatedPerson.new(resource_hash)
        # output relatedPerson_value: relatedPerson_resource
        assert_valid_resource(resource: relatedPerson_resource)
        # if resource_is_valid?(resource: relatedPerson_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction RelatedPersons(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send RelatedPerson Resource to FHIR Server'
      description %(
        Send a input Transaction RelatedPerson(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-相關人士（TW Core RelatedPerson）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-RelatedPerson-twcore.html)
      )

      input_order :url

      input :relatedPerson_resource,
        title: 'RelatedPerson Resource'

      run do 
        resource_hash = JSON.parse(relatedPerson_resource)
        response = fhir_create FHIR::RelatedPerson.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  