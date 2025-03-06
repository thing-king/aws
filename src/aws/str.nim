import strutils, options

import types

proc camelToKebab*(s: string): string =
  ## Converts camelCase or PascalCase to kebab-case with a double dash prefix
  ## Example: "thisIsAName" -> "--this-is-a-name"
  
  if s.len == 0:
    return "--"
  
  result = "--"  # Start with double dash prefix
  
  for i, c in s:
    if i == 0:
      # First character is always lowercase
      result.add(toLowerAscii(c))
    elif c in {'A'..'Z'}:
      # If uppercase, add hyphen before it and convert to lowercase
      result.add('-')
      result.add(toLowerAscii(c))
    else:
      # Otherwise just add the character
      result.add(c)

proc multipleOptionValues*[T](options: seq[T]): string =
  for option in options:
    var value = ""
    when option is string:
      value = "\"" & option & "\""
    else:
      value = $option
    result.add(value & " ")
  result = result.strip()


# $GlobalOptions
proc `$`*(globalOptions: GlobalOptions): string =
  result.add "--output json"
  if globalOptions.debug.isSome:
    result.add(" --debug " & $globalOptions.debug.get)
  if globalOptions.endpointUrl.isSome:
    result.add(" --endpoint-url " & globalOptions.endpointUrl.get)
  if globalOptions.noVerifySSL.isSome:
    result.add(" --no-verify-ssl " & $globalOptions.noVerifySSL.get)
  if globalOptions.noPaginate.isSome:
    result.add(" --no-paginate " & $globalOptions.noPaginate.get)
  if globalOptions.query.isSome:
    result.add(" --query " & globalOptions.query.get)
  if globalOptions.profile.isSome:
    result.add(" --profile " & globalOptions.profile.get)
  if globalOptions.region.isSome:
    result.add(" --region " & globalOptions.region.get)
  if globalOptions.version.isSome:
    result.add(" --version " & globalOptions.version.get)
  if globalOptions.noSignRequest.isSome:
    result.add(" --no-sign-request " & $globalOptions.noSignRequest.get)
  if globalOptions.caBundle.isSome:
    result.add(" --ca-bundle " & globalOptions.caBundle.get)
  if globalOptions.cliReadTimeout.isSome:
    result.add(" --cli-read-timeout " & $globalOptions.cliReadTimeout.get)
  if globalOptions.cliConnectTimeout.isSome:
    result.add(" --cli-connect-timeout " & $globalOptions.cliConnectTimeout.get)

# $Filter
proc `$`*(filter: Filter): string =
  result = "Name=" & $filter.Name & ",Values="
  for value in filter.Values:
    result.add(value & ",")
  result = result[0..^2]
# $Filters
proc `$`*(filters: Filters): string =
  result = ""
  for filter in filters:
    result.add($filter & " ")
  result = result.strip()


proc `$`*(ebs: Ebs): string =
  # result = "DeleteOnTermination=" & $ebs.DeleteOnTermination & ",Iops=" & $ebs.Iops & ",SnapshotId=" & $ebs.SnapshotId & ",VolumeSize=" & $ebs.VolumeSize & ",VolumeType=" & $ebs.VolumeType & ",KmsKeyId=" & $ebs.KmsKeyId & ",Throughput=" & $ebs.Throughput & ",OutpostArn=" & $ebs.OutpostArn & ",Encrypted=" & $ebs.Encrypted
  if ebs.DeleteOnTermination.isSome:
    result.add("DeleteOnTermination=" & $ebs.DeleteOnTermination.get & ",")
  if ebs.Iops.isSome:
    result.add("Iops=" & $ebs.Iops.get & ",")
  if ebs.SnapshotId.isSome:
    result.add("SnapshotId=" & $ebs.SnapshotId.get & ",")
  if ebs.VolumeSize.isSome:
    result.add("VolumeSize=" & $ebs.VolumeSize.get & ",")
  if ebs.VolumeType.isSome:
    result.add("VolumeType=" & $ebs.VolumeType.get & ",")
  if ebs.KmsKeyId.isSome:
    result.add("KmsKeyId=" & $ebs.KmsKeyId.get & ",")
  if ebs.Throughput.isSome:
    result.add("Throughput=" & $ebs.Throughput.get & ",")
  if ebs.OutpostArn.isSome:
    result.add("OutpostArn=" & $ebs.OutpostArn.get & ",")
  if ebs.Encrypted.isSome:
    result.add("Encrypted=" & $ebs.Encrypted.get & ",")
  result = result[0..^2]


