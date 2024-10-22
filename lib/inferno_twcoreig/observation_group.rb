module InfernoTWCoreIG
  class ObservationGroup < Inferno::TestGroup
    title 'Observation(觀察的測量結果) Tests'
    description 'Verify that the server makes Observation resources available'
    id :observation_group

    input_order :url, :observation_id, :observation_category, :observation_code, :observation_performer, :observation_status, :observation_subject, :observation_date, :observation_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有Observation：
    test do
      title '[GET] Server returns valid results for Observation search by _id'
      description %(
        A server SHALL support searching by _id on the Observation resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )

      input :observation_id,
        title: 'Observation _id'

      # Named requests can be used by other tests
      makes_request :observation

      run do
        fhir_search('Observation', params: { _id: observation_id }, name: :observation)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 category 查詢所有Observation：
    test do
      title '[GET] Server returns valid results for Observation search by category'
      description %(
        A server SHALL support searching by category on the Observation resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )

      input :observation_category,
        title: 'Observation category'

      run do
        fhir_search('Observation', params: { category: observation_category })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 code 查詢所有Observation：
    test do
      title '[GET] Server returns valid results for Observation search by code'
      description %(
        A server SHALL support searching by code on the Observation resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )

      input :observation_code,
        title: 'Observation code'

      run do
        fhir_search('Observation', params: { code: observation_code })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 performer 查詢所有Observation：
    test do
      title '[GET] Server returns valid results for Observation search by performer'
      description %(
        A server SHALL support searching by performer on the Observation resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )

      input :observation_performer,
        title: 'Observation performer'

      run do
        fhir_search('Observation', params: { performer: observation_performer })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有Observation：
    test do
      title '[GET] Server returns valid results for Observation search by status'
      description %(
        A server SHALL support searching by status on the Observation resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )

      input :observation_status,
        title: 'Observation status'

      run do
        fhir_search('Observation', params: { status: observation_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有Observation：
    test do
      title '[GET] Server returns valid results for Observation search by subject'
      description %(
        A server SHALL support searching by subject on the Observation resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )

      input :observation_subject,
        title: 'Observation subject'

      run do
        fhir_search('Observation', params: { subject: observation_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 date 查詢所有Observation：
    test do
      title '[GET] Server returns valid results for Observation search by date'
      description %(
        A server SHALL support searching by date on the Observation resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.0.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )

      input :observation_date,
        title: 'Observation date'

      run do
        fhir_search('Observation', params: { date: observation_date })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 Observation resource 是否合規
    test do
      title '[GET] Observation resource is valid'
      description %(
        Verify that the Observation resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )
      # This test will use the response from the :observation request in the
      # previous test
      uses_request :observation

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input Observation resource is valid'
      description %(
        Verify that the Observation resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )
      input :observation_resource,
            title: 'Observation Resource'
      
      output :observation_value
      
      run do 
        assert_valid_json(observation_resource) # For safety
        resource_hash = JSON.parse(observation_resource)
        observation_resource = FHIR::Observation.new(resource_hash)
        # output observation_value: observation_resource
        assert_valid_resource(resource: observation_resource)
        # if resource_is_valid?(resource: observation_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send Observation Resource to FHIR Server'
      description %(
        Send a input Observation resource to a FHIR server database.

        [臺灣核心-實驗室檢驗檢查（TW Core Observation Laboratory Result）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-laboratoryResult-twcore.html)

        [臺灣核心-生命體徵（TW Core Observation Vital Signs）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-vitalSigns-twcore.html)

        [臺灣核心-血壓（TW Core Observation Blood Pressure）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bloodPressure-twcore.html)

        [臺灣核心-身體質量指數（TW Core Observation BMI）](https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition-Observation-bmi-twcore.html)
      )

      input :observation_resource,
            title: 'Observation Resource'

      run do 
        resource_hash = JSON.parse(observation_resource)
        response = fhir_create FHIR::Observation.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
