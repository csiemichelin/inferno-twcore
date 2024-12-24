module InfernoTWCoreIG
  class LocationGroup < Inferno::TestGroup
    title 'Location(地點) Tests'
    description 'Verify that the server makes Location resources available'
    id :location_group

    input_order :url, :location_id, :location_address, :location_name, :location_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Location：
    test do
      title '[GET] Server returns valid results for Location search by _id'
      description %(
        A server SHALL support searching by _id on the Location resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_id,
        title: 'Location _id',
        default: '13190'

      # Named requests can be used by other tests
      makes_request :location

      run do
        fhir_search('Location', params: { _id: location_id }, name: :location)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 address 查詢所有Location：
    test do
      title '[GET] Server returns valid results for Location search by address'
      description %(
        A server SHALL support searching by address on the Location resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_address,
        title: 'Location address',
        default: '新北市'

      run do
        fhir_search('Location', params: { address: location_address })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 name 查詢所有Location：
    test do
      title '[GET] Server returns valid results for Location search by name'
      description %(
        A server SHALL support searching by name on the Location resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_name,
        title: 'Location name',
        default: '衛生福利部臺北醫院急診室'

      run do
        fhir_search('Location', params: { name: location_name })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Location resource 是否合規
    test do
      title '[GET] Location resource is valid'
      description %(
        Verify that the Location resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )
      # This test will use the response from the :location request in the
      # previous test
      uses_request :location

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Location resource is valid'
      description %(
        Verify that the Location resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_resource,
        title: 'Location Resource',
        default: '''{
          "resourceType" : "Location",
          "id" : "loc-ent-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Location-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>衛生福利部臺北醫院耳鼻喉科</b></h3><p><b>地點狀態</b>: Active <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/R4/codesystem-location-status.html\">LocationStatus</a>#active)</span></p><p><b>地點類別</b>: Kind <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/R4/valueset-location-mode.html\">LocationMode</a>#kind)</span></p><p><b>地點類型</b>: Otorhinolaryngology clinic <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"https://terminology.hl7.org/CodeSystem-v3-RoleCode.html\">RoleCode</a>#ENT)</span></p><p><b>地點資訊</b>: 診治各種耳、鼻、咽、喉等上呼吸道疾病及頭頸部腫瘤 , 包括 : 感冒、咳嗽、頭痛、喉嚨痛、聲音沙啞、吞嚥困難、呼吸不順、鼻塞、鼻竇炎、鼻過敏、鼻息肉、扁桃腺肥大、耳鳴、耳痛、中耳炎、顏面神經麻痺、顎顳關節痛、口乾舌燥、打鼾、語言障礙、食道異物取出、頭頸部腫瘤、舌及口咽腫瘤手術。</p><p><b>負責維護地點的機構</b>: <a href=\"Organization-org-hosp-example.html\">Organization/org-hosp-example</a> \"衛生福利部臺北醫院\"</p><p><b>聯絡方式</b>：Phone<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\"> （ <a href=\"https://hl7.org/fhir/R4/valueset-contact-point-system.html\">ContactPointSystem</a>#phone）</span><br/></p><p><b>聯絡電話（work）</b>：02-2276-5566</p><p><b>聯絡地址（work）</b>：242新北市新莊區思源路127號</p><p><b>地點開放時間</b>：週一 ～ 週五 ， 全天</p></div>"
          },
          "status" : "active",
          "name" : "衛生福利部臺北醫院耳鼻喉科",
          "description" : "診治各種耳、鼻、咽、喉等上呼吸道疾病及頭頸部腫瘤 , 包括 : 感冒、咳嗽、頭痛、喉嚨痛、聲音沙啞、吞嚥困難、呼吸不順、鼻塞、鼻竇炎、鼻過敏、鼻息肉、扁桃腺肥大、耳鳴、耳痛、中耳炎、顏面神經麻痺、顎顳關節痛、口乾舌燥、打鼾、語言障礙、食道異物取出、頭頸部腫瘤、舌及口咽腫瘤手術",
          "mode" : "kind",
          "type" : [{
            "coding" : [{
              "system" : "http://terminology.hl7.org/CodeSystem/v3-RoleCode",
              "code" : "ENT",
              "display" : "Otorhinolaryngology clinic"
            }]
          }],
          "telecom" : [{
            "system" : "phone",
            "value" : "02-2276-5566",
            "use" : "work"
          }],
          "address" : {
            "use" : "work",
            "type" : "both",
            "text" : "242新北市新莊區思源路127號",
            "line" : ["思源路127號"],
            "city" : "新莊區",
            "district" : "新北市",
            "postalCode" : "242"
          },
          "position" : {
            "longitude" : 25.043085494729105,
            "latitude" : 121.45941895179722
          },
          "managingOrganization" : {
            "reference" : "Organization/org-nsysu"
          },
          "hoursOfOperation" : [{
            "daysOfWeek" : ["mon",
            "tue",
            "wed",
            "thu",
            "fri"],
            "allDay" : true
          }]
        }'''
      
      output :location_value
      
      run do 
        assert_valid_json(location_resource) # For safety
        resource_hash = JSON.parse(location_resource)
        location_resource = FHIR::Location.new(resource_hash)
        # output location_value: location_resource
        assert_valid_resource(resource: location_resource)
        # if resource_is_valid?(resource: location_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Location Resource to FHIR Server'
      description %(
        Send a input Location resource to a FHIR server database.

        [臺灣核心-地點（TW Core Location）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-Location-twcore.html)
      )

      input_order :url

      input :location_resource,
        title: 'Location Resource'

      run do 
        resource_hash = JSON.parse(location_resource)
        response = fhir_create FHIR::Location.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
