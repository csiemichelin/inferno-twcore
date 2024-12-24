module InfernoTWCoreIG
  class DeviceGroup < Inferno::TestGroup
    title 'Device(植入式裝置) Tests'
    description 'Verify that the server makes Device resources available'
    id :device_group

    input_order :url, :device_patient, :device_type, :device_status, :device_resource

    # 必須（SHALL） 支援透過查詢參數 patient 查詢所有Device：
    test do
      title '[GET] Server returns valid results for Device search by patient'
      description %(
        A server SHALL support searching by patient on the Device resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-植入式裝置（TW Core Implantable Device）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Device-twcore.html)
      )

      input_order :url

      input :device_patient,
        title: 'Device patient',
        default: 'Patient/pat-nsysu-hd-001'

      # Named requests can be used by other tests
      makes_request :device

      run do
        fhir_search('Device', params: { 'patient': device_patient }, name: :device)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 type 查詢所有Device：
    test do
      title '[GET] Server returns valid results for Device search by patient and type'
      description %(
        A server SHALL support searching by patient and type on the Device resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-植入式裝置（TW Core Implantable Device）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Device-twcore.html)
      )

      input_order :url

      input :device_patient,
        title: 'Device patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :device_type,
        title: 'Device type',
        default: '468063009'
    
      run do
        fhir_search('Device', params: { 'patient': device_patient, 'type': device_type })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 status 查詢所有Device：
    test do
      title '[GET] Server returns valid results for Device search by patient and status'
      description %(
        A server SHALL support searching by patient and status on the Device resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-植入式裝置（TW Core Implantable Device）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Device-twcore.html)
      )

      input_order :url

      input :device_patient,
        title: 'Device patient',
        default: 'Patient/pat-nsysu-hd-001'
      
      input :device_status,
        title: 'Device status',
        default: 'active'

      run do
        fhir_search('Device', params: { 'patient': device_patient, 'status': device_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 patient 的 Device resource 是否合規
    test do
      title '[GET] Device resource is valid'
      description %(
        Verify that the Device resource search by patient returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-植入式裝置（TW Core Implantable Device）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Device-twcore.html)
      )
      # This test will use the response from the :device request in the
      # previous test
      uses_request :device

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Device resource is valid'
      description %(
        Verify that the Device resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-植入式裝置（TW Core Implantable Device）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Device-twcore.html)
      )

      input_order :url

      input :device_resource,
        title: 'Device Resource',
        default: '''{
          "resourceType" : "Device",
          "id" : "dev-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/Device-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p class=\"res-header-id\"><b>Generated Narrative: Device dev-example</b></p><a name=\"dev-example\"> </a><a name=\"hcdev-example\"> </a><a name=\"dev-example-en-US\"> </a><h3>UdiCarriers</h3><table class=\"grid\"><tr><td style=\"display: none\">-</td><td><b>DeviceIdentifier</b></td><td><b>CarrierHRF</b></td></tr><tr><td style=\"display: none\">*</td><td>09504000059118</td><td>(01)09504000059118(17)141120(10)7654321D(21)10987654d321</td></tr></table><p><b>status</b>: Active</p><p><b>expirationDate</b>: 2014-11-20</p><p><b>lotNumber</b>: 7654321D</p><p><b>serialNumber</b>: 10987654d321</p><p><b>type</b>: <span title=\"Codes:{http://snomed.info/sct 468063009}\">Coated femoral stem prosthesis, modular</span></p><p><b>patient</b>: <a href=\"Patient-pat-example.html\">陳加玲(official) Female, DoB: 1990-01-01 ( Medical record number\u00a0(use:\u00a0official,\u00a0))</a></p></div>"
          },
          "udiCarrier" : [{
            "deviceIdentifier" : "09504000059118",
            "carrierHRF" : "(01)09504000059118(17)141120(10)7654321D(21)10987654d321"
          }],
          "status" : "active",
          "expirationDate" : "2014-11-20",
          "lotNumber" : "7654321D",
          "serialNumber" : "10987654d321",
          "type" : {
            "coding" : [{
              "system" : "http://snomed.info/sct",
              "version" : "http://snomed.info/sct/731000124108",
              "code" : "468063009",
              "display" : "Coated femoral stem prosthesis, modular"
            }]
          },
          "patient" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          }
        }'''
      
      output :device_value
      
      run do 
        assert_valid_json(device_resource) # For safety
        resource_hash = JSON.parse(device_resource)
        device_resource = FHIR::Device.new(resource_hash)
        # output device_value: device_resource
        assert_valid_resource(resource: device_resource)
        # if resource_is_valid?(resource: device_resource)
        # end
      end 
    end 

    # 發送POST請求包含Transaction Devices(支援多個Resource驗證)的Body給FHIR Server
    test do 
      title '[POST] Send Device Resource to FHIR Server'
      description %(
        Send a input Transaction Device(Support multiple Resource verification) to a FHIR server database.

        [臺灣核心-植入式裝置（TW Core Implantable Device）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Device-twcore.html)
      )

      input_order :url

      input :device_resource,
        title: 'Device Resource'

      run do 
        resource_hash = JSON.parse(device_resource)
        response = fhir_create FHIR::Device.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
  