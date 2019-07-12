require 'test/unit'
require_relative '../../../source/code/plugins/npmd_config_lib'

class Logger
    def self.logToStdOut(msg, depth=0)
        puts msg
    end
    class << self
        alias_method :logError, :logToStdOut
        alias_method :logInfo,  :logToStdOut
        alias_method :logWarn,  :logToStdOut
    end
end


class NPMDConfigUT < Test::Unit::TestCase

    def setup
        #@test_desc01 = "Test Case 01: Valid UI XML Configuration with default rule"
        #@test_desc02 = "Test Case 02: Invalid configuration version"
        #@test_desc03 = "Test Case 03: Mismatched XML tags"
        #@test_desc04 = "Test Case 04: Invalid configuration tags"
        #@test_desc05 = "Test Case 05: Invalid json between tags"
        #@test_desc06 = "Test Case 06: Missing agent capabilities"
        #@test_desc07 = "Test Case 07: Missing rule protocol"
        #@test_desc08 = "Test Case 08: Undefined subnet ids in config"
        #@test_desc09 = "Test Case 09: IPV6 config gets compressed ips"
        #@test_desc10 = "Test Case 10: Valid UI XML configuration with custom rule"
        #@test_desc11 = "Test Case 11: Valid UI XML Configuration with exceptions"
        #@test_desc12 = "Test Case 12: Verifying config error summary"
        @test_desc13 = "Test Case 13: Verifying config error summary"

        #@test_input_ui_config01 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config02 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="2"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config03 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3"]}}</NetworkNameToNetworkMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config04 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfiguration><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfiguration></Configuration>'
        #@test_input_ui_config05 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]} "NewOne":{"Subnets":["3"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config06 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}]}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config07 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[]}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config08 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3","4"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config09 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3","4"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21","4":"2404:f801:4800:14::/64"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"},"3":{"IPs":[{"Value":"2404:f801:4800:14:215:5dff:feb0:4706","Subnet":4}],"Protocol":"2"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config10 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"Default","SS":"1","DN":"NewOne","DS":"3"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config11 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["3"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":1}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":2}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1},"RuleWithExcept":{"ActOn":[{"SN":"NewOne","SS":"*","DN":"Default","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[{"SN":"NewOne","SS":"*","DN":"Default","DS":2}],"Protocol":2}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        #@test_input_ui_config12 = '<?xml version="1.0" encoding="utf-16"?><Configuration xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="3"><NetworkMonitoringAgentConfigurationV3><Metadata>{"Version":3,"Protocol":1,"SubnetUid":1,"AgentUid":1}</Metadata><NetworkNameToNetworkMap>{"Default":{"Subnets":["1","2"]}, "NewOne":{"Subnets":["4"]}}</NetworkNameToNetworkMap><SubnetIdToSubnetMap>{"1":"65.171.0.0/16", "2":"198.165.0.0/21", "3":"162.128.0.0/21"}</SubnetIdToSubnetMap><AgentFqdnToAgentMap>{"1":{"IPs":[{"Value":"65.171.126.72","Subnet":1}, {"Value":"65.171.126.73","Subnet":5}],"Protocol":"1"}, "2":{"IPs":[{"Value":"65.271.126.72","Subnet":4}],"Protocol":"1"}}</AgentFqdnToAgentMap><RuleNameToRuleMap>{"Default":{"ActOn":[{"SN":"*","SS":"*","DN":"*","DS":"*"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1},"RuleToDrop":{"ActOn":[{"SN":"Default","SS":"1","DN":"NewOne","DS":"4"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1},"RuleToPartialDrop":{"ActOn":[{"SN":"Default","SS":"1","DN":"NewOne","DS":"4"},{"SN":"Default","SS":"1","DN":"NewOne","DS":"2"}],"Threshold":{"Loss":-1.0,"Latency":-1.0},"Exceptions":[],"Protocol":1}}</RuleNameToRuleMap></NetworkMonitoringAgentConfigurationV3></Configuration>'
        @test_input_ui_config13 = '<?xml version="1.0" encoding="utf-8"?> <Configuration Version="3"> <NetworkMonitoringAgentConfigurationV3> <Metadata>{ "Version": 4, "Protocol": 2, "SubnetUid": 45, "AgentUid": 50, "WorkspaceResourceID": "/subscriptions/9cece3e3-0f7d-47ca-af0e-9772773f90b7/resourcegroups/ER-Lab/providers/Microsoft.OperationalInsights/workspaces/npm-devEUS2Workspace", "WorkspaceID": "72e9d2d8-8e48-41e8-8e4a-78fd70653700", "LastUpdated": "timestamp"}</Metadata> <NetworkNameToNetworkMap>{ "Default": { "Subnets": [ "1", "2" ] }, "OnPrem": { "Subnets": [ "42" ] }, "Azure": { "Subnets": [ "43" ] } }</NetworkNameToNetworkMap> <SubnetIdToSubnetMap>{ "1": "2001:0:9d38:90d7::/64", "2": "fe80:0000:0000:0000::/64", "42": "10.10.40.0/25", "43": "10.86.208.0/20" }</SubnetIdToSubnetMap> <AgentFqdnToAgentMap>{ "24": { "IPs": [ { "Value": "10.86.209.191", "Subnet": "43" }, { "Value": "fe80::5942:ab60:8235:e500", "Subnet": "2" } ], "Protocol": 3 }, "25": { "IPs": [ { "Value": "10.10.40.4", "Subnet": "42" }, { "Value": "2001:0:9d38:90d7:80c:dba:d786:2395", "Subnet": "1" } ], "Protocol": 3 } }</AgentFqdnToAgentMap> <RuleNameToRuleMap>{ "OnPrem to Azure": { "Protocol": 2, "ActOn": [ { "SN": "OnPrem", "DN": "Azure", "SS": "*", "DS": "*" } ], "Exceptions": [], "Threshold": { "Loss": -1, "Latency": -1 } }, "Azure to OnPrem": { "Protocol": 2, "ActOn": [ { "SN": "Azure", "DN": "OnPrem", "SS": "*", "DS": "*" } ], "Exceptions": [], "Threshold": { "Loss": -1, "Latency": -1 } } }</RuleNameToRuleMap> <EPMConfiguration>{ "TestIdToTestMap": { "3": { "Endpoints": [ "3" ], "Name": "Google", "Poll": 5, "AppThreshold": { "Latency": 2000 }, "NetworkThreshold": { "Loss": 5, "Latency": 500 } }, "5": { "Endpoints": [ "5" ], "Name": "google HTTP", "Poll": 5, "AppThreshold": { "Latency": 1000 }, "NetworkThreshold": { "Loss": 2, "Latency": 100 } }, "8": { "Endpoints": [ "8" ], "Name": "TCP Test", "Poll": 5, "AppThreshold": { "Latency": 100 }, "NetworkThreshold": { "Loss": 2, "Latency": 100 } }, "1002": { "Endpoints": [ "100264" ], "Name": "Office 365 authentication and identity", "Poll": 5, "AppThreshold": { "Latency": 1000 }, "NetworkThreshold": { "Loss": -2, "Latency": -2 } }, "1005": { "Endpoints": [ "100581", "100582" ], "Name": "Skype for Business Online", "Poll": 5, "AppThreshold": { "Latency": -2 }, "NetworkThreshold": { "Loss": -2, "Latency": -2 } } }, "EndpointIdToEndpointMap": { "3": { "url": "www.google.com", "port": 443, "protocol": "https" }, "5": { "url": "www.google.com", "port": 80, "protocol": "http" }, "8": { "url": "www.bing.com", "port": 443, "protocol": "tcp" }, "100264": { "url": "login.microsoft.com", "port": 443, "protocol": "https" }, "100581": { "url": "config.edge.skype.com", "port": 443, "protocol": "https" }, "100582": { "url": "pipe.skype.com", "port": 443, "protocol": "https" } }, "AgentIdToTestIdsMap": { "24": [ "3", "5", "1005" ], "25": [ "3", "5", "8", "1002" ] } }</EPMConfiguration> <erConfiguration>{ "erPrivateTestIdToERTestMap": { "3": { "azureAgents": [ "25" ], "vNet": "ER-Lab-VNet01", "connectionResourceId": "/subscriptions/9cece3e3-0f7d-47ca-af0e-9772773f90b7/resourceGroups/ER-Lab/providers/Microsoft.Network/connections/ER-Lab-gw-conn", "circuitName": "ER-Lab-ER", "threshold": { "loss": 11, "latency": 20 }, "onPremAgents": [ "24" ], "protocol": 2, "circuitId": "4" }, "6": { "azureAgents": [], "vNet": "AScentTstVNet", "connectionResourceId": "/subscriptions/a013b98a-6c2a-4f92-a6a7-82266ac6f437/resourceGroups/AScenTstRG/providers/Microsoft.Network/connections/AScenTstConnForER", "circuitName": "AScenTstER", "threshold": { "loss": -2, "latency": -2 }, "onPremAgents": [], "protocol": 2, "circuitId": "9" } }, "erMSTestIdToERTestMap": { "2": { "urlList": [ { "url": "delve.office.com", "port": 443 } ], "circuitName": "ER-Lab-ER", "threshold": { "loss": -2, "latency": -2 }, "onPremAgents": [ "24" ], "protocol": 2, "circuitId": "4" } }, "erCircuitIdToCircuitResourceIdMap": { "4": "/subscriptions/9cece3e3-0f7d-47ca-af0e-9772773f90b7/resourceGroups/ER-Lab/providers/Microsoft.Network/expressRouteCircuits/ER-Lab-ER", "9": "/subscriptions/a013b98a-6c2a-4f92-a6a7-82266ac6f437/resourceGroups/AScenTstRG/providers/Microsoft.Network/expressRouteCircuits/AScenTstER" } }</erConfiguration> </NetworkMonitoringAgentConfigurationV3> </Configuration>'

        #@hash_output_ui_config01={"Networks"=>[{"Name"=>"Default", "Subnets"=>["1", "2"]},{"Name"=>"NewOne", "Subnets"=>["3"]}],"Subnets"=>{"1"=>"65.171.0.0/16", "2"=>"198.165.0.0/21", "3"=>"162.128.0.0/21"},"Agents"=>[{"Guid"=>"1","Capability"=>"1","IPs"=>[{"IP"=>"65.171.126.72", "SubnetName"=>"1"},{"IP"=>"65.171.126.73", "SubnetName"=>"1"}]},{"Guid"=>"2","Capability"=>"1","IPs"=>[{"IP"=>"65.271.126.72", "SubnetName"=>"2"}]}],"Rules"=>[{"Name"=>"Default","LossThreshold"=>-1.0,"LatencyThreshold"=>-1.0,"Protocol"=>1,"Rules"=>[{"SN"=>"*", "SS"=>"*", "DN"=>"*", "DS"=>"*"}],"Exceptions"=>[]}]}
        #@hash_output_ui_config02=nil
        #@hash_output_ui_config03=nil
        #@hash_output_ui_config04=nil
        #@hash_output_ui_config05=nil
        #@hash_output_ui_config06={"Networks"=>[{"Name"=>"Default", "Subnets"=>["1", "2"]}, {"Name"=>"NewOne", "Subnets"=>["3"]}], "Subnets"=>{"1"=>"65.171.0.0/16", "2"=>"198.165.0.0/21", "3"=>"162.128.0.0/21"}, "Agents"=>[{"Guid"=>"1", "IPs"=>[{"IP"=>"65.171.126.72", "SubnetName"=>"1"}, {"IP"=>"65.171.126.73", "SubnetName"=>"1"}]}, {"Guid"=>"2", "Capability"=>"1", "IPs"=>[{"IP"=>"65.271.126.72", "SubnetName"=>"2"}]}], "Rules"=>[{"Name"=>"Default", "LossThreshold"=>-1.0, "LatencyThreshold"=>-1.0, "Protocol"=>1, "Rules"=>[{"SN"=>"*", "SS"=>"*", "DN"=>"*", "DS"=>"*"}], "Exceptions"=>[]}]}
        #@hash_output_ui_config07={"Networks"=>[{"Name"=>"Default", "Subnets"=>["1", "2"]}, {"Name"=>"NewOne", "Subnets"=>["3"]}], "Subnets"=>{"1"=>"65.171.0.0/16", "2"=>"198.165.0.0/21", "3"=>"162.128.0.0/21"}, "Agents"=>[{"Guid"=>"1", "Capability"=>"1", "IPs"=>[{"IP"=>"65.171.126.72", "SubnetName"=>"1"}, {"IP"=>"65.171.126.73", "SubnetName"=>"1"}]}, {"Guid"=>"2", "Capability"=>"1", "IPs"=>[{"IP"=>"65.271.126.72", "SubnetName"=>"2"}]}], "Rules"=>[{"Name"=>"Default", "LossThreshold"=>-1.0, "LatencyThreshold"=>-1.0, "Rules"=>[{"SN"=>"*", "SS"=>"*", "DN"=>"*", "DS"=>"*"}], "Exceptions"=>[]}]}
        #@hash_output_ui_config08={"Networks"=>[{"Name"=>"Default", "Subnets"=>["1", "2"]}, {"Name"=>"NewOne", "Subnets"=>["3", "4"]}], "Subnets"=>{"1"=>"65.171.0.0/16", "2"=>"198.165.0.0/21", "3"=>"162.128.0.0/21"}, "Agents"=>[{"Guid"=>"1", "Capability"=>"1", "IPs"=>[{"IP"=>"65.171.126.72", "SubnetName"=>"1"}, {"IP"=>"65.171.126.73", "SubnetName"=>"1"}]}, {"Guid"=>"2", "Capability"=>"1", "IPs"=>[{"IP"=>"65.271.126.72", "SubnetName"=>"2"}]}], "Rules"=>[{"Name"=>"Default", "LossThreshold"=>-1.0, "LatencyThreshold"=>-1.0, "Protocol"=>1, "Rules"=>[{"SN"=>"*", "SS"=>"*", "DN"=>"*", "DS"=>"*"}], "Exceptions"=>[]}]}
        #@hash_output_ui_config09={"Networks"=>[{"Name"=>"Default", "Subnets"=>["1", "2"]}, {"Name"=>"NewOne", "Subnets"=>["3", "4"]}], "Subnets"=>{"1"=>"65.171.0.0/16", "2"=>"198.165.0.0/21", "3"=>"162.128.0.0/21", "4"=>"2404:f801:4800:14::/64"}, "Agents"=>[{"Guid"=>"1", "Capability"=>"1", "IPs"=>[{"IP"=>"65.171.126.72", "SubnetName"=>"1"}, {"IP"=>"65.171.126.73", "SubnetName"=>"1"}]}, {"Guid"=>"2", "Capability"=>"1", "IPs"=>[{"IP"=>"65.271.126.72", "SubnetName"=>"2"}]}, {"Guid"=>"3", "Capability"=>"2", "IPs"=>[{"IP"=>"2404:f801:4800:14:215:5dff:feb0:4706", "SubnetName"=>"4"}]}], "Rules"=>[{"Name"=>"Default", "LossThreshold"=>-1.0, "LatencyThreshold"=>-1.0, "Protocol"=>1, "Rules"=>[{"SN"=>"*", "SS"=>"*", "DN"=>"*", "DS"=>"*"}], "Exceptions"=>[]}]}
        #@hash_output_ui_config10={"Networks"=>[{"Name"=>"Default", "Subnets"=>["1", "2"]},{"Name"=>"NewOne", "Subnets"=>["3"]}],"Subnets"=>{"1"=>"65.171.0.0/16", "2"=>"198.165.0.0/21", "3"=>"162.128.0.0/21"},"Agents"=>[{"Guid"=>"1","Capability"=>"1","IPs"=>[{"IP"=>"65.171.126.72", "SubnetName"=>"1"},{"IP"=>"65.171.126.73", "SubnetName"=>"1"}]},{"Guid"=>"2","Capability"=>"1","IPs"=>[{"IP"=>"65.271.126.72", "SubnetName"=>"2"}]}],"Rules"=>[{"Name"=>"Default","LossThreshold"=>-1.0,"LatencyThreshold"=>-1.0,"Protocol"=>1,"Rules"=>[{"SN"=>"Default", "SS"=>"1", "DN"=>"NewOne", "DS"=>"3"}],"Exceptions"=>[]}]}
        #@hash_output_ui_config11={"Networks"=>[{"Name"=>"Default", "Subnets"=>["1", "2"]},{"Name"=>"NewOne", "Subnets"=>["3"]}],"Subnets"=>{"1"=>"65.171.0.0/16", "2"=>"198.165.0.0/21", "3"=>"162.128.0.0/21"},"Agents"=>[{"Guid"=>"1","Capability"=>"1","IPs"=>[{"IP"=>"65.171.126.72", "SubnetName"=>"1"},{"IP"=>"65.171.126.73", "SubnetName"=>"1"}]},{"Guid"=>"2","Capability"=>"1","IPs"=>[{"IP"=>"65.271.126.72", "SubnetName"=>"2"}]}],"Rules"=>[{"Name"=>"Default","LossThreshold"=>-1.0,"LatencyThreshold"=>-1.0,"Protocol"=>1,"Rules"=>[{"SN"=>"*", "SS"=>"*", "DN"=>"*", "DS"=>"*"}],"Exceptions"=>[]},{"Name"=>"RuleWithExcept","LossThreshold"=>-1.0,"LatencyThreshold"=>-1.0,"Protocol"=>2,"Rules"=>[{"SN"=>"NewOne", "SS"=>"*", "DN"=>"Default", "DS"=>"*"}],"Exceptions"=>[{"SN"=>"NewOne", "SS"=>"*", "DN"=>"Default", "DS"=>2}]}]}
        #@hash_output_ui_config12={"Networks"=>[{"Name"=>"Default", "Subnets"=>["1", "2"]},{"Name"=>"NewOne", "Subnets"=>["4"]}],"Subnets"=>{"1"=>"65.171.0.0/16", "2"=>"198.165.0.0/21", "3"=>"162.128.0.0/21"},"Agents"=>[{"Guid"=>"1","Capability"=>"1","IPs"=>[{"IP"=>"65.171.126.72", "SubnetName"=>"1"},{"IP"=>"65.171.126.73", "SubnetName"=>"5"}]},{"Guid"=>"2","Capability"=>"1","IPs"=>[{"IP"=>"65.271.126.72", "SubnetName"=>"4"}]}],"Rules"=>[{"Name"=>"Default","LossThreshold"=>-1.0,"LatencyThreshold"=>-1.0,"Protocol"=>1,"Rules"=>[{"SN"=>"*", "SS"=>"*", "DN"=>"*", "DS"=>"*"}],"Exceptions"=>[]},{"Name"=>"RuleToDrop","LossThreshold"=>-1.0,"LatencyThreshold"=>-1.0,"Protocol"=>1,"Rules"=>[{"SN"=>"Default", "SS"=>"1", "DN"=>"NewOne", "DS"=>"4"}],"Exceptions"=>[]},{"Name"=>"RuleToPartialDrop","LossThreshold"=>-1.0,"LatencyThreshold"=>-1.0,"Protocol"=>1,"Rules"=>[{"SN"=>"Default", "SS"=>"1", "DN"=>"NewOne", "DS"=>"4"},{"SN"=>"Default", "SS"=>"1", "DN"=>"NewOne", "DS"=>"2"}],"Exceptions"=>[]}]}
        @hash_output_ui_config13={"Networks"=>[{"Name"=>"Default", "Subnets"=>["1", "2"]}, {"Name"=>"OnPrem", "Subnets"=>["42"]}, {"Name"=>"Azure", "Subnets"=>["43"]}], "Subnets"=>{"1"=>"2001:0:9d38:90d7::/64", "2"=>"fe80:0000:0000:0000::/64", "42"=>"10.10.40.0/25", "43"=>"10.86.209.0/20"}, "Agents"=>[{"Guid"=>"24", "Capability"=>3, "IPs"=>[{"IP"=>"10.86.209.183", "SubnetName"=>"43"}, {"IP"=>"fe80::5942:ab60:8235:e500", "SubnetName"=>"2"}]}, {"Guid"=>"25", "Capability"=>3, "IPs"=>[{"IP"=>"10.10.40.4", "SubnetName"=>"42"}, {"IP"=>"2001:0:9d38:90d7:80c:dba:d786:2395", "SubnetName"=>"1"}]}], "Rules"=>[{"Name"=>"OnPrem to Azure", "LossThreshold"=>-1, "LatencyThreshold"=>-1, "Protocol"=>2, "Rules"=>[{"SN"=>"OnPrem", "DN"=>"Azure", "SS"=>"*", "DS"=>"*"}], "Exceptions"=>[], "DiscoverPaths"=>nil, "Description"=>nil, "Enabled"=>nil}, {"Name"=>"Azure to OnPrem", "LossThreshold"=>-1, "LatencyThreshold"=>-1, "Protocol"=>2, "Rules"=>[{"SN"=>"Azure", "DN"=>"OnPrem", "SS"=>"*", "DS"=>"*"}], "Exceptions"=>[], "DiscoverPaths"=>nil, "Description"=>nil, "Enabled"=>nil}], "Epm"=>{"Rules"=>[{"ID"=>"3", "Name"=>"Google", "Poll"=>5, "AppThresholdLatency"=>2000, "NetworkThresholdLoss"=>5, "NetworkThresholdLatency"=>500, "CMResourceId"=>"/subscriptions/af15e575-f948-49ac-bce0-252d028e9379/resourceGroups/NetworkWatcherRG/providers/Microsoft.Network/networkWatchers/NetworkWatcher_centraluseuap/connectionMonitors/cmForDemo", "IngestionWorkspaceId"=>"72e9d2d8-8e48-41e8-8e4a-78fd70653700", "WorkspaceAlias"=>"myEUSWorkspace", "Endpoints"=>[{"Id"=>"3", "Name"=>"my Google endpoint", "URL"=>"www.google.com", "Port"=>443, "Protocol"=>"https", "TimeDrift"=>"66"}]}, {"ID"=>"5", "Name"=>"google HTTP", "Poll"=>5, "AppThresholdLatency"=>1000, "NetworkThresholdLoss"=>2, "NetworkThresholdLatency"=>100, "Endpoints"=>[{"Id"=>"5", "Name"=>"my Google http endpoint", "URL"=>"www.google.com", "Port"=>80, "Protocol"=>"http", "TimeDrift"=>"207"}]}, {"ID"=>"1005", "Name"=>"Skype for Business Online", "Poll"=>5, "AppThresholdLatency"=>-2, "NetworkThresholdLoss"=>-2, "NetworkThresholdLatency"=>-2, "Endpoints"=>[{"Id"=>"100581", "Name"=>"my edge skype endpoint", "URL"=>"config.edge.skype.com", "Port"=>443, "Protocol"=>"https", "TimeDrift"=>"167"}, {"Id"=>"100582", "Name"=>"my Skype endpoint", "URL"=>"pipe.skype.com", "Port"=>443, "Protocol"=>"https", "TimeDrift"=>"218"}]}]}, "ER"=>{"PrivatePeeringRules"=>[{"Name"=>"3", "Protocol"=>2, "CircuitId"=>"4", "LossThreshold"=>11, "LatencyThreshold"=>20, "CircuitName"=>"ER-Lab-ER", "vNetName"=>"ER-Lab-VNet01", "ConnectionResourceId"=>"/subscriptions/9cece3e3-0f7d-47ca-af0e-9772773f90b7/resourceGroups/ER-Lab/providers/Microsoft.Network/connections/ER-Lab-gw-conn", "CircuitResourceId"=>"/subscriptions/9cece3e3-0f7d-47ca-af0e-9772773f90b7/resourceGroups/ER-Lab/providers/Microsoft.Network/expressRouteCircuits/ER-Lab-ER", "OnPremAgents"=>["24"], "AzureAgents"=>["25"]}], "MSPeeringRules"=>[{"Name"=>"2", "CircuitName"=>"ER-Lab-ER", "CircuitId"=>"4", "Protocol"=>2, "CircuitResourceId"=>"/subscriptions/9cece3e3-0f7d-47ca-af0e-9772773f90b7/resourceGroups/ER-Lab/providers/Microsoft.Network/expressRouteCircuits/ER-Lab-ER", "LossThreshold"=>-2, "LatencyThreshold"=>-2, "UrlList"=>[{"url"=>"delve.office.com", "port"=>443}], "OnPremAgents"=>["24"]}]}}

        #@string_agent_config01='<Configuration><Agents><Agent Name="1" Capabilities="1"><IPConfiguration IP="65.171.126.72" Mask="255.255.0.0"/><IPConfiguration IP="65.171.126.73" Mask="255.255.0.0"/></Agent><Agent Name="2" Capabilities="1"><IPConfiguration IP="65.271.126.72" Mask="255.255.248.0"/></Agent></Agents><Networks><Network Name="Default"><Subnet ID="65.171.0.0" Disabled="False" Tag=""/><Subnet ID="198.165.0.0" Disabled="False" Tag=""/></Network><Network Name="NewOne"><Subnet ID="162.128.0.0" Disabled="False" Tag=""/></Network></Networks><Rules><Rule Name="Default" Description="" Protocol="1"><AlertConfiguration><Loss Threshold="-1.0"/><Latency Threshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPair SourceSubnet="*" SourceNetwork="*" DestSubnet="*" DestNetwork="*"/></NetworkTestMatrix><Exceptions /></Rule></Rules></Configuration>'.gsub(/\s+/,"")
        #@string_agent_config02=nil
        #@string_agent_config03=nil
        #@string_agent_config04=nil
        #@string_agent_config05=nil
        #@string_agent_config06='<Configuration><Agents><AgentName="1"><IPConfigurationIP="65.171.126.72"Mask="255.255.0.0"/><IPConfigurationIP="65.171.126.73"Mask="255.255.0.0"/></Agent><AgentName="2"Capabilities="1"><IPConfigurationIP="65.271.126.72"Mask="255.255.248.0"/></Agent></Agents><Networks><NetworkName="Default"><SubnetID="65.171.0.0"Disabled="False"Tag=""/><SubnetID="198.165.0.0"Disabled="False"Tag=""/></Network><NetworkName="NewOne"><SubnetID="162.128.0.0"Disabled="False"Tag=""/></Network></Networks><Rules><RuleName="Default"Description=""Protocol="1"><AlertConfiguration><LossThreshold="-1.0"/><LatencyThreshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPairSourceSubnet="*"SourceNetwork="*"DestSubnet="*"DestNetwork="*"/></NetworkTestMatrix><Exceptions/></Rule></Rules></Configuration>'.gsub(/\s+/,"")
        #@string_agent_config07='<Configuration><Agents><AgentName="1"Capabilities="1"><IPConfigurationIP="65.171.126.72"Mask="255.255.0.0"/><IPConfigurationIP="65.171.126.73"Mask="255.255.0.0"/></Agent><AgentName="2"Capabilities="1"><IPConfigurationIP="65.271.126.72"Mask="255.255.248.0"/></Agent></Agents><Networks><NetworkName="Default"><SubnetID="65.171.0.0"Disabled="False"Tag=""/><SubnetID="198.165.0.0"Disabled="False"Tag=""/></Network><NetworkName="NewOne"><SubnetID="162.128.0.0"Disabled="False"Tag=""/></Network></Networks><Rules><RuleName="Default"Description=""><AlertConfiguration><LossThreshold="-1.0"/><LatencyThreshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPairSourceSubnet="*"SourceNetwork="*"DestSubnet="*"DestNetwork="*"/></NetworkTestMatrix><Exceptions/></Rule></Rules></Configuration>'.gsub(/\s+/,"")
        #@string_agent_config08='<Configuration><Agents><AgentName="1"Capabilities="1"><IPConfigurationIP="65.171.126.72"Mask="255.255.0.0"/><IPConfigurationIP="65.171.126.73"Mask="255.255.0.0"/></Agent><AgentName="2"Capabilities="1"><IPConfigurationIP="65.271.126.72"Mask="255.255.248.0"/></Agent></Agents><Networks><NetworkName="Default"><SubnetID="65.171.0.0"Disabled="False"Tag=""/><SubnetID="198.165.0.0"Disabled="False"Tag=""/></Network><NetworkName="NewOne"><SubnetID="162.128.0.0"Disabled="False"Tag=""/></Network></Networks><Rules><RuleName="Default"Description=""Protocol="1"><AlertConfiguration><LossThreshold="-1.0"/><LatencyThreshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPairSourceSubnet="*"SourceNetwork="*"DestSubnet="*"DestNetwork="*"/></NetworkTestMatrix><Exceptions/></Rule></Rules></Configuration>'.gsub(/\s+/,"")
        #@string_agent_config09='<Configuration><Agents><AgentName="1"Capabilities="1"><IPConfigurationIP="65.171.126.72"Mask="255.255.0.0"/><IPConfigurationIP="65.171.126.73"Mask="255.255.0.0"/></Agent><AgentName="2"Capabilities="1"><IPConfigurationIP="65.271.126.72"Mask="255.255.248.0"/></Agent><AgentName="3"Capabilities="2"><IPConfigurationIP="2404:f801:4800:14:215:5dff:feb0:4706"Mask="ffff:ffff:ffff:ffff::"/></Agent></Agents><Networks><NetworkName="Default"><SubnetID="65.171.0.0"Disabled="False"Tag=""/><SubnetID="198.165.0.0"Disabled="False"Tag=""/></Network><NetworkName="NewOne"><SubnetID="162.128.0.0"Disabled="False" Tag=""/><SubnetID="2404:f801:4800:14::"Disabled="False"Tag=""/></Network></Networks><Rules><RuleName="Default" Description=""Protocol="1"><AlertConfiguration><LossThreshold="-1.0"/><LatencyThreshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPairSourceSubnet="*"SourceNetwork="*"DestSubnet="*"DestNetwork="*"/></NetworkTestMatrix><Exceptions/></Rule></Rules></Configuration>'.gsub(/\s+/,"")
        #@string_agent_config10='<Configuration><Agents><Agent Name="1" Capabilities="1"><IPConfiguration IP="65.171.126.72" Mask="255.255.0.0"/><IPConfiguration IP="65.171.126.73" Mask="255.255.0.0"/></Agent><Agent Name="2" Capabilities="1"><IPConfiguration IP="65.271.126.72" Mask="255.255.248.0"/></Agent></Agents><Networks><Network Name="Default"><Subnet ID="65.171.0.0" Disabled="False" Tag=""/><Subnet ID="198.165.0.0" Disabled="False" Tag=""/></Network><Network Name="NewOne"><Subnet ID="162.128.0.0" Disabled="False" Tag=""/></Network></Networks><Rules><Rule Name="Default" Description="" Protocol="1"><AlertConfiguration><Loss Threshold="-1.0"/><Latency Threshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPair SourceSubnet="65.171.0.0" SourceNetwork="Default" DestSubnet="162.128.0.0" DestNetwork="NewOne"/></NetworkTestMatrix><Exceptions/></Rule></Rules></Configuration>'.gsub(/\s+/,"")
        #@string_agent_config11='<Configuration><Agents><Agent Name="1" Capabilities="1"><IPConfiguration IP="65.171.126.72" Mask="255.255.0.0"/><IPConfiguration IP="65.171.126.73" Mask="255.255.0.0"/></Agent><Agent Name="2" Capabilities="1"><IPConfiguration IP="65.271.126.72" Mask="255.255.248.0"/></Agent></Agents><Networks><Network Name="Default"><Subnet ID="65.171.0.0" Disabled="False" Tag=""/><Subnet ID="198.165.0.0" Disabled="False" Tag=""/></Network><Network Name="NewOne"><Subnet ID="162.128.0.0" Disabled="False" Tag=""/></Network></Networks><Rules><Rule Name="Default" Description="" Protocol="1"><AlertConfiguration><Loss Threshold="-1.0"/><Latency Threshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPair SourceSubnet="*" SourceNetwork="*" DestSubnet="*" DestNetwork="*"/></NetworkTestMatrix><Exceptions /></Rule><Rule Name="RuleWithExcept" Description="" Protocol="2"><AlertConfiguration><Loss Threshold="-1.0"/><Latency Threshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPair SourceSubnet="*" SourceNetwork="NewOne" DestSubnet="*" DestNetwork="Default"/></NetworkTestMatrix><Exceptions><SubnetPair SourceSubnet="*" SourceNetwork="NewOne" DestSubnet="198.165.0.0" DestNetwork="Default"/></Exceptions></Rule></Rules></Configuration>'.gsub(/\s+/,"")
        #@string_agent_config12='<Configuration><Agents><Agent Name="1" Capabilities="1"><IPConfiguration IP="65.171.126.72" Mask="255.255.0.0"/></Agent></Agents><Networks><Network Name="Default"><Subnet ID="65.171.0.0" Disabled="False" Tag=""/><Subnet ID="198.165.0.0" Disabled="False" Tag=""/></Network></Networks><Rules><Rule Name="Default" Description="" Protocol="1"><AlertConfiguration><Loss Threshold="-1.0"/><Latency Threshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPair SourceSubnet="*" SourceNetwork="*" DestSubnet="*" DestNetwork="*"/></NetworkTestMatrix><Exceptions /></Rule><Rule Name="RuleToPartialDrop" Description="" Protocol="1"><AlertConfiguration><Loss Threshold="-1.0"/><Latency Threshold="-1.0"/></AlertConfiguration><NetworkTestMatrix><SubnetPair SourceSubnet="65.171.0.0" SourceNetwork="Default" DestSubnet="198.165.0.0" DestNetwork="NewOne"/></NetworkTestMatrix><Exceptions /></Rule></Rules></Configuration>'.gsub(/\s+/,"")
        @string_agent_config13='{"Configuration":{"Agents":[{"Name":"24","Capabilities":3,"IPConfiguration":[{"IP":"10.86.209.183","Mask":"255.255.240.0"},{"IP":"fe80::5942:ab60:8235:e500","Mask":"ffff:ffff:ffff:ffff::"}]},{"Name":"25","Capabilities":3,"IPConfiguration":[{"IP":"10.10.40.4","Mask":"255.255.255.128"},{"IP":"2001:0:9d38:90d7:80c:dba:d786:2395","Mask":"ffff:ffff:ffff:ffff::"}]}],"Networks":[{"Name":"Default","Subnet":[{"ID":"2001:0:9d38:90d7::","Disabled":["False"],"Tag":""},{"ID":"fe80::","Disabled":["False"],"Tag":""}]},{"Name":"OnPrem","Subnet":[{"ID":"10.10.40.0","Disabled":["False"],"Tag":""}]},{"Name":"Azure","Subnet":[{"ID":"10.86.208.0","Disabled":["False"],"Tag":""}]}],"Rules":[{"Name":"OnPrem to Azure","Description":null,"Protocol":2,"NetworkTestMatrix":[{"SourceSubnet":"*","SourceNetwork":"OnPrem","DestSubnet":"*","DestNetwork":"Azure"}],"AlertConfiguration":{"ChecksFailedPercent":-1,"RoundTripTimeMs":-1},"Exceptions":[],"DiscoverPaths":null},{"Name":"Azure to OnPrem","Description":null,"Protocol":2,"NetworkTestMatrix":[{"SourceSubnet":"*","SourceNetwork":"Azure","DestSubnet":"*","DestNetwork":"OnPrem"}],"AlertConfiguration":{"ChecksFailedPercent":-1,"RoundTripTimeMs":-1},"Exceptions":[],"DiscoverPaths":null}],"EPM":{"Rules":[{"ID":"3","Name":"Google","CMResourceId":"/subscriptions/af15e575-f948-49ac-bce0-252d028e9379/resourceGroups/NetworkWatcherRG/providers/Microsoft.Network/networkWatchers/NetworkWatcher_centraluseuap/connectionMonitors/cmForDemo","IngestionWorkspaceId":"72e9d2d8-8e48-41e8-8e4a-78fd70653700","WorkspaceAlias":"myEUSWorkspace","Redirect":"false","NetTests":"true","AppTests":"true","NetworkThreshold":{"ChecksFailedPercent":5,"RoundTripTimeMs":500},"AppThreshold":{"RoundTripTimeMs":2000},"Endpoints":[{"ID":"3","DestAddress":"www.google.com","DestPort":443,"TestProtocol":"https","MonitoringInterval":5,"TimeDrift":"66"}]},{"ID":"5","Name":"google HTTP","CMResourceId":null,"IngestionWorkspaceId":null,"WorkspaceAlias":null,"Redirect":"false","NetTests":"true","AppTests":"true","NetworkThreshold":{"ChecksFailedPercent":2,"RoundTripTimeMs":100},"AppThreshold":{"RoundTripTimeMs":1000},"Endpoints":[{"ID":"5","DestAddress":"www.google.com","DestPort":80,"TestProtocol":"http","MonitoringInterval":5,"TimeDrift":"207"}]},{"ID":"1005","Name":"Skype for Business Online","CMResourceId":null,"IngestionWorkspaceId":null,"WorkspaceAlias":null,"Redirect":"false","NetTests":"false","AppTests":"false","Endpoints":[{"ID":"100581","DestAddress":"config.edge.skype.com","DestPort":443,"TestProtocol":"https","MonitoringInterval":5,"TimeDrift":"167"},{"ID":"100582","DestAddress":"pipe.skype.com","DestPort":443,"TestProtocol":"https","MonitoringInterval":5,"TimeDrift":"218"}]}]},"ER":{"PrivateRules":[{"Name":"3","ConnectionResourceId":"/subscriptions/9cece3e3-0f7d-47ca-af0e-9772773f90b7/resourceGroups/ER-Lab/providers/Microsoft.Network/connections/ER-Lab-gw-conn","CircuitResourceId":"/subscriptions/9cece3e3-0f7d-47ca-af0e-9772773f90b7/resourceGroups/ER-Lab/providers/Microsoft.Network/expressRouteCircuits/ER-Lab-ER","CircuitName":"ER-Lab-ER","VirtualNetworkName":"ER-Lab-VNet01","Protocol":2,"Threshold":{"ChecksFailedPercent":11,"RoundTripTimeMs":20},"OnPremAgents":["24"],"AzureAgents":["25"]}],"MSPeeringRules":[{"Name":"2","CircuitName":"ER-Lab-ER","Protocol":2,"CircuitResourceId":"/subscriptions/9cece3e3-0f7d-47ca-af0e-9772773f90b7/resourceGroups/ER-Lab/providers/Microsoft.Network/expressRouteCircuits/ER-Lab-ER","Threshold":{"ChecksFailedPercent":-2,"RoundTripTimeMs":-2},"OnPremAgents":["24"],"URLs":[{"Target":"delve.office.com","Port":443}]}]}}}'
    end

    def validate_test_case(test_desc, ui_config, ui_output_hash, agent_config_str)
        _intHash = nil
        begin
            _intHash = NPMDConfig::UIConfigParser.parse(ui_config)
        rescue Exception => e
            # Ignore exception as some are meant for failing
        end
        unless ui_output_hash.nil?
            assert_equal(ui_output_hash, _intHash, "#{test_desc}: Failed while getting uiconfig hash")
        else
            assert(_intHash.nil?, "#{test_desc}: Failed as expectation is to get nil after UI config parsing")
        end

        unless _intHash.nil?
            _jsonConfig = nil
            begin
                NPMDConfig::AgentConfigCreator.resetErrorCheck()
                _jsonConfig = NPMDConfig::AgentConfigCreator.createJsonFromUIConfigHash(_intHash)
            rescue Exception => e
                # Ignore exception as some are meant for failing
            end
            if agent_config_str.nil?
                assert(_jsonConfig.nil?, "#{test_desc}: Failed as expectation is to get nil after agent config generation")
            elsif _jsonConfig.nil?
                assert(false, "#{test_desc}: Failed as expected agent config json was not nil")
            else
                _jsonConfig.gsub!(/\s+/, "")
                _jsonConfig.gsub!("\n","")
                _jsonConfig.gsub!(/\'/,"\"")
                assert_equal(agent_config_str, _jsonConfig, "#{test_desc}: Failed agent config json mismatch")
            end
        end
    end

    def test_case_01
        #validate_test_case(@test_desc01, @test_input_ui_config01, @hash_output_ui_config01, @string_agent_config01)
    end

    def test_case_02
        #validate_test_case(@test_desc02, @test_input_ui_config02, @hash_output_ui_config02, @string_agent_config02)
    end

    def test_case_03
        #validate_test_case(@test_desc03, @test_input_ui_config03, @hash_output_ui_config03, @string_agent_config03)
    end

    def test_case_04
        #validate_test_case(@test_desc04, @test_input_ui_config04, @hash_output_ui_config04, @string_agent_config04)
    end

    def test_case_05
        #validate_test_case(@test_desc05, @test_input_ui_config05, @hash_output_ui_config05, @string_agent_config05)
    end

    def test_case_06
        #validate_test_case(@test_desc06, @test_input_ui_config06, @hash_output_ui_config06, @string_agent_config06)
    end

    def test_case_07
        #validate_test_case(@test_desc07, @test_input_ui_config07, @hash_output_ui_config07, @string_agent_config07)
    end

    def test_case_08
        #validate_test_case(@test_desc08, @test_input_ui_config08, @hash_output_ui_config08, @string_agent_config08)
    end

    def test_case_09
        #validate_test_case(@test_desc09, @test_input_ui_config09, @hash_output_ui_config09, @string_agent_config09)
    end

    def test_case_10
        #validate_test_case(@test_desc10, @test_input_ui_config10, @hash_output_ui_config10, @string_agent_config10)
    end

    def test_case_11
        #validate_test_case(@test_desc11, @test_input_ui_config11, @hash_output_ui_config11, @string_agent_config11)
    end

    def test_case_12
        #validate_test_case(@test_desc12, @test_input_ui_config12, @hash_output_ui_config12, @string_agent_config12)

        #_expectedErrorSummary = "#{NPMDConfig::AgentConfigCreator::DROP_IPS}=2 " +
        #                        "#{NPMDConfig::AgentConfigCreator::DROP_AGENTS}=1 " +
        #                        "#{NPMDConfig::AgentConfigCreator::DROP_SUBNETS}=1 " +
        #                        "#{NPMDConfig::AgentConfigCreator::DROP_NETWORKS}=1 " +
        #                        "#{NPMDConfig::AgentConfigCreator::DROP_SUBNETPAIRS}=2 " +
        #                        "#{NPMDConfig::AgentConfigCreator::DROP_RULES}=1"
        #_actualErrorSummary = NPMDConfig::AgentConfigCreator.getErrorSummary()
        #assert_equal(_expectedErrorSummary, _actualErrorSummary, "#{@test_desc12}: Mismatch in parse error drop summary")
    end

    def test_case_13
        validate_test_case(@test_desc13, @test_input_ui_config13, @hash_output_ui_config13, @string_agent_config13)
    end

    # Contract test cases
    def test_contract_01_path_data
        # Checking for valid path data case
        _validPathDataStr='{"SourceNetwork":"abcd", "SourceNetworkNodeInterface":"abcd", "SourceSubNetwork":"abcd", "DestinationNetwork":"abcd", "DestinationNetworkNodeInterface":"abcd", "DestinationSubNetwork":"abcd", "RuleName":"abcd", "TimeSinceActive":"abcd", "LossThreshold":"abcd", "LatencyThreshold":"abcd", "LossThresholdMode":"abcd", "LatencyThresholdMode":"abcd", "SubType":"NetworkPath", "HighLatency":"abcd", "MedianLatency":"abcd", "LowLatency":"abcd", "LatencyHealthState":"abcd","Loss":"abcd", "LossHealthState":"abcd", "Path":"abcd", "Computer":"abcd", "TimeGenerated":"abcd"}'
        _validPathData = JSON.parse(_validPathDataStr)
        _res, _prob = NPMContract::IsValidDataitem(_validPathData, NPMContract::DATAITEM_PATH)
        assert_equal(NPMContract::DATAITEM_VALID, _res, "Valid path data sent but validation returned invalid")

        # Checking for missing fields case
        _missingFieldsStr='{"SourceNetwork":"abcd", "SourceNetworkNodeInterface":"abcd", "SourceSubNetwork":"abcd", "DestinationNetworkNodeInterface":"abcd", "DestinationSubNetwork":"abcd", "RuleName":"abcd", "TimeSinceActive":"abcd", "LossThreshold":"abcd", "LatencyThreshold":"abcd", "LossThresholdMode":"abcd", "LatencyThresholdMode":"abcd", "SubType":"NetworkPath", "HighLatency":"abcd", "MedianLatency":"abcd", "LowLatency":"abcd", "LatencyHealthState":"abcd","Loss":"abcd", "LossHealthState":"abcd", "Path":"abcd", "Computer":"abcd", "TimeGenerated":"abcd"}'
        _missingFields = JSON.parse(_missingFieldsStr)
        _res, _prob = NPMContract::IsValidDataitem(_missingFields, NPMContract::DATAITEM_PATH)
        assert_equal(NPMContract::DATAITEM_ERR_MISSING_FIELDS, _res, "Path Data with missing fields sent but validation did not give correct error")
        assert_equal("DestinationNetwork", _prob, "Path data missing field was not properly triaged")

        # Checking for invalid fields case
        _invalidFieldsStr='{"SourceNetwork":"abcd", "SourceNetworkNodeInterface":"abcd", "SourceSubNetwork":"abcd", "DestinationNetwork":"abcd", "DestinationNetworkNodeInterface":"abcd", "DestinationSubNetwork":"abcd", "RuleName":"abcd", "TimeSinceActive":"abcd", "LossThreshold":"abcd", "LatencyThreshold":"abcd", "LossThresholdMode":"abcd", "LatencyThresholdMode":"abcd", "SubType":"NetworkPath", "HighLatency":"abcd", "MedianLatency":"abcd", "LowLatency":"abcd", "LatencyHealthState":"abcd","Loss":"abcd", "LossHealthEState":"abcd", "Path":"abcd", "Computer":"abcd", "TimeGenerated":"abcd"}'
        _invalidFields = JSON.parse(_invalidFieldsStr)
        _res, _prob = NPMContract::IsValidDataitem(_invalidFields, NPMContract::DATAITEM_PATH)
        assert_equal(NPMContract::DATAITEM_ERR_INVALID_FIELDS, _res, "Path Data with invalid fields sent but validation did not give correct error")
        assert_equal("LossHealthEState", _prob, "Path data invalid field was not properly triaged")
    end

    def test_contract_02_agent_data
        # Checking for valid agent data case
        _validAgentDataStr='{"AgentFqdn":"abcd", "AgentIP":"abcd", "AgentCapability":"abcd", "SubnetId":"abcd", "PrefixLength":"abcd", "AddressType":"abcd", "SubType":"NetworkAgent", "AgentId":"abcd", "TimeGenerated":"abcd"}'
        _validAgentData = JSON.parse(_validAgentDataStr)
        _res, _prob = NPMContract::IsValidDataitem(_validAgentData, NPMContract::DATAITEM_AGENT)
        assert_equal(NPMContract::DATAITEM_VALID, _res, "Valid agent data sent but validation returned invalid")

        # Checking for missing fields case
        _missingFieldsStr='{"AgentFqdn":"abcd", "AgentIP":"abcd", "AgentCapability":"abcd", "PrefixLength":"abcd", "AddressType":"abcd", "SubType":"NetworkAgent", "AgentId":"abcd", "TimeGenerated":"abcd"}'
        _missingFields = JSON.parse(_missingFieldsStr)
        _res, _prob = NPMContract::IsValidDataitem(_missingFields, NPMContract::DATAITEM_AGENT)
        assert_equal(NPMContract::DATAITEM_ERR_MISSING_FIELDS, _res, "Agent data with missing fields sent but validation did not give correct error")
        assert_equal("SubnetId", _prob, "Agent data missing field was not properly triaged")

        # Checking for invalid fields case
        _invalidFieldsStr='{"AgentFqdn":"abcd", "AgentIP":"abcd", "AgentCapability":"abcd", "SubnetId":"abcd", "PrefixLength":"abcd", "AddressZType":"abcd", "SubType":"NetworkAgent", "AgentId":"abcd", "TimeGenerated":"abcd"}'
        _invalidFields = JSON.parse(_invalidFieldsStr)
        _res, _prob = NPMContract::IsValidDataitem(_invalidFields, NPMContract::DATAITEM_AGENT)
        assert_equal(NPMContract::DATAITEM_ERR_INVALID_FIELDS, _res, "agent data with invalid fields sent but validation did not give correct error")
        assert_equal("AddressZType", _prob, "Agent data invalid field was not properly triaged")
    end

    def test_contract_03_diag_data
        # Checking for valid diag data case
        _validDiagDataStr='{"Message":"This is a test diagnostics log message", "SubType":"NPMDiagLnx"}'
        _validDiagData = JSON.parse(_validDiagDataStr)
        _res, _prob = NPMContract::IsValidDataitem(_validDiagData, NPMContract::DATAITEM_DIAG)
        assert_equal(NPMContract::DATAITEM_VALID, _res, "Valid diag data sent but validation returned invalid")

        # Checking for missing fields case
        _missingFieldsStr='{"SubType":"NPMDiagLnx"}'
        _missingFields = JSON.parse(_missingFieldsStr)
        _res, _prob = NPMContract::IsValidDataitem(_missingFields, NPMContract::DATAITEM_DIAG)
        assert_equal(NPMContract::DATAITEM_ERR_MISSING_FIELDS, _res, "Diag data with missing fields sent but validation did not give correct error")
        assert_equal("Message", _prob, "Diag data missing field was not properly triaged")

        # Checking for invalid fields case
        _invalidFieldsStr='{"MesSage":"This is a test diagnostics log message", "SubType":"NPMDiagLnx"}'
        _invalidFields = JSON.parse(_invalidFieldsStr)
        _res, _prob = NPMContract::IsValidDataitem(_invalidFields, NPMContract::DATAITEM_DIAG)
        assert_equal(NPMContract::DATAITEM_ERR_INVALID_FIELDS, _res, "diag data with invalid fields sent but validation did not give correct error")
        assert_equal("MesSage", _prob, "Diag data invalid field was not properly triaged")
    end

    def test_contract_04_epm_health_data
        # Checking for valid epm health data case
        _validEpmHealthDataStr = ''
        _validEpmHealthData = JSON.parse(_validEpmHealthDataStr)
        _res, _prob = NPMContract::IsValidDataitem(_validEpmHealthData, NPMContract::DATAITEM_ENDPOINT_HEALTH)
        assert_equal(NPMContract::DATAITEM_VALID, _res, "Valid Epm Health data sent but validation returned invalid")
    end

    def test_contract_05_epm_path_data
        # Checking for valid epm path data case
        _validEpmPathDataStr = ''
        _validEpmPathData = JSON.parse(_validEpmPathDataStr)
        _res, _prob = NPMContract::IsValidDataitem(_validEpmPathData, NPMContract::DATAITEM_ENDPOINT_MONITORING)
        assert_equal(NPMContract::DATAITEM_VALID, _res, "Valid Epm Path data sent but validation returned invalid")
    end

    def test_contract_06_epm_diag_data
        # Checking for valid epm diagnostic data case
        _validEpmDiagDataStr = ''
        _validEpmDiagData = JSON.parse(_validEpmDiagDataStr)
        _res, _prob = NPMContract::IsValidDataitem(_validEpmDiagData, NPMContract::DATAITEM_ENDPOINT_DIAGNOSTICS)
        assert_equal(NPMContract::DATAITEM_VALID, _res, "Valid Epm Diagnostic data sent but validation returned invalid")
    end

    def test_contract_07_er_path_data
        # Checking for valid er path data case
        _validErPathDataStr = ''
        _validErPathData = JSON.parse(_validErPathDataStr)
        _res, _prob = NPMContract::IsValidDataitem(_validErPathData, NPMContract::DATAITEM_EXROUTE_MONITORING)
        assert_equal(NPMContract::DATAITEM_VALID, _res, "Valid ER Path data sent but validation returned invalid")
    end

    def test_contract_08_cm_test_data
        # Checking for valid cm test result data case
        _validCmTestDataStr = ''
        _validCmTestData = JSON.parse(_validCmTestDataStr)
        _res, _prob = NPMContract::IsValidDataitem(_validCmTestData, NPMContract::DATAITEM_CONNECTIONMONITOR_TEST)
        assert_equal(NPMContract::DATAITEM_VALID, _res, "Valid CM Test data sent but validation returned invalid")
    end

    def test_contract_09_cm_path_data
        # Checking for valid cm path data case
        _validCmPathDataStr = ''
        _validCmPathData = JSON.parse(_validCmPathDataStr)
        _res, _prob = NPMContract::IsValidDataitem(_validCmPathData, NPMContract::DATAITEM_CONNECTIONMONITOR_PATH)
        assert_equal(NPMContract::DATAITEM_VALID, _res, "Valid CM Path data sent but validation returned invalid")
    end
end