proc `$`*(bdm: BlockDeviceMappings): string =
  # result = "Ebs={" & $bdm.Ebs & "},NoDevice=" & $bdm.NoDevice & ",DeviceName=" & $bdm.DeviceName & ",VirtualName=" & $bdm.VirtualName
  result = "Ebs{" & $bdm.Ebs & "},"
  if bdm.NoDevice.isSome:
    result.add("NoDevice=" & $bdm.NoDevice.get & ",")
  if bdm.DeviceName.isSome:
    result.add("DeviceName=" & $bdm.DeviceName.get & ",")
  if bdm.VirtualName.isSome:
    result.add("VirtualName=" & $bdm.VirtualName.get & ",")
  result = result[0..^2]

proc `$`*(ipv6Address: Ipv6Address): string =
  result = "Ipv6Address=" & $ipv6Address.Ipv6Address & ",IsPrimaryIpv6=" & $ipv6Address.IsPrimaryIpv6
proc `$`*(ipv6Addresses: seq[Ipv6Address]): string =
  result = ""
  for ipv6Address in ipv6Addresses:
    result.add($ipv6Address & " ")
  result = result.strip()

proc `$`*(monitoringEnabled: MonitoringEnabled): string =
  result = "Enabled=" & $monitoringEnabled.Enabled

proc `$`*(elasticGpuSpecification: ElasticGpuSpecification): string =
  result = "Type=" & $elasticGpuSpecification.Type
proc `$`*(elasticInferenceAccelerator: ElasticInferenceAccelerator): string =
  result = "Type=" & $elasticInferenceAccelerator.Type & ",Count=" & $elasticInferenceAccelerator.Count


proc `$`*(tag: Tag): string =
  result = "Key=" & $tag.Key & ",Value=" & $tag.Value
proc `$`*(tagSpecification: TagSpecification): string =
  result = "ResourceType=" & $tagSpecification.ResourceType & ",Tags=["
  for tag in tagSpecification.Tags:
    result.add("{" & $tag & "},")
  result = result[0..^2] & "]"

proc `$`*(launchTemplate: LaunchTemplate): string =
  if launchTemplate.LaunchTemplateId.isSome:
    result.add("LaunchTemplateId=" & $launchTemplate.LaunchTemplateId.get & ",")
  if launchTemplate.LaunchTemplateName.isSome:
    result.add("LaunchTemplateName=" & $launchTemplate.LaunchTemplateName.get & ",")
  if launchTemplate.LaunchTemplateId.isNone and launchTemplate.LaunchTemplateName.isNone:
    raise newException(ValueError, "Either `LaunchTemplateId` or `LaunchTemplateName` must be provided")
  result = result & "Version=" & $launchTemplate.Version
  

proc `$`*(spotOptions: SpotMarketOptions): string =
  result = "MaxPrice=" & $spotOptions.MaxPrice & ",SpotInstanceType=" & $spotOptions.SpotInstanceType
  if spotOptions.BlockDurationMinutes.isSome:
    result.add(",BlockDurationMinutes=" & $spotOptions.BlockDurationMinutes.get)
  if spotOptions.InstanceInterruptionBehavior.isSome:
    result.add(",InstanceInterruptionBehavior=" & $spotOptions.InstanceInterruptionBehavior.get)
  if spotOptions.ValidUntil.isSome:
    result.add(",ValidUntil=" & $spotOptions.ValidUntil.get)
  if spotOptions.InstanceInterruptionBehavior.isSome:
    result.add(",InstanceInterruptionBehavior=" & $spotOptions.InstanceInterruptionBehavior.get)
proc `$`*(instanceMarketOptions: InstanceMarketOptions): string =
  result = "MarketType=" & $instanceMarketOptions.MarketType
  if instanceMarketOptions.SpotOptions.isSome:
    result.add(",SpotOptions={" & $instanceMarketOptions.SpotOptions.get & "}")
  
proc `$`*(creditSpecification: CreditSpecification): string =
  result = "CpuCredits=" & $creditSpecification.CpuCredits

proc `$`*(cpuOptions: CpuOptions): string =
  result = "CoreCount=" & $cpuOptions.CoreCount & ",ThreadsPerCore=" & $cpuOptions.ThreadsPerCore & ",AmdSevSnp=" & $cpuOptions.AmdSevSnp


proc `$`*(capacityReservationTarget: CapacityReservationTarget): string =
  result = "CapacityReservationId=" & $capacityReservationTarget.CapacityReservationId & ",CapacityReservationResourceGroupArn=" & $capacityReservationTarget.CapacityReservationResourceGroupArn
proc `$`*(capacityReservationSpecification: CapacityReservationSpecification): string =
  result = "CapacityReservationPreference=" & $capacityReservationSpecification.CapacityReservationPreference
  if capacityReservationSpecification.CapacityReservationTarget.isSome:
    result.add(",CapacityReservationTarget={" & $capacityReservationSpecification.CapacityReservationTarget.get & "}")

