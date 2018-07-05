*** Settings ***
Resource          API.robot

*** Test Cases ***
CreateInfo
    #创建户号
    CreateHouse    ${projectId}    77    77    77    139    ${houseTypeId}
    ${buildingId}    Get From Dictionary    ${Data}    buildingId
    ${unitId}    Get From Dictionary    ${Data}    unitId
    ${houseId}    Get From Dictionary    ${Data}    houseId
    #创建购房记录
    CreateSaleInfo    123456    18756000002    t-1    ${projectId}    ${buildingId}    ${unitId}
    ...    ${houseId}
    ${customerId}    Get From Dictionary    ${Data}    customerId
    #补充签约信息
    CreateSignInfo    ${customerId}    ${houseId}    ${colorId}

CreateHouseInfo
    #创建多条购房记录
    : FOR    ${i}    IN RANGE    0    10
    \    ${houseNO}    Evaluate    ${houseNO}+1
    \    ${mobile}    Evaluate    ${mobile}+1
    \    #创建户号
    \    CreateHouse    ${projectId}    ${buildingName}    ${unitName}    ${houseNO}    139
    \    ...    ${houseTypeId}
    \    ${buildingId}    Get From Dictionary    ${Data}    buildingId
    \    ${unitId}    Get From Dictionary    ${Data}    unitId
    \    ${houseId}    Get From Dictionary    ${Data}    houseId
    \    #创建购房记录
    \    CreateSaleInfo    JR-${buildingName}-${unitName}-${houseNO}    ${mobile}    用户姓名${i}    ${projectId}    ${buildingId}
    \    ...    ${unitId}    ${houseId}
    \    ${customerId}    Get From Dictionary    ${Data}    customerId
    \    #补充签约信息
    \    CreateSignInfo    ${customerId}    ${houseId}    ${colorId}
