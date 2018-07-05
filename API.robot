*** Settings ***
Library           RequestsLibrary
Library           requests
Library           Collections
Library           json

*** Variables ***
${url}            http://106.15.80.34:9001
${Data}           ${EMPTY}
${projectId}      1378279915880801    # 项目id
${houseTypeId}    1378280457568736    # 户型id
${colorId}        1380325487174752    # 色系id
${buildingName}    15    # 楼栋
${unitName}       1    # 单元
${houseNO}        100    # 户号
${mobile}         17652200000    # 手机号

*** Keywords ***
CreateHouse
    [Arguments]    ${projectId}    ${buildingName}    ${unitName}    ${houseNO}    ${area}    ${houseTypeId}
    ...    # 项目id|楼栋号|单元号|室号|面积|对应户型
    log    API：创建户号
    ${header}    Create Dictionary    Content-Type    application/json
    ${requestBody}    Create Dictionary    projectId=${projectId}    buildingName=${buildingName}    unitName=${unitName}    houseNO=${houseNO}    area=${area}
    ...    houseTypeId=${houseTypeId}
    Create Session    apiUrl    ${url}
    ${responses}    Post Request    apiUrl    /api/house    ${requestBody}    headers=${header}
    Should Be Equal As Strings    ${responses.status_code}    200
    log    ${responses.content}
    ${respjson}    To Json    ${responses.content}
    ${data}    Get From Dictionary    ${respjson}    data
    Set Suite Variable    ${Data}    ${data}

CreateSaleInfo
    [Arguments]    ${saleCode}    ${mobile}    ${customerName}    ${projectId}    ${buildingId}    ${unitId}
    ...    ${houseId}    # 销售单编号|手机号码|用户姓名|项目id|楼栋id|单元id|室号id
    log    API：创建购房记录
    ${header}    Create Dictionary    Content-Type    application/json
    ${requestBody}    Create Dictionary    saleCode=${saleCode}    mobile=${mobile}    customerName=${customerName}    projectId=${projectId}    buildingId=${buildingId}
    ...    unitId=${unitId}    houseId=${houseId}    signDate=1530759599257
    Create Session    apiUrl    ${url}
    ${responses}    Post Request    apiUrl    /api/proj/project/customerHouseSale?pageIndex=-1    ${requestBody}    headers=${header}
    Should Be Equal As Strings    ${responses.status_code}    200
    log    ${responses.content}
    ${respjson}    To Json    ${responses.content}
    ${data}    Get From Dictionary    ${respjson}    data
    Set Suite Variable    ${Data}    ${data}

CreateSignInfo
    [Arguments]    ${customerId}    ${houseId}    ${colorId}    # 用户id|房id|色系id
    log    API：补充签约信息
    ${header}    Create Dictionary    Content-Type    application/json
    ${requestBody}    Create Dictionary    colorId=${colorId}
    Create Session    apiUrl    ${url}
    ${responses}    Put Request    apiUrl    /api/project/customerHouseSale?customerId=${customerId}&houseId=${houseId}    ${requestBody}    headers=${header}
    Should Be Equal As Strings    ${responses.status_code}    200
    log    ${responses.content}
    ${respjson}    To Json    ${responses.content}
    ${data}    Get From Dictionary    ${respjson}    data
    Set Suite Variable    ${Data}    ${data}