proc `$`*(hibernationOptions: HibernationOptions): string =
  result = "Configured=" & $hibernationOptions.Configured

proc `$`*(licenseSpecification: LicenseSpecification): string =
  result = "LicenseConfigurationArn=" & $licenseSpecification.LicenseConfigurationArn
proc `$`*(licenseSpecifications: LicenseSpecifications): string =
  result = ""
  for licenseSpecification in licenseSpecifications:
    result.add($licenseSpecification & " ")
  result = result.strip()

proc `$`*(metadataOptions: MetadataOptions): string =
  if metadataOptions.State.isSome:
    result.add("State=" & $metadataOptions.State.get & ",")
  if metadataOptions.HttpTokens.isSome:
    result.add("HttpTokens=" & $metadataOptions.HttpTokens.get & ",")
  if metadataOptions.HttpPutResponseHopLimit.isSome:
    result.add("HttpPutResponseHopLimit=" & $metadataOptions.HttpPutResponseHopLimit.get & ",")
  if metadataOptions.HttpEndpoint.isSome:
    result.add("HttpEndpoint=" & $metadataOptions.HttpEndpoint.get & ",")
  if metadataOptions.HttpProtocolIpv6.isSome:
    result.add("HttpProtocolIpv6=" & $metadataOptions.HttpProtocolIpv6.get & ",")
  if metadataOptions.InstanceMetadataTags.isSome:
    result.add("InstanceMetadataTags=" & $metadataOptions.InstanceMetadataTags.get & ",")
  if metadataOptions.State.isNone and metadataOptions.HttpTokens.isNone and metadataOptions.HttpPutResponseHopLimit.isNone and metadataOptions.HttpEndpoint.isNone and metadataOptions.HttpProtocolIpv6.isNone and metadataOptions.InstanceMetadataTags.isNone:
    raise newException(ValueError, "At least one of the following must be provided: `State`, `HttpTokens`, `HttpPutResponseHopLimit`, `HttpEndpoint`, `HttpProtocolIpv6`, `InstanceMetadataTags`")
  result = result[0..^2]

proc `$`*(enclaveOptions: EnclaveOptions): string =
  result = "Enabled=" & $enclaveOptions.Enabled

proc `$`*(privateDNSNameOptions: PrivateDNSNameOptions): string =
  result = "HostnameType=" & $privateDNSNameOptions.HostnameType & ",EnableResourceNameDnsARecord=" & $privateDNSNameOptions.EnableResourceNameDnsARecord & ",EnableResourceNameDnsAAAARecord=" & $privateDNSNameOptions.EnableResourceNameDnsAAAARecord

proc `$`*(maintenanceOptions: MaintenanceOptions): string =
  result = "AutoRecovery=" & $maintenanceOptions.AutoRecovery

proc `$`*(networkPerformanceOptions: NetworkPerformanceOptions): string =
  result = "BandwidthWeighting=" & $networkPerformanceOptions.BandwidthWeighting


proc `$`*(enaSrdUdpSpecification: EnaSrdUdpSpecification): string =
  result = "EnaSrdUdpEnabled=" & $enaSrdUdpSpecification.EnaSrdUdpEnabled
proc `$`*(enaSrdSpecification: EnaSrdSpecification): string =
  result = "EnaSrdEnabled=" & $enaSrdSpecification.EnaSrdEnabled
  if enaSrdSpecification.EnaSrdUdpSpecification.isSome:
    result.add(",EnaSrdUdpSpecification={" & $enaSrdSpecification.EnaSrdUdpSpecification.get & "}")
proc `$`*(connectionTrackingSpecification: ConnectionTrackingSpecification): string =
  if connectionTrackingSpecification.TcpEstablishedTimeout.isSome:
    result.add("TcpEstablishedTimeout=" & $connectionTrackingSpecification.TcpEstablishedTimeout.get & ",")
  if connectionTrackingSpecification.UdpStreamTimeout.isSome:
    result.add("UdpStreamTimeout=" & $connectionTrackingSpecification.UdpStreamTimeout.get & ",")
  if connectionTrackingSpecification.UdpTimeout.isSome:
    result.add("UdpTimeout=" & $connectionTrackingSpecification.UdpTimeout.get & ",")
  result = result[0..^2]

proc `$`*(iamInstanceProfile: IamInstanceProfile): string =
  result = "Arn=" & $iamInstanceProfile.Arn & ",Name=" & $iamInstanceProfile.Name

