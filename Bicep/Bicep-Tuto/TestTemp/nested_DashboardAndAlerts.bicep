param NetworkWatcherName string
param actiongroupsId string
param ConnectionMonitorName string
param Dashboard_name string
param DashboardTitle string
param endpoints array
param metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Primary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Primary_File_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Secondary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Secondary_File_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Primary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Primary_File_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Secondary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Secondary_File_Service_name string
param metricalerts_DSS_Network_Availability_from_OP_Datalake_Primary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_OP_Datalake_Primary_File_Service_name string
param metricAlerts_DSS_Network_Availability_from_OP_Datalake_Secondary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_OP_Datalake_Secondary_File_Service_name string
param metricalerts_DSS_Network_Availability_From_CTH_Datalake_Primary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Primary_File_Service_name string
param metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Secondary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Secondary_File_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Primary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Primary_File_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Secondary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Secondary_File_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Primary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Primary_File_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Secondary_Blob_Service_name string
param metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Secondary_File_Service_name string

var networkWatcherId = '${subscription().id}/resourceGroups/networkwatcherrg/providers/Microsoft.Network/networkWatchers/${NetworkWatcherName}'
var NetworkwatcherResourceID = '${networkWatcherId}/connectionMonitors/${ConnectionMonitorName}'

resource metricalerts_DSS_Network_Availability_from_CTH_Datalake_Primary_Blob_Service_name_resource 'microsoft.insights/metricalerts@2018-03-01' = {
  name: metricalerts_DSS_Network_Availability_From_CTH_Datalake_Primary_Blob_Service_name
  location: 'global'
  properties: {
    description: 'Connectivity to Datalake Primary Blob Service From Cortech Hub environment is deggraded'
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[2].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[11].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Primary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Primary_Blob_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[5].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[7].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Primary Blob Service from tncdatavmopdg01 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Primary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Primary_File_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[5].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[8].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Primary File Service from tncdatavmopdg01 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Secondary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Secondary_Blob_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[5].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[9].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Secondary Blob Service from tncdatavmopdg01 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Secondary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Secondary_File_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[5].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[10].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Secondary File Service from tncdatavmopdg01 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Primary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Primary_Blob_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[6].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[7].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Primary Blob Service from tncdatavmopdg02 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Primary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Primary_File_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[6].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[8].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Primary File Service from tncdatavmopdg02 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Secondary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Secondary_Blob_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[6].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[9].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Secondary Blob Service from tncdatavmopdg02 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Secondary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Secondary_File_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[6].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[10].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Secondary File Service from tncdatavmopdg02 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Primary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Primary_Blob_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[3].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[7].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Primary Blob Service from tncdatavmir01 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Primary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Primary_File_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[3].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[8].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Primary File Service from tncdatavmir01 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Secondary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Secondary_Blob_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[3].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[9].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Secondary Blob Service from tncdatavmir01 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Secondary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Secondary_File_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[3].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[10].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Secondary File Service from tncdatavmir01 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Primary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Primary_Blob_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[4].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[7].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Primary Blob Service from tncdatavmir02 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Primary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Primary_File_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[4].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[8].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Primary File Service from tncdatavmir02 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Secondary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Secondary_Blob_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[4].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[9].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Secondary Blob Service from tncdatavmir01 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Secondary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Secondary_File_Service_name
  location: 'global'
  properties: {
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[4].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[10].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
    description: 'Connectivity to Datalake Secondary File Service from tncdatavmir02 Azure VM is deggraded'
  }
}

resource metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Primary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Primary_File_Service_name
  location: 'global'
  properties: {
    description: 'Connectivity to Datalake Primary File Service From Cortech Hub environment is deggraded'
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[2].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[12].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Secondary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Secondary_Blob_Service_name
  location: 'global'
  properties: {
    description: 'Connectivity to Datalake Secondary Blob Service From Cortech Hub environment is deggraded'
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[2].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[13].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Secondary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Secondary_File_Service_name
  location: 'global'
  properties: {
    description: 'Connectivity to Datalake Secondary File Service From Cortech Hub environment is deggraded'
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[2].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[14].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
  }
}

resource metricalerts_DSS_Network_Availability_from_OP_Datalake_Primary_Blob_Service_name_resource 'microsoft.insights/metricalerts@2018-03-01' = {
  name: metricalerts_DSS_Network_Availability_from_OP_Datalake_Primary_Blob_Service_name
  location: 'global'
  properties: {
    description: 'connectivity to datalake primary blob service from OP is deggraded'
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[0].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[7].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_DSS_Network_Availability_from_OP_Datalake_Primary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_OP_Datalake_Primary_File_Service_name
  location: 'global'
  properties: {
    description: 'Connectivity to Datalake Primary File Service from on-premises environment is deggraded'
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceAddress'
              operator: 'Include'
              values: [
                endpoints[0].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[8].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_DSS_Network_Availability_from_OP_Datalake_Secondary_Blob_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_OP_Datalake_Secondary_Blob_Service_name
  location: 'global'
  properties: {
    description: 'Connectivity to Datalake Secondary Blob Service from on-premises environment is deggraded'
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[0].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[9].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_DSS_Network_Availability_from_OP_Datalake_Secondary_File_Service_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_DSS_Network_Availability_from_OP_Datalake_Secondary_File_Service_name
  location: 'global'
  properties: {
    description: 'Connectivity to Datalake Secondary File Service from on-premises environment is deggraded'
    severity: 1
    enabled: true
    scopes: [
      NetworkwatcherResourceID
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      allOf: [
        {
          threshold: 5
          name: 'Metric1'
          metricNamespace: 'Microsoft.Network/networkWatchers/connectionMonitors'
          metricName: 'ChecksFailedPercent'
          dimensions: [
            {
              name: 'SourceName'
              operator: 'Include'
              values: [
                endpoints[0].name
              ]
            }
            {
              name: 'DestinationAddress'
              operator: 'Include'
              values: [
                endpoints[10].address
              ]
            }
          ]
          operator: 'GreaterThan'
          timeAggregation: 'Count'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
    autoMitigate: true
    targetResourceType: 'Microsoft.Network/networkWatchers/connectionMonitors'
    targetResourceRegion: 'westeurope'
    actions: [
      {
        actionGroupId: actiongroupsId
        webHookProperties: {}
      }
    ]
  }
}

resource Dashboard_name_resource 'Microsoft.Portal/dashboards@2015-08-01-preview' = {
  name: Dashboard_name
  location: resourceGroup().location
  tags: {
    'hidden-title': DashboardTitle
  }
  properties: {
    lenses: {
      '0': {
        order: 0
        parts: {
          '0': {
            position: {
              x: 0
              y: 0
              colSpan: 20
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<p style="color: cyan; font-size: 32px;text-align: center"> DATABOX SERVICE MONITORING DASHBOARD </p>'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '1': {
            position: {
              x: 0
              y: 1
              colSpan: 20
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<p style="color: DarkKhaki; font-size: 30px;text-align: center;font-family:verdana;"> ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: AVAILABILTY :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::</p>'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '2': {
            position: {
              x: 0
              y: 2
              colSpan: 4
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<h1 style="color: DarkTurquoise; font-size: 17px;text-align: center;font-family: verdana; "> DSS Datalake Availability'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '3': {
            position: {
              x: 4
              y: 2
              colSpan: 4
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<h1 style="color: DarkTurquoise; font-size: 17px;text-align: center;font-family: verdana; "> DSS Datalake Availability From On-Prem'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '4': {
            position: {
              x: 8
              y: 2
              colSpan: 4
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<h1 style="color: DarkTurquoise; font-size: 17px;text-align: center;font-family: verdana; "> DSS Datalake Availability From CT Hub'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '5': {
            position: {
              x: 12
              y: 2
              colSpan: 4
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<h1 style="color: DarkTurquoise; font-size: 17px;text-align: center;font-family: verdana; "> DSS Datalake Availability From AZ IRs'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '6': {
            position: {
              x: 16
              y: 2
              colSpan: 4
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<h1 style="color: DarkTurquoise; font-size: 16px;text-align: center;font-family: verdana; "> DSS Datalake Availability From AZ OPDGs'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '7': {
            position: {
              x: 0
              y: 3
              colSpan: 4
              rowSpan: 2
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  value: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: '/subscriptions/fd86fab0-733c-424b-9ca3-1842ce15e716/resourceGroups/tnc-data-prd-we/providers/Microsoft.Storage/storageAccounts/aldtncdataprdwedatalake'
                          }
                          name: 'Availability'
                          aggregationType: 4
                          namespace: 'microsoft.storage/storageaccounts'
                          metricVisualization: {
                            displayName: 'Availability'
                          }
                        }
                      ]
                      title: 'DSS DataLake Availability'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                      }
                      timespan: {
                        relative: {
                          duration: 1800000
                        }
                        showUTCTime: false
                        grain: 7
                      }
                    }
                  }
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: '/subscriptions/fd86fab0-733c-424b-9ca3-1842ce15e716/resourceGroups/tnc-data-prd-we/providers/Microsoft.Storage/storageAccounts/aldtncdataprdwedatalake'
                          }
                          name: 'Availability'
                          aggregationType: 4
                          namespace: 'microsoft.storage/storageaccounts'
                          metricVisualization: {
                            displayName: 'Availability'
                          }
                        }
                      ]
                      title: 'DSS DataLake Availability'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
              filters: {
                MsPortalFx_TimeRange: {
                  model: {
                    format: 'local'
                    granularity: '5m'
                    relative: '30m'
                  }
                }
              }
            }
          }
          '8': {
            position: {
              x: 4
              y: 3
              colSpan: 4
              rowSpan: 2
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  value: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('networkwatcherrg', 'Microsoft.Network/networkWatchers/connectionMonitors', 'networkwatcher_westeurope', ConnectionMonitorName)
                          }
                          name: 'ChecksFailedPercent'
                          aggregationType: 4
                          metricVisualization: {
                            resourceDisplayName: 'networkwatcher_westeurope/${ConnectionMonitorName}'
                          }
                        }
                      ]
                      title: 'Checks failed (%)'
                      titleKind: 2
                      filterCollection: {
                        filters: [
                          {
                            key: 'TestGroupName'
                            operator: 0
                            values: [
                              'DSS Network Availability From OP'
                            ]
                          }
                        ]
                      }
                      visualization: {
                        chartType: 2
                      }
                      openBladeOnClick: {
                        openBlade: true
                      }
                    }
                  }
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('networkwatcherrg', 'Microsoft.Network/networkWatchers/connectionMonitors', 'networkwatcher_westeurope', ConnectionMonitorName)
                          }
                          name: 'ChecksFailedPercent'
                          aggregationType: 4
                          namespace: 'microsoft.network/networkwatchers/connectionmonitors'
                          metricVisualization: {
                            displayName: 'Checks Failed Percent (Preview)'
                            resourceDisplayName: 'networkwatcher_westeurope/${ConnectionMonitorName}'
                          }
                        }
                      ]
                      title: 'On-Prem Check Failed %'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
              filters: {
                TestGroupName: {
                  model: {
                    operator: 'equals'
                    values: [
                      'DSS Network Availability From OP'
                    ]
                  }
                }
              }
            }
          }
          '9': {
            position: {
              x: 8
              y: 3
              colSpan: 4
              rowSpan: 2
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  value: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('networkwatcherrg', 'Microsoft.Network/networkWatchers/connectionMonitors', 'networkwatcher_westeurope', ConnectionMonitorName)
                          }
                          name: 'ChecksFailedPercent'
                          aggregationType: 4
                          metricVisualization: {
                            displayName: 'Checks Failed Percent (Preview)'
                            resourceDisplayName: 'networkwatcher_westeurope/${ConnectionMonitorName}'
                          }
                        }
                      ]
                      title: 'Checks failed (%)'
                      titleKind: 2
                      filterCollection: {
                        filters: [
                          {
                            key: 'TestGroupName'
                            operator: 0
                            values: [
                              'DSS Network Availability From CTH'
                            ]
                          }
                        ]
                      }
                      visualization: {
                        chartType: 2
                      }
                      openBladeOnClick: {
                        openBlade: true
                      }
                    }
                  }
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('networkwatcherrg', 'Microsoft.Network/networkWatchers/connectionMonitors', 'networkwatcher_westeurope', ConnectionMonitorName)
                          }
                          name: 'ChecksFailedPercent'
                          aggregationType: 4
                          namespace: 'microsoft.network/networkwatchers/connectionmonitors'
                          metricVisualization: {
                            displayName: 'Checks Failed Percent (Preview)'
                            resourceDisplayName: 'networkwatcher_westeurope/${ConnectionMonitorName}'
                          }
                        }
                      ]
                      title: 'CT Hub Check Failed %'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
              filters: {
                TestGroupName: {
                  model: {
                    operator: 'equals'
                    values: [
                      'DSS Network Availability From CTH'
                    ]
                  }
                }
              }
            }
          }
          '10': {
            position: {
              x: 12
              y: 3
              colSpan: 4
              rowSpan: 2
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  value: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('networkwatcherrg', 'Microsoft.Network/networkWatchers/connectionMonitors', 'networkwatcher_westeurope', ConnectionMonitorName)
                          }
                          name: 'ChecksFailedPercent'
                          aggregationType: 4
                          metricVisualization: {
                            displayName: 'Checks Failed Percent (Preview)'
                            resourceDisplayName: 'networkwatcher_westeurope/${ConnectionMonitorName}'
                          }
                        }
                      ]
                      title: 'Checks failed (%)'
                      titleKind: 2
                      filterCollection: {
                        filters: [
                          {
                            key: 'TestGroupName'
                            operator: 0
                            values: [
                              'DSS Network Availability From AZ IRs'
                            ]
                          }
                        ]
                      }
                      visualization: {
                        chartType: 2
                      }
                      openBladeOnClick: {
                        openBlade: true
                      }
                    }
                  }
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('networkwatcherrg', 'Microsoft.Network/networkWatchers/connectionMonitors', 'networkwatcher_westeurope', ConnectionMonitorName)
                          }
                          name: 'ChecksFailedPercent'
                          aggregationType: 4
                          namespace: 'microsoft.network/networkwatchers/connectionmonitors'
                          metricVisualization: {
                            displayName: 'Checks Failed Percent (Preview)'
                            resourceDisplayName: 'networkwatcher_westeurope/${ConnectionMonitorName}'
                          }
                        }
                      ]
                      title: 'AZIR Check Failed %'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
              filters: {
                TestGroupName: {
                  model: {
                    operator: 'equals'
                    values: [
                      'DSS Network Availability From AZ IRs'
                    ]
                  }
                }
              }
            }
          }
          '11': {
            position: {
              x: 16
              y: 3
              colSpan: 4
              rowSpan: 2
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  value: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('networkwatcherrg', 'Microsoft.Network/networkWatchers/connectionMonitors', 'networkwatcher_westeurope', ConnectionMonitorName)
                          }
                          name: 'ChecksFailedPercent'
                          aggregationType: 4
                          metricVisualization: {
                            displayName: 'Checks Failed Percent (Preview)'
                            resourceDisplayName: 'networkwatcher_westeurope/${ConnectionMonitorName}'
                          }
                        }
                      ]
                      title: 'Checks failed (%)'
                      titleKind: 2
                      filterCollection: {
                        filters: [
                          {
                            key: 'TestGroupName'
                            operator: 0
                            values: [
                              'DSS Network Availability From AZ OPDGs'
                            ]
                          }
                        ]
                      }
                      visualization: {
                        chartType: 2
                      }
                      openBladeOnClick: {
                        openBlade: true
                      }
                    }
                  }
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: resourceId('networkwatcherrg', 'Microsoft.Network/networkWatchers/connectionMonitors', 'networkwatcher_westeurope', ConnectionMonitorName)
                          }
                          name: 'ChecksFailedPercent'
                          aggregationType: 4
                          namespace: 'microsoft.network/networkwatchers/connectionmonitors'
                          metricVisualization: {
                            displayName: 'Checks Failed Percent (Preview)'
                            resourceDisplayName: 'networkwatcher_westeurope/${ConnectionMonitorName}'
                          }
                        }
                      ]
                      title: 'AZ OPDG Check Faied %'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
              filters: {
                TestGroupName: {
                  model: {
                    operator: 'equals'
                    values: [
                      'DSS Network Availability From AZ OPDGs'
                    ]
                  }
                }
                MsPortalFx_TimeRange: {
                  model: {
                    format: 'local'
                    granularity: 'auto'
                    relative: '30m'
                  }
                }
              }
            }
          }
          '12': {
            position: {
              x: 0
              y: 5
              colSpan: 20
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<p style="color: DarkKhaki; font-size: 30px;text-align: center;font-family:verdana;"> ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: PERFORMANCE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::</p>'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '13': {
            position: {
              x: 0
              y: 6
              colSpan: 4
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<h1 style="color: DarkTurquoise; font-size: 17px;text-align: center;font-family: verdana; "> DSS Capacity'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '14': {
            position: {
              x: 4
              y: 6
              colSpan: 4
              rowSpan: 1
            }
            metadata: {
              inputs: []
              type: 'Extension/HubsExtension/PartType/MarkdownPart'
              settings: {
                content: {
                  settings: {
                    content: '<h1 style="color: DarkTurquoise; font-size: 17px;text-align: center;font-family: verdana; "> DSS E2E Latency'
                    title: ''
                    subtitle: ''
                    markdownSource: 1
                  }
                }
              }
            }
          }
          '15': {
            position: {
              x: 0
              y: 7
              colSpan: 4
              rowSpan: 2
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  value: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: '/subscriptions/fd86fab0-733c-424b-9ca3-1842ce15e716/resourceGroups/tnc-data-prd-we/providers/Microsoft.Storage/storageAccounts/aldtncdataprdwedatalake'
                          }
                          name: 'UsedCapacity'
                          aggregationType: 4
                          namespace: 'microsoft.storage/storageaccounts'
                          metricVisualization: {
                            displayName: 'Used capacity'
                          }
                        }
                      ]
                      title: 'DSS Capacity'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                      }
                      timespan: {
                        relative: {
                          duration: 86400000
                        }
                        showUTCTime: false
                        grain: 1
                      }
                    }
                  }
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: '/subscriptions/fd86fab0-733c-424b-9ca3-1842ce15e716/resourceGroups/tnc-data-prd-we/providers/Microsoft.Storage/storageAccounts/aldtncdataprdwedatalake'
                          }
                          name: 'UsedCapacity'
                          aggregationType: 4
                          namespace: 'microsoft.storage/storageaccounts'
                          metricVisualization: {
                            displayName: 'Used capacity'
                            color: '#1bf2f2'
                          }
                        }
                      ]
                      title: 'DSS Capacity'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
            }
          }
          '16': {
            position: {
              x: 4
              y: 7
              colSpan: 4
              rowSpan: 2
            }
            metadata: {
              inputs: [
                {
                  name: 'options'
                  value: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: '/subscriptions/fd86fab0-733c-424b-9ca3-1842ce15e716/resourceGroups/tnc-data-prd-we/providers/Microsoft.Storage/storageAccounts/aldtncdataprdwedatalake'
                          }
                          name: 'SuccessE2ELatency'
                          aggregationType: 4
                          namespace: 'microsoft.storage/storageaccounts'
                          metricVisualization: {
                            displayName: 'Success E2E Latency'
                          }
                        }
                      ]
                      title: 'DSS E2E Latency'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                      }
                      timespan: {
                        relative: {
                          duration: 1800000
                        }
                        showUTCTime: false
                        grain: 1
                      }
                    }
                  }
                  isOptional: true
                }
                {
                  name: 'sharedTimeRange'
                  isOptional: true
                }
              ]
              type: 'Extension/HubsExtension/PartType/MonitorChartPart'
              settings: {
                content: {
                  options: {
                    chart: {
                      metrics: [
                        {
                          resourceMetadata: {
                            id: '/subscriptions/fd86fab0-733c-424b-9ca3-1842ce15e716/resourceGroups/tnc-data-prd-we/providers/Microsoft.Storage/storageAccounts/aldtncdataprdwedatalake'
                          }
                          name: 'SuccessE2ELatency'
                          aggregationType: 4
                          namespace: 'microsoft.storage/storageaccounts'
                          metricVisualization: {
                            displayName: 'Success E2E Latency'
                            color: '#1ac6d9'
                          }
                        }
                      ]
                      title: 'DSS E2E Latency'
                      titleKind: 2
                      visualization: {
                        chartType: 2
                        legendVisualization: {
                          isVisible: true
                          position: 2
                          hideSubtitle: false
                        }
                        axisVisualization: {
                          x: {
                            isVisible: true
                            axisType: 2
                          }
                          y: {
                            isVisible: true
                            axisType: 1
                          }
                        }
                        disablePinning: true
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    metadata: {
      model: {
        timeRange: {
          value: {
            relative: {
              duration: 24
              timeUnit: 1
            }
          }
          type: 'MsPortalFx.Composition.Configuration.ValueTypes.TimeRange'
        }
        filterLocale: {
          value: 'en-us'
        }
        filters: {
          value: {
            MsPortalFx_TimeRange: {
              model: {
                format: 'utc'
                granularity: 'auto'
                relative: '24h'
              }
              displayCache: {
                name: 'UTC Time'
                value: 'Past 24 hours'
              }
              filteredPartIds: [
                'StartboardPart-MonitorChartPart-e1dd450a-62b3-4710-9552-7ffd68ce890c'
                'StartboardPart-MonitorChartPart-e1dd450a-62b3-4710-9552-7ffd68ce890e'
                'StartboardPart-MonitorChartPart-e1dd450a-62b3-4710-9552-7ffd68ce8910'
                'StartboardPart-MonitorChartPart-e1dd450a-62b3-4710-9552-7ffd68ce8912'
                'StartboardPart-MonitorChartPart-e1dd450a-62b3-4710-9552-7ffd68ce8914'
                'StartboardPart-MonitorChartPart-e1dd450a-62b3-4710-9552-7ffd68ce891c'
                'StartboardPart-MonitorChartPart-e1dd450a-62b3-4710-9552-7ffd68ce891e'
              ]
            }
          }
        }
      }
    }
  }
  dependsOn: [
    metricalerts_DSS_Network_Availability_from_OP_Datalake_Primary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_OP_Datalake_Primary_File_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_OP_Datalake_Secondary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_OP_Datalake_Secondary_File_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Primary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Primary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Secondary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir01_Datalake_Secondary_File_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Primary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Primary_File_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Secondary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_IR_tncdatavmir02_Datalake_Secondary_File_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Primary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Primary_File_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Secondary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg01_Datalake_Secondary_File_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Primary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Primary_File_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Secondary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_AZ_OPGD_tncdatavmopdg02_Datalake_Secondary_File_Service_name_resource
    metricalerts_DSS_Network_Availability_from_CTH_Datalake_Primary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Primary_File_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Secondary_Blob_Service_name_resource
    metricAlerts_DSS_Network_Availability_from_CTH_Datalake_Secondary_File_Service_name_resource
  ]
}