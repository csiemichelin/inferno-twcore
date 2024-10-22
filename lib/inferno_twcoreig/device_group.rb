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

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-植入式裝置（TW Core Implantable Device）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Device-twcore.html)
      )

      input :device_patient,
        title: 'Device patient'

      # Named requests can be used by other tests
      makes_request :device

      run do
        fhir_search('Device', params: { 'patient': device_patient }, name: :device)

        assert_response_status(200)
        assert_resource_type('Device')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 type 查詢所有Device：
    test do
      title '[GET] Server returns valid results for Device search by patient and type'
      description %(
        A server SHALL support searching by patient and type on the Device resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-植入式裝置（TW Core Implantable Device）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Device-twcore.html)
      )

      input :device_patient,
        title: 'Device patient'
      
      input :device_type,
        title: 'Device type'
    
      run do
        fhir_search('Device', params: { 'patient': device_patient, 'type': device_type })

        assert_response_status(200)
        assert_resource_type('Device')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 patient 及 status 查詢所有Device：
    test do
      title '[GET] Server returns valid results for Device search by patient and status'
      description %(
        A server SHALL support searching by patient and status on the Device resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        [臺灣核心-植入式裝置（TW Core Implantable Device）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Device-twcore.html)
      )

      input :device_patient,
        title: 'Device patient'
      
      input :device_status,
        title: 'Device status'

      run do
        fhir_search('Device', params: { 'patient': device_patient, 'status': device_status })

        assert_response_status(200)
        assert_resource_type('Device')
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
        assert_resource_type('Device')
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
      input :device_resource,
        title: 'Device Resource'
      
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
  