proc `$`*(optionNetworkInterface: OptionNetworkInterface): string =
  if optionNetworkInterface.AssociatePublicIpAddress.isSome:
    result.add("AssociatePublicIpAddress=" & $optionNetworkInterface.AssociatePublicIpAddress.get & ",")
  if optionNetworkInterface.DeleteOnTermination.isSome:
    result.add("DeleteOnTermination=" & $optionNetworkInterface.DeleteOnTermination.get & ",")
  if optionNetworkInterface.Description.isSome:
    result.add("Description=" & $optionNetworkInterface.Description.get & ",")
  if optionNetworkInterface.DeviceIndex.isSome:
    result.add("DeviceIndex=" & $optionNetworkInterface.DeviceIndex.get & ",")
  if optionNetworkInterface.Groups.isSome:
    var groups = ""
    for group in optionNetworkInterface.Groups.get:
      groups.add(group & ",")
    groups = groups[0..^2]
    result.add("Groups=" & groups)
  if optionNetworkInterface.Ipv6AddressCount.isSome:
    result.add("Ipv6AddressCount=" & $optionNetworkInterface.Ipv6AddressCount.get & ",")
  if optionNetworkInterface.Ipv6Addresses.isSome:
    var ipv6Addresses = "["
    for ipv6Address in optionNetworkInterface.Ipv6Addresses.get:
      ipv6Addresses.add("{" & $ipv6Address & "},")
    ipv6Addresses = ipv6Addresses[0..^2] & "]"
    result.add("Ipv6Addresses=" & ipv6Addresses & ",")
  if optionNetworkInterface.NetworkInterfaceId.isSome:
    result.add("NetworkInterfaceId=" & $optionNetworkInterface.NetworkInterfaceId.get & ",")
  if optionNetworkInterface.PrivateIpAddress.isSome:
    result.add("PrivateIpAddress=" & $optionNetworkInterface.PrivateIpAddress.get & ",")
  if optionNetworkInterface.PrivateIpAddresses.isSome:
    var privateIpAddresses = "["
    for privateIpAddress in optionNetworkInterface.PrivateIpAddresses.get:
      privateIpAddresses.add("{" & $privateIpAddress & "},")
    privateIpAddresses = privateIpAddresses[0..^2] & "]"
    result.add("PrivateIpAddresses=" & privateIpAddresses & ",")
  if optionNetworkInterface.SecondaryPrivateIpAddressCount.isSome:
    result.add("SecondaryPrivateIpAddressCount=" & $optionNetworkInterface.SecondaryPrivateIpAddressCount.get & ",")
  if optionNetworkInterface.SubnetId.isSome:
    result.add("SubnetId=" & $optionNetworkInterface.SubnetId.get & ",")
  if optionNetworkInterface.AssociateCarrierIpAddress.isSome:
    result.add("AssociateCarrierIpAddress=" & $optionNetworkInterface.AssociateCarrierIpAddress.get & ",")
  if optionNetworkInterface.InterfaceType.isSome:
    result.add("InterfaceType=" & $optionNetworkInterface.InterfaceType.get & ",")
  if optionNetworkInterface.NetworkCardIndex.isSome:
    result.add("NetworkCardIndex=" & $optionNetworkInterface.NetworkCardIndex.get & ",")
  if optionNetworkInterface.Ipv4Prefixes.isSome:
    var ipv4Prefixes = "["
    for ipv4Prefix in optionNetworkInterface.Ipv4Prefixes.get:
      ipv4Prefixes.add("{" & $ipv4Prefix & "},")
    ipv4Prefixes = ipv4Prefixes[0..^2] & "]"
    result.add("Ipv4Prefixes=" & ipv4Prefixes & ",")
  if optionNetworkInterface.Ipv6Prefixes.isSome:
    var ipv6Prefixes = "["
    for ipv6Prefix in optionNetworkInterface.Ipv6Prefixes.get:
      ipv6Prefixes.add("{" & $ipv6Prefix & "},")
    ipv6Prefixes = ipv6Prefixes[0..^2] & "]"
    result.add("Ipv6Prefixes=" & ipv6Prefixes & ",")
  if optionNetworkInterface.Ipv4PrefixCount.isSome:
    result.add("Ipv4PrefixesCount=" & $optionNetworkInterface.Ipv4PrefixCount.get & ",")
  if optionNetworkInterface.Ipv6PrefixCount.isSome:
    result.add("Ipv6PrefixesCount=" & $optionNetworkInterface.Ipv6PrefixCount.get & ",")
  if optionNetworkInterface.PrimaryIpv6.isSome:
    result.add("PrimaryIpv6=" & $optionNetworkInterface.PrimaryIpv6.get & ",")
  if optionNetworkInterface.EnaSrdSpecification.isSome:
    result.add("EnaSrdSpecification=" & $optionNetworkInterface.EnaSrdSpecification.get & ",")
  if optionNetworkInterface.ConnectionTrackingSpecification.isSome:
    result.add("ConnectionTrackingSpecification=" & $optionNetworkInterface.ConnectionTrackingSpecification.get & ",")