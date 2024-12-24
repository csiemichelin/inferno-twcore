module InfernoTWCoreIG
  class ImagingStudyGroup < Inferno::TestGroup
    title 'ImagingStudy(影像檢查) Tests'
    description 'Verify that the server makes ImagingStudy resources available'
    id :imagingStudy_group

    input_order :url, :imagingStudy_id, :imagingStudy_status, :imagingStudy_subject, :imagingStudy_encounter, :imagingStudy_started, :imagingStudy_resource

    # 建議應該（SHOULD） 支援透過查詢參數 _id 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by _id'
      description %(
        A server SHALL support searching by _id on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )

      input_order :url

      input :imagingStudy_id,
        title: 'ImagingStudy _id',
        default: '15835'

      # Named requests can be used by other tests
      makes_request :imagingStudy

      run do
        fhir_search('ImagingStudy', params: { _id: imagingStudy_id }, name: :imagingStudy)

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 status 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by status'
      description %(
        A server SHALL support searching by status on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )

      input_order :url

      input :imagingStudy_status,
        title: 'ImagingStudy status',
        default: 'available'

      run do
        fhir_search('ImagingStudy', params: { 'status': imagingStudy_status })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 subject 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by subject'
      description %(
        A server SHALL support searching by subject on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )

      input_order :url

      input :imagingStudy_subject,
        title: 'ImagingStudy subject',
        default: 'Patient/pat-nsysu-hd-001'

      run do
        fhir_search('ImagingStudy', params: { subject: imagingStudy_subject })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 encounter 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by encounter'
      description %(
        A server SHALL support searching by encounter on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )

      input_order :url

      input :imagingStudy_encounter,
        title: 'ImagingStudy encounter',
        default: 'Encounter/13427'

      run do
        fhir_search('ImagingStudy', params: { 'encounter': imagingStudy_encounter })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 建議應該（SHOULD） 支援透過查詢參數 started 查詢所有ImagingStudy：
    test do
      title '[GET] Server returns valid results for ImagingStudy search by started'
      description %(
        A server SHALL support searching by started on the ImagingStudy resource. This test will pass if resources are returned and match the search criteria. If none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods return the same number of results. Search by POST is required by the FHIR R4 specification, and these tests interpret search by GET as a requirement of TW Core v0.3.1.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )

      input_order :url

      input :imagingStudy_started,
        title: 'ImagingStudy started',
        default: 'gt2022-07-01'

      run do
        fhir_search('ImagingStudy', params: { 'started': imagingStudy_started })

        assert_response_status(200)
        assert_resource_type('Bundle')
      end
    end

    # 驗證查詢 _id 的 ImagingStudy resource 是否合規
    test do
      title '[GET] ImagingStudy resource is valid'
      description %(
        Verify that the ImagingStudy resource search by _id returned from the server is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )
      # This test will use the response from the :imagingStudy request in the
      # previous test
      uses_request :imagingStudy

      run do
        assert_response_status(200)
        assert_resource_type('Bundle')
        assert_valid_resource
      end
    end

    # 驗證輸入的Resource是否合規
    test do 
      title '[POST] Input ImagingStudy resource is valid'
      description %(
        Verify that the ImagingStudy resource input is a valid FHIR resource.

        * Verifying the HTTP status code of a response.
        
        * Verifying that a string is valid JSON.
        
        * Validating a FHIR Resource.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )

      input_order :url

      input :imagingStudy_resource,
        title: 'ImagingStudy Resource',
        default: '''{
          "resourceType" : "ImagingStudy",
          "id" : "img-example",
          "meta" : {
            "profile" : ["https://twcore.mohw.gov.tw/ig/twcore/StructureDefinition/ImagingStudy-twcore"]
          },
          "text" : {
            "status" : "generated",
            "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h3><b>腹部超音波</b></h3><p><b>狀態</b>：Available <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://hl7.org/fhir/imagingstudy-status\">ImagingStudyStatus</a>#available)</span></p><p><b>識別碼(official)</b>：2ffe0c20-50d8-49df-85f6-6452d1d201b9</p><p><b>檢查開始日期與時間</b>：2022-08-01T19:00:14</p><p><b>病人</b>：<a href=\"Patient-pat-example.html\">Patient/pat-example</a> \"陳加玲\"</p><p><b>就醫事件</b>：<a href=\"Encounter-enc-example.html\">Encounter/enc-example</a> \"就醫資料\"</p><p><b>檢查相關Series的數量</b>：1</p><p><b>檢查相關Instances的數量</b>：1</p><p><b>處置或手術</b>：<a href=\"Procedure-pro-example.html\">Procedure/pro-example</a> \"處置或手術基本資料\"<br/><b>執行的處置或手術代碼</b>：腹部超音波<span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\"> ( <a href=\"CodeSystem-icd-10-pcs-2021-tw.html\">TW2021ICD10PCS</a>#BW40ZZZ)</span></p><blockquote><p><b>系列(series)實例</b>：</p><p><b>DICOM系列實例UID</b>：2.25.88017001449189502323411118737039844242<br/><b>所使用的成像儀器</b>： Ultrasound <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://dicom.nema.org/resources/ontology/DCM\">CID 29 Acquisition Modality</a>#US)</span><br/><b>身體部位</b>：Pectoral region <span style=\"background: LightGoldenRodYellow; margin: 4px; border: 1px solid khaki\">( <a href=\"http://snomed.info/sct\">SNOMED CT</a>#251007)</span><br/><b>檢查執行者</b>：<a href=\"Practitioner-pra-radio-example.html\">Practitioner/pra-radio-example</a> \"王曉明\"</p><blockquote><p></p><p><b>SOP實例</b>：</p><b>UID</b>：2.25.284548087604447302186649612333159050027<br/><b>DICOM class 類型</b>： urn:oid:1.2.840.10008.5.1.4.1.1.3.1<p></p></blockquote></blockquote></div>"
          },
          "identifier" : [{
            "use" : "official",
            "type" : {
              "coding" : [{
                "system" : "http://terminology.hl7.org/CodeSystem/v2-0203",
                "code" : "ACSN",
                "display" : "Accession ID"
              }]
            },
            "system" : "http://www.moi.gov.tw",
            "value" : "2ffe0c20-50d8-49df-85f6-6452d1d201b9"
          }],
          "status" : "available",
          "subject" : {
            "reference" : "Patient/pat-nsysu-hd-001"
          },
          "encounter" : {
            "reference" : "Encounter/13427"
          },
          "started" : "2022-08-01T19:00:14+08:00",
          "numberOfSeries" : 1,
          "numberOfInstances" : 1,
          "procedureReference" : {
            "reference" : "Procedure/13174"
          },
          "series" : [{
            "uid" : "2.25.88017001449189502323411118737039844242",
            "modality" : {
              "system" : "http://dicom.nema.org/resources/ontology/DCM",
              "code" : "US"
            },
            "bodySite" : {
              "system" : "http://snomed.info/sct",
              "code" : "251007",
              "display" : "Pectoral region"
            },
            "performer" : [{
              "actor" : {
                "reference" : "Practitioner/1004"
              }
            }],
            "instance" : [{
              "uid" : "2.25.284548087604447302186649612333159050027",
              "sopClass" : {
                "system" : "urn:ietf:rfc:3986",
                "code" : "urn:oid:1.2.840.10008.5.1.4.1.1.3.1"
              }
            }]
          }]
        }'''
      
      output :imagingStudy_value
      
      run do 
        assert_valid_json(imagingStudy_resource) # For safety
        resource_hash = JSON.parse(imagingStudy_resource)
        imagingStudy_resource = FHIR::ImagingStudy.new(resource_hash)
        # output imagingStudy_value: imagingStudy_resource
        assert_valid_resource(resource: imagingStudy_resource)
        # if resource_is_valid?(resource: imagingStudy_resource)
        # end
      end 
    end 

    # 發送POST請求包含Resource Body給FHIR Server
    test do 
      title '[POST] Send ImagingStudy Resource to FHIR Server'
      description %(
        Send a input ImagingStudy resource to a FHIR server database.

        [臺灣核心-影像檢查（TW Core ImagingStudy）](https://twcore.mohw.gov.tw/ig/twcore/0.2.1/StructureDefinition-ImagingStudy-twcore.html)
      )

      input_order :url
      
      input :imagingStudy_resource,
        title: 'ImagingStudy Resource'

      run do 
        resource_hash = JSON.parse(imagingStudy_resource)
        response = fhir_create FHIR::ImagingStudy.new(resource_hash)
        assert response.status == 201
      end
    end
  end
end
