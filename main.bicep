// resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
//   name: uniqueString(resourceGroup().id)
//   location: 'eastus'
//   kind: 'Storage'
//   sku: {
//     name: 'Standard_LRS'
//   }
// }

param location string = resourceGroup().location

@minLength(3)
@maxLength(24)
@description('Provide a name for the storage account. Use only lower case letters and numbers. The name must be unique across Azure.')
param storageAccountName string = 'store${uniqueString(resourceGroup().id)}'


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-06-01' = {
  name: 'exampleVnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'Subnet-2'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

resource exampleStorage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}