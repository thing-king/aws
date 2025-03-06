import options
import jsony_plus


# Global Options
type
  GlobalOptions* = object
    debug*: Option[bool]
    endpointUrl*: Option[string]
    noVerifySSL*: Option[bool]
    noPaginate*: Option[bool]
    query*: Option[string]
    profile*: Option[string]
    region*: Option[string]
    version*: Option[string]
    noSignRequest*: Option[bool]
    caBundle*: Option[string]
    cliReadTimeout*: Option[int]
    cliConnectTimeout*: Option[int]

type
  FilterName* = enum
    filterAffinity                                     = "affinity"
    filterArchitecture                                 = "architecture"
    filterAvailabilityZone                             = "availability-zone"
    filterBlockDeviceMappingAttachTime                 = "block-device-mapping.attach-time"
    filterBlockDeviceMappingDeleteOnTermination        = "block-device-mapping.delete-on-termination"
    filterBlockDeviceMappingDeviceName                 = "block-device-mapping.device-name"
    filterBlockDeviceMappingStatus                     = "block-device-mapping.status"
    filterBlockDeviceMappingVolumeId                   = "block-device-mapping.volume-id"
    filterBootMode                                     = "boot-mode"
    filterCapacityReservationId                        = "capacity-reservation-id"
    filterCapacityReservationSpecificationPreference   = "capacity-reservation-specification.capacity-reservation-preference"
    filterCapacityReservationTargetId                  = "capacity-reservation-specification.capacity-reservation-target.capacity-reservation-id"
    filterCapacityReservationTargetGroupArn            = "capacity-reservation-specification.capacity-reservation-target.capacity-reservation-resource-group-arn"
    filterClientToken                                  = "client-token"
    filterCurrentInstanceBootMode                      = "current-instance-boot-mode"
    filterDnsName                                      = "dns-name"
    filterEbsOptimized                                 = "ebs-optimized"
    filterEnaSupport                                   = "ena-support"
    filterEnclaveOptionsEnabled                        = "enclave-options.enabled"
    filterHibernationOptionsConfigured                 = "hibernation-options.configured"
    filterHostId                                       = "host-id"
    filterHypervisor                                   = "hypervisor"
    filterIamInstanceProfileArn                        = "iam-instance-profile.arn"
    filterIamInstanceProfileId                         = "iam-instance-profile.id"
    filterImageId                                      = "image-id"
    filterInstanceId                                   = "instance-id"
    filterInstanceLifecycle                            = "instance-lifecycle"
    filterInstanceStateCode                            = "instance-state-code"
    filterInstanceStateName                            = "instance-state-name"
    filterInstanceType                                 = "instance-type"
    filterInstanceGroupId                              = "instance.group-id"
    filterInstanceGroupName                            = "instance.group-name"
    filterIpAddress                                    = "ip-address"
    filterIpv6Address                                  = "ipv6-address"
    filterKernelId                                     = "kernel-id"
    filterKeyName                                      = "key-name"
    filterLaunchIndex                                  = "launch-index"
    filterLaunchTime                                   = "launch-time"
    filterMaintenanceOptionsAutoRecovery               = "maintenance-options.auto-recovery"
    filterMetadataOptionsHttpEndpoint                  = "metadata-options.http-endpoint"
    filterMetadataOptionsHttpProtocolIpv4              = "metadata-options.http-protocol-ipv4"
    filterMetadataOptionsHttpProtocolIpv6              = "metadata-options.http-protocol-ipv6"
    filterMetadataOptionsHttpPutResponseHopLimit       = "metadata-options.http-put-response-hop-limit"
    filterMetadataOptionsHttpTokens                    = "metadata-options.http-tokens"
    filterMetadataOptionsInstanceMetadataTags          = "metadata-options.instance-metadata-tags"
    filterMetadataOptionsState                         = "metadata-options.state"
    filterMonitoringState                              = "monitoring-state"
    filterNetworkInterfaceId                           = "network-interface.network-interface-id"
    filterNetworkInterfaceStatus                       = "network-interface.status"
    filterNetworkInterfaceSubnetId                     = "network-interface.subnet-id"
    filterNetworkInterfaceVpcId                        = "network-interface.vpc-id"
    filterNetworkInterfaceMacAddress                   = "network-interface.mac-address"
    filterNetworkInterfacePrivateDnsName               = "network-interface.private-dns-name"
    filterNetworkInterfacePrivateIpAddress             = "network-interface.private-ip-address"
    filterNetworkInterfacePublicDnsName                = "network-interface.public-dns-name"
    filterNetworkInterfaceRequesterId                  = "network-interface.requester-id"
    filterNetworkInterfaceSourceDestCheck              = "network-interface.source-dest-check"
    filterNetworkPerformanceOptionsBandwidthWeighting  = "network-performance-options.bandwidth-weighting"
    filterOperatorManaged                              = "operator.managed"
    filterOperatorPrincipal                            = "operator.principal"
    filterOutpostArn                                   = "outpost-arn"
    filterOwnerId                                      = "owner-id"
    filterPlacementGroupName                           = "placement-group-name"
    filterPlacementPartitionNumber                     = "placement-partition-number"
    filterPlatform                                     = "platform"
    filterPlatformDetails                              = "platform-details"
    filterPrivateDnsName                               = "private-dns-name"
    filterPrivateIpAddress                             = "private-ip-address"
    filterProductCode                                  = "product-code"
    filterProductCodeType                              = "product-code.type"
    filterRamdiskId                                    = "ramdisk-id"
    filterReason                                       = "reason"
    filterRequesterId                                  = "requester-id"
    filterReservationId                                = "reservation-id"
    filterRootDeviceName                               = "root-device-name"
    filterRootDeviceType                               = "root-device-type"
    filterSourceDestCheck                              = "source-dest-check"
    filterSpotInstanceRequestId                        = "spot-instance-request-id"
    filterStateReasonCode                              = "state-reason-code"
    filterStateReasonMessage                           = "state-reason-message"
    filterSubnetId                                     = "subnet-id"
    filterTagKey                                       = "tag-key"
    filterTenancy                                      = "tenancy"
    filterTpmSupport                                   = "tpm-support"
    filterUsageOperation                               = "usage-operation"
    filterUsageOperationUpdateTime                     = "usage-operation-update-time"
    filterVirtualizationType                           = "virtualization-type"
    filterVpcId                                        = "vpc-id"

  Filter* = object
    Name*: FilterName
    Values*: seq[string]
  
  Filters* = seq[Filter]


# ec2/run-instances
type
  InstanceType* = enum
    # A series
    a1_medium = "a1.medium"
    a1_large = "a1.large"
    a1_xlarge = "a1.xlarge"
    a1_2xlarge = "a1.2xlarge"
    a1_4xlarge = "a1.4xlarge"
    a1_metal = "a1.metal"
    
    # T series
    t2_nano = "t2.nano"
    t2_micro = "t2.micro"
    t2_small = "t2.small"
    t2_medium = "t2.medium"
    t2_large = "t2.large"
    t2_xlarge = "t2.xlarge"
    t2_2xlarge = "t2.2xlarge"
    t3_nano = "t3.nano"
    t3_micro = "t3.micro"
    t3_small = "t3.small"
    t3_medium = "t3.medium"
    t3_large = "t3.large"
    t3_xlarge = "t3.xlarge"
    t3_2xlarge = "t3.2xlarge"
    t3a_nano = "t3a.nano"
    t3a_micro = "t3a.micro"
    t3a_small = "t3a.small"
    t3a_medium = "t3a.medium"
    t3a_large = "t3a.large"
    t3a_xlarge = "t3a.xlarge"
    t3a_2xlarge = "t3a.2xlarge"
    t4g_nano = "t4g.nano"
    t4g_micro = "t4g.micro"
    t4g_small = "t4g.small"
    t4g_medium = "t4g.medium"
    t4g_large = "t4g.large"
    t4g_xlarge = "t4g.xlarge"
    t4g_2xlarge = "t4g.2xlarge"

    # C series
    c1_medium = "c1.medium"
    c1_xlarge = "c1.xlarge"
    c3_large = "c3.large"
    c3_xlarge = "c3.xlarge"
    c3_2xlarge = "c3.2xlarge"
    c3_4xlarge = "c3.4xlarge"
    c3_8xlarge = "c3.8xlarge"
    c4_large = "c4.large"
    c4_xlarge = "c4.xlarge"
    c4_2xlarge = "c4.2xlarge"
    c4_4xlarge = "c4.4xlarge"
    c4_8xlarge = "c4.8xlarge"
    c5_large = "c5.large"
    c5_xlarge = "c5.xlarge"
    c5_2xlarge = "c5.2xlarge"
    c5_4xlarge = "c5.4xlarge"
    c5_9xlarge = "c5.9xlarge"
    c5_12xlarge = "c5.12xlarge"
    c5_18xlarge = "c5.18xlarge"
    c5_24xlarge = "c5.24xlarge"
    c5_metal = "c5.metal"
    c5a_large = "c5a.large"
    c5a_xlarge = "c5a.xlarge"
    c5a_2xlarge = "c5a.2xlarge"
    c5a_4xlarge = "c5a.4xlarge"
    c5a_8xlarge = "c5a.8xlarge"
    c5a_12xlarge = "c5a.12xlarge"
    c5a_16xlarge = "c5a.16xlarge"
    c5a_24xlarge = "c5a.24xlarge"
    c5ad_large = "c5ad.large"
    c5ad_xlarge = "c5ad.xlarge"
    c5ad_2xlarge = "c5ad.2xlarge"
    c5ad_4xlarge = "c5ad.4xlarge"
    c5ad_8xlarge = "c5ad.8xlarge"
    c5ad_12xlarge = "c5ad.12xlarge"
    c5ad_16xlarge = "c5ad.16xlarge"
    c5ad_24xlarge = "c5ad.24xlarge"
    c5d_large = "c5d.large"
    c5d_xlarge = "c5d.xlarge"
    c5d_2xlarge = "c5d.2xlarge"
    c5d_4xlarge = "c5d.4xlarge"
    c5d_9xlarge = "c5d.9xlarge"
    c5d_12xlarge = "c5d.12xlarge"
    c5d_18xlarge = "c5d.18xlarge"
    c5d_24xlarge = "c5d.24xlarge"
    c5d_metal = "c5d.metal"
    c5n_large = "c5n.large"
    c5n_xlarge = "c5n.xlarge"
    c5n_2xlarge = "c5n.2xlarge"
    c5n_4xlarge = "c5n.4xlarge"
    c5n_9xlarge = "c5n.9xlarge"
    c5n_18xlarge = "c5n.18xlarge"
    c5n_metal = "c5n.metal"
    c6g_medium = "c6g.medium"
    c6g_large = "c6g.large"
    c6g_xlarge = "c6g.xlarge"
    c6g_2xlarge = "c6g.2xlarge"
    c6g_4xlarge = "c6g.4xlarge"
    c6g_8xlarge = "c6g.8xlarge"
    c6g_12xlarge = "c6g.12xlarge"
    c6g_16xlarge = "c6g.16xlarge"
    c6g_metal = "c6g.metal"
    c6gd_medium = "c6gd.medium"
    c6gd_large = "c6gd.large"
    c6gd_xlarge = "c6gd.xlarge"
    c6gd_2xlarge = "c6gd.2xlarge"
    c6gd_4xlarge = "c6gd.4xlarge"
    c6gd_8xlarge = "c6gd.8xlarge"
    c6gd_12xlarge = "c6gd.12xlarge"
    c6gd_16xlarge = "c6gd.16xlarge"
    c6gd_metal = "c6gd.metal"
    c6gn_medium = "c6gn.medium"
    c6gn_large = "c6gn.large"
    c6gn_xlarge = "c6gn.xlarge"
    c6gn_2xlarge = "c6gn.2xlarge"
    c6gn_4xlarge = "c6gn.4xlarge"
    c6gn_8xlarge = "c6gn.8xlarge"
    c6gn_12xlarge = "c6gn.12xlarge"
    c6gn_16xlarge = "c6gn.16xlarge"
    c6i_large = "c6i.large"
    c6i_xlarge = "c6i.xlarge"
    c6i_2xlarge = "c6i.2xlarge"
    c6i_4xlarge = "c6i.4xlarge"
    c6i_8xlarge = "c6i.8xlarge"
    c6i_12xlarge = "c6i.12xlarge"
    c6i_16xlarge = "c6i.16xlarge"
    c6i_24xlarge = "c6i.24xlarge"
    c6i_32xlarge = "c6i.32xlarge"
    c6i_metal = "c6i.metal"
    c6a_large = "c6a.large"
    c6a_xlarge = "c6a.xlarge"
    c6a_2xlarge = "c6a.2xlarge"
    c6a_4xlarge = "c6a.4xlarge"
    c6a_8xlarge = "c6a.8xlarge"
    c6a_12xlarge = "c6a.12xlarge"
    c6a_16xlarge = "c6a.16xlarge"
    c6a_24xlarge = "c6a.24xlarge"
    c6a_32xlarge = "c6a.32xlarge"
    c6a_48xlarge = "c6a.48xlarge"
    c6a_metal = "c6a.metal"
    c6id_large = "c6id.large"
    c6id_xlarge = "c6id.xlarge"
    c6id_2xlarge = "c6id.2xlarge"
    c6id_4xlarge = "c6id.4xlarge"
    c6id_8xlarge = "c6id.8xlarge"
    c6id_12xlarge = "c6id.12xlarge"
    c6id_16xlarge = "c6id.16xlarge"
    c6id_24xlarge = "c6id.24xlarge"
    c6id_32xlarge = "c6id.32xlarge"
    c6id_metal = "c6id.metal"
    c6in_large = "c6in.large"
    c6in_xlarge = "c6in.xlarge"
    c6in_2xlarge = "c6in.2xlarge"
    c6in_4xlarge = "c6in.4xlarge"
    c6in_8xlarge = "c6in.8xlarge"
    c6in_12xlarge = "c6in.12xlarge"
    c6in_16xlarge = "c6in.16xlarge"
    c6in_24xlarge = "c6in.24xlarge"
    c6in_32xlarge = "c6in.32xlarge"
    c6in_metal = "c6in.metal"
    c7g_medium = "c7g.medium"
    c7g_large = "c7g.large"
    c7g_xlarge = "c7g.xlarge"
    c7g_2xlarge = "c7g.2xlarge"
    c7g_4xlarge = "c7g.4xlarge"
    c7g_8xlarge = "c7g.8xlarge"
    c7g_12xlarge = "c7g.12xlarge"
    c7g_16xlarge = "c7g.16xlarge"
    c7g_metal = "c7g.metal"
    c7gd_medium = "c7gd.medium"
    c7gd_large = "c7gd.large"
    c7gd_xlarge = "c7gd.xlarge"
    c7gd_2xlarge = "c7gd.2xlarge"
    c7gd_4xlarge = "c7gd.4xlarge"
    c7gd_8xlarge = "c7gd.8xlarge"
    c7gd_12xlarge = "c7gd.12xlarge"
    c7gd_16xlarge = "c7gd.16xlarge"
    c7gd_metal = "c7gd.metal"
    c7gn_medium = "c7gn.medium"
    c7gn_large = "c7gn.large"
    c7gn_xlarge = "c7gn.xlarge"
    c7gn_2xlarge = "c7gn.2xlarge"
    c7gn_4xlarge = "c7gn.4xlarge"
    c7gn_8xlarge = "c7gn.8xlarge"
    c7gn_12xlarge = "c7gn.12xlarge"
    c7gn_16xlarge = "c7gn.16xlarge"
    c7gn_metal = "c7gn.metal"
    c7i_large = "c7i.large"
    c7i_xlarge = "c7i.xlarge"
    c7i_2xlarge = "c7i.2xlarge"
    c7i_4xlarge = "c7i.4xlarge"
    c7i_8xlarge = "c7i.8xlarge"
    c7i_12xlarge = "c7i.12xlarge"
    c7i_16xlarge = "c7i.16xlarge"
    c7i_24xlarge = "c7i.24xlarge"
    c7i_48xlarge = "c7i.48xlarge"
    c7i_metal_24xl = "c7i.metal-24xl"
    c7i_metal_48xl = "c7i.metal-48xl"
    c7i_flex_large = "c7i-flex.large"
    c7i_flex_xlarge = "c7i-flex.xlarge"
    c7i_flex_2xlarge = "c7i-flex.2xlarge"
    c7i_flex_4xlarge = "c7i-flex.4xlarge"
    c7i_flex_8xlarge = "c7i-flex.8xlarge"
    c7a_medium = "c7a.medium"
    c7a_large = "c7a.large"
    c7a_xlarge = "c7a.xlarge"
    c7a_2xlarge = "c7a.2xlarge"
    c7a_4xlarge = "c7a.4xlarge"
    c7a_8xlarge = "c7a.8xlarge"
    c7a_12xlarge = "c7a.12xlarge"
    c7a_16xlarge = "c7a.16xlarge"
    c7a_24xlarge = "c7a.24xlarge"
    c7a_32xlarge = "c7a.32xlarge"
    c7a_48xlarge = "c7a.48xlarge"
    c7a_metal_48xl = "c7a.metal-48xl"
    c8g_medium = "c8g.medium"
    c8g_large = "c8g.large"
    c8g_xlarge = "c8g.xlarge"
    c8g_2xlarge = "c8g.2xlarge"
    c8g_4xlarge = "c8g.4xlarge"
    c8g_8xlarge = "c8g.8xlarge"
    c8g_12xlarge = "c8g.12xlarge"
    c8g_16xlarge = "c8g.16xlarge"
    c8g_24xlarge = "c8g.24xlarge"
    c8g_48xlarge = "c8g.48xlarge"
    c8g_metal_24xl = "c8g.metal-24xl"
    c8g_metal_48xl = "c8g.metal-48xl"
    
    # CC series
    cc1_4xlarge = "cc1.4xlarge"
    cc2_8xlarge = "cc2.8xlarge"
    
    # CG series
    cg1_4xlarge = "cg1.4xlarge"
    
    # CR series
    cr1_8xlarge = "cr1.8xlarge"
    
    # D series
    d2_xlarge = "d2.xlarge"
    d2_2xlarge = "d2.2xlarge"
    d2_4xlarge = "d2.4xlarge"
    d2_8xlarge = "d2.8xlarge"
    d3_xlarge = "d3.xlarge"
    d3_2xlarge = "d3.2xlarge"
    d3_4xlarge = "d3.4xlarge"
    d3_8xlarge = "d3.8xlarge"
    d3en_xlarge = "d3en.xlarge"
    d3en_2xlarge = "d3en.2xlarge"
    d3en_4xlarge = "d3en.4xlarge"
    d3en_6xlarge = "d3en.6xlarge"
    d3en_8xlarge = "d3en.8xlarge"
    d3en_12xlarge = "d3en.12xlarge"
    
    # DL series
    dl1_24xlarge = "dl1.24xlarge"
    dl2q_24xlarge = "dl2q.24xlarge"
    
    # F series
    f1_2xlarge = "f1.2xlarge"
    f1_4xlarge = "f1.4xlarge"
    f1_16xlarge = "f1.16xlarge"
    f2_12xlarge = "f2.12xlarge"
    f2_48xlarge = "f2.48xlarge"
    
    # G series
    g2_2xlarge = "g2.2xlarge"
    g2_8xlarge = "g2.8xlarge"
    g3_4xlarge = "g3.4xlarge"
    g3_8xlarge = "g3.8xlarge"
    g3_16xlarge = "g3.16xlarge"
    g3s_xlarge = "g3s.xlarge"
    g4ad_xlarge = "g4ad.xlarge"
    g4ad_2xlarge = "g4ad.2xlarge"
    g4ad_4xlarge = "g4ad.4xlarge"
    g4ad_8xlarge = "g4ad.8xlarge"
    g4ad_16xlarge = "g4ad.16xlarge"
    g4dn_xlarge = "g4dn.xlarge"
    g4dn_2xlarge = "g4dn.2xlarge"
    g4dn_4xlarge = "g4dn.4xlarge"
    g4dn_8xlarge = "g4dn.8xlarge"
    g4dn_12xlarge = "g4dn.12xlarge"
    g4dn_16xlarge = "g4dn.16xlarge"
    g4dn_metal = "g4dn.metal"
    g5_xlarge = "g5.xlarge"
    g5_2xlarge = "g5.2xlarge"
    g5_4xlarge = "g5.4xlarge"
    g5_8xlarge = "g5.8xlarge"
    g5_12xlarge = "g5.12xlarge"
    g5_16xlarge = "g5.16xlarge"
    g5_24xlarge = "g5.24xlarge"
    g5_48xlarge = "g5.48xlarge"
    g5g_xlarge = "g5g.xlarge"
    g5g_2xlarge = "g5g.2xlarge"
    g5g_4xlarge = "g5g.4xlarge"
    g5g_8xlarge = "g5g.8xlarge"
    g5g_16xlarge = "g5g.16xlarge"
    g5g_metal = "g5g.metal"
    g6_xlarge = "g6.xlarge"
    g6_2xlarge = "g6.2xlarge"
    g6_4xlarge = "g6.4xlarge"
    g6_8xlarge = "g6.8xlarge"
    g6_12xlarge = "g6.12xlarge"
    g6_16xlarge = "g6.16xlarge"
    g6_24xlarge = "g6.24xlarge"
    g6_48xlarge = "g6.48xlarge"
    g6e_xlarge = "g6e.xlarge"
    g6e_2xlarge = "g6e.2xlarge"
    g6e_4xlarge = "g6e.4xlarge"
    g6e_8xlarge = "g6e.8xlarge"
    g6e_12xlarge = "g6e.12xlarge"
    g6e_16xlarge = "g6e.16xlarge"
    g6e_24xlarge = "g6e.24xlarge"
    g6e_48xlarge = "g6e.48xlarge"
    
    # GR series
    gr6_4xlarge = "gr6.4xlarge"
    gr6_8xlarge = "gr6.8xlarge"
    
    # H series
    hi1_4xlarge = "hi1.4xlarge"
    hs1_8xlarge = "hs1.8xlarge"
    h1_2xlarge = "h1.2xlarge"
    h1_4xlarge = "h1.4xlarge"
    h1_8xlarge = "h1.8xlarge"
    h1_16xlarge = "h1.16xlarge"
    
    # HPC series
    hpc6a_48xlarge = "hpc6a.48xlarge"
    hpc6id_32xlarge = "hpc6id.32xlarge"
    hpc7a_12xlarge = "hpc7a.12xlarge"
    hpc7a_24xlarge = "hpc7a.24xlarge"
    hpc7a_48xlarge = "hpc7a.48xlarge"
    hpc7a_96xlarge = "hpc7a.96xlarge"
    hpc7g_4xlarge = "hpc7g.4xlarge"
    hpc7g_8xlarge = "hpc7g.8xlarge"
    hpc7g_16xlarge = "hpc7g.16xlarge"
    
    # I series
    i2_xlarge = "i2.xlarge"
    i2_2xlarge = "i2.2xlarge"
    i2_4xlarge = "i2.4xlarge"
    i2_8xlarge = "i2.8xlarge"
    i3_large = "i3.large"
    i3_xlarge = "i3.xlarge"
    i3_2xlarge = "i3.2xlarge"
    i3_4xlarge = "i3.4xlarge"
    i3_8xlarge = "i3.8xlarge"
    i3_16xlarge = "i3.16xlarge"
    i3_metal = "i3.metal"
    i3en_large = "i3en.large"
    i3en_xlarge = "i3en.xlarge"
    i3en_2xlarge = "i3en.2xlarge"
    i3en_3xlarge = "i3en.3xlarge"
    i3en_6xlarge = "i3en.6xlarge"
    i3en_12xlarge = "i3en.12xlarge"
    i3en_24xlarge = "i3en.24xlarge"
    i3en_metal = "i3en.metal"
    i4g_large = "i4g.large"
    i4g_xlarge = "i4g.xlarge"
    i4g_2xlarge = "i4g.2xlarge"
    i4g_4xlarge = "i4g.4xlarge"
    i4g_8xlarge = "i4g.8xlarge"
    i4g_16xlarge = "i4g.16xlarge"
    i4i_large = "i4i.large"
    i4i_xlarge = "i4i.xlarge"
    i4i_2xlarge = "i4i.2xlarge"
    i4i_4xlarge = "i4i.4xlarge"
    i4i_8xlarge = "i4i.8xlarge"
    i4i_12xlarge = "i4i.12xlarge"
    i4i_16xlarge = "i4i.16xlarge"
    i4i_24xlarge = "i4i.24xlarge"
    i4i_32xlarge = "i4i.32xlarge"
    i4i_metal = "i4i.metal"
    i7ie_large = "i7ie.large"
    i7ie_xlarge = "i7ie.xlarge"
    i7ie_2xlarge = "i7ie.2xlarge"
    i7ie_3xlarge = "i7ie.3xlarge"
    i7ie_6xlarge = "i7ie.6xlarge"
    i7ie_12xlarge = "i7ie.12xlarge"
    i7ie_18xlarge = "i7ie.18xlarge"
    i7ie_24xlarge = "i7ie.24xlarge"
    i7ie_48xlarge = "i7ie.48xlarge"
    i8g_large = "i8g.large"
    i8g_xlarge = "i8g.xlarge"
    i8g_2xlarge = "i8g.2xlarge"
    i8g_4xlarge = "i8g.4xlarge"
    i8g_8xlarge = "i8g.8xlarge"
    i8g_12xlarge = "i8g.12xlarge"
    i8g_16xlarge = "i8g.16xlarge"
    i8g_24xlarge = "i8g.24xlarge"
    i8g_metal_24xl = "i8g.metal-24xl"
    
    # IM series
    im4gn_large = "im4gn.large"
    im4gn_xlarge = "im4gn.xlarge"
    im4gn_2xlarge = "im4gn.2xlarge"
    im4gn_4xlarge = "im4gn.4xlarge"
    im4gn_8xlarge = "im4gn.8xlarge"
    im4gn_16xlarge = "im4gn.16xlarge"
    
    # INF series
    inf1_xlarge = "inf1.xlarge"
    inf1_2xlarge = "inf1.2xlarge"
    inf1_6xlarge = "inf1.6xlarge"
    inf1_24xlarge = "inf1.24xlarge"
    inf2_xlarge = "inf2.xlarge"
    inf2_8xlarge = "inf2.8xlarge"
    inf2_24xlarge = "inf2.24xlarge"
    inf2_48xlarge = "inf2.48xlarge"
    
    # IS series
    is4gen_medium = "is4gen.medium"
    is4gen_large = "is4gen.large"
    is4gen_xlarge = "is4gen.xlarge"
    is4gen_2xlarge = "is4gen.2xlarge"
    is4gen_4xlarge = "is4gen.4xlarge"
    is4gen_8xlarge = "is4gen.8xlarge"
    
    # M series
    m1_small = "m1.small"
    m1_medium = "m1.medium"
    m1_large = "m1.large"
    m1_xlarge = "m1.xlarge"
    m2_xlarge = "m2.xlarge"
    m2_2xlarge = "m2.2xlarge"
    m2_4xlarge = "m2.4xlarge"
    m3_medium = "m3.medium"
    m3_large = "m3.large"
    m3_xlarge = "m3.xlarge"
    m3_2xlarge = "m3.2xlarge"
    m4_large = "m4.large"
    m4_xlarge = "m4.xlarge"
    m4_2xlarge = "m4.2xlarge"
    m4_4xlarge = "m4.4xlarge"
    m4_10xlarge = "m4.10xlarge"
    m4_16xlarge = "m4.16xlarge"
    m5_large = "m5.large"
    m5_xlarge = "m5.xlarge"
    m5_2xlarge = "m5.2xlarge"
    m5_4xlarge = "m5.4xlarge"
    m5_8xlarge = "m5.8xlarge"
    m5_12xlarge = "m5.12xlarge"
    m5_16xlarge = "m5.16xlarge"
    m5_24xlarge = "m5.24xlarge"
    m5_metal = "m5.metal"
    m5a_large = "m5a.large"
    m5a_xlarge = "m5a.xlarge"
    m5a_2xlarge = "m5a.2xlarge"
    m5a_4xlarge = "m5a.4xlarge"
    m5a_8xlarge = "m5a.8xlarge"
    m5a_12xlarge = "m5a.12xlarge"
    m5a_16xlarge = "m5a.16xlarge"
    m5a_24xlarge = "m5a.24xlarge"
    m5ad_large = "m5ad.large"
    m5ad_xlarge = "m5ad.xlarge"
    m5ad_2xlarge = "m5ad.2xlarge"
    m5ad_4xlarge = "m5ad.4xlarge"
    m5ad_8xlarge = "m5ad.8xlarge"
    m5ad_12xlarge = "m5ad.12xlarge"
    m5ad_16xlarge = "m5ad.16xlarge"
    m5ad_24xlarge = "m5ad.24xlarge"
    m5d_large = "m5d.large"
    m5d_xlarge = "m5d.xlarge"
    m5d_2xlarge = "m5d.2xlarge"
    m5d_4xlarge = "m5d.4xlarge"
    m5d_8xlarge = "m5d.8xlarge"
    m5d_12xlarge = "m5d.12xlarge"
    m5d_16xlarge = "m5d.16xlarge"
    m5d_24xlarge = "m5d.24xlarge"
    m5d_metal = "m5d.metal"
    m5dn_large = "m5dn.large"
    m5dn_xlarge = "m5dn.xlarge"
    m5dn_2xlarge = "m5dn.2xlarge"
    m5dn_4xlarge = "m5dn.4xlarge"
    m5dn_8xlarge = "m5dn.8xlarge"
    m5dn_12xlarge = "m5dn.12xlarge"
    m5dn_16xlarge = "m5dn.16xlarge"
    m5dn_24xlarge = "m5dn.24xlarge"
    m5dn_metal = "m5dn.metal"
    m5n_large = "m5n.large"
    m5n_xlarge = "m5n.xlarge"
    m5n_2xlarge = "m5n.2xlarge"
    m5n_4xlarge = "m5n.4xlarge"
    m5n_8xlarge = "m5n.8xlarge"
    m5n_12xlarge = "m5n.12xlarge"
    m5n_16xlarge = "m5n.16xlarge"
    m5n_24xlarge = "m5n.24xlarge"
    m5n_metal = "m5n.metal"
    m5zn_large = "m5zn.large"
    m5zn_xlarge = "m5zn.xlarge"
    m5zn_2xlarge = "m5zn.2xlarge"
    m5zn_3xlarge = "m5zn.3xlarge"
    m5zn_6xlarge = "m5zn.6xlarge"
    m5zn_12xlarge = "m5zn.12xlarge"
    m5zn_metal = "m5zn.metal"
    m6a_large = "m6a.large"
    m6a_xlarge = "m6a.xlarge"
    m6a_2xlarge = "m6a.2xlarge"
    m6a_4xlarge = "m6a.4xlarge"
    m6a_8xlarge = "m6a.8xlarge"
    m6a_12xlarge = "m6a.12xlarge"
    m6a_16xlarge = "m6a.16xlarge"
    m6a_24xlarge = "m6a.24xlarge"
    m6a_32xlarge = "m6a.32xlarge"
    m6a_48xlarge = "m6a.48xlarge"
    m6a_metal = "m6a.metal"
    m6g_medium = "m6g.medium"
    m6g_large = "m6g.large"
    m6g_xlarge = "m6g.xlarge"
    m6g_2xlarge = "m6g.2xlarge"
    m6g_4xlarge = "m6g.4xlarge"
    m6g_8xlarge = "m6g.8xlarge"
    m6g_12xlarge = "m6g.12xlarge"
    m6g_16xlarge = "m6g.16xlarge"
    m6g_metal = "m6g.metal"
    m6gd_medium = "m6gd.medium"
    m6gd_large = "m6gd.large"
    m6gd_xlarge = "m6gd.xlarge"
    m6gd_2xlarge = "m6gd.2xlarge"
    m6gd_4xlarge = "m6gd.4xlarge"
    m6gd_8xlarge = "m6gd.8xlarge"
    m6gd_12xlarge = "m6gd.12xlarge"
    m6gd_16xlarge = "m6gd.16xlarge"
    m6gd_metal = "m6gd.metal"
    m6i_large = "m6i.large"
    m6i_xlarge = "m6i.xlarge"
    m6i_2xlarge = "m6i.2xlarge"
    m6i_4xlarge = "m6i.4xlarge"
    m6i_8xlarge = "m6i.8xlarge"
    m6i_12xlarge = "m6i.12xlarge"
    m6i_16xlarge = "m6i.16xlarge"
    m6i_24xlarge = "m6i.24xlarge"
    m6i_32xlarge = "m6i.32xlarge"
    m6i_metal = "m6i.metal"
    m6id_large = "m6id.large"
    m6id_xlarge = "m6id.xlarge"
    m6id_2xlarge = "m6id.2xlarge"
    m6id_4xlarge = "m6id.4xlarge"
    m6id_8xlarge = "m6id.8xlarge"
    m6id_12xlarge = "m6id.12xlarge"
    m6id_16xlarge = "m6id.16xlarge"
    m6id_24xlarge = "m6id.24xlarge"
    m6id_32xlarge = "m6id.32xlarge"
    m6id_metal = "m6id.metal"
    m6in_large = "m6in.large"
    m6in_xlarge = "m6in.xlarge"
    m6in_2xlarge = "m6in.2xlarge"
    m6in_4xlarge = "m6in.4xlarge"
    m6in_8xlarge = "m6in.8xlarge"
    m6in_12xlarge = "m6in.12xlarge"
    m6in_16xlarge = "m6in.16xlarge"
    m6in_24xlarge = "m6in.24xlarge"
    m6in_32xlarge = "m6in.32xlarge"
    m6in_metal = "m6in.metal"
    m6idn_large = "m6idn.large"
    m6idn_xlarge = "m6idn.xlarge"
    m6idn_2xlarge = "m6idn.2xlarge"
    m6idn_4xlarge = "m6idn.4xlarge"
    m6idn_8xlarge = "m6idn.8xlarge"
    m6idn_12xlarge = "m6idn.12xlarge"
    m6idn_16xlarge = "m6idn.16xlarge"
    m6idn_24xlarge = "m6idn.24xlarge"
    m6idn_32xlarge = "m6idn.32xlarge"
    m6idn_metal = "m6idn.metal"
    m7g_medium = "m7g.medium"
    m7g_large = "m7g.large"
    m7g_xlarge = "m7g.xlarge"
    m7g_2xlarge = "m7g.2xlarge"
    m7g_4xlarge = "m7g.4xlarge"
    m7g_8xlarge = "m7g.8xlarge"
    m7g_12xlarge = "m7g.12xlarge"
    m7g_16xlarge = "m7g.16xlarge"
    m7g_metal = "m7g.metal"
    m7gd_medium = "m7gd.medium"
    m7gd_large = "m7gd.large"
    m7gd_xlarge = "m7gd.xlarge"
    m7gd_2xlarge = "m7gd.2xlarge"
    m7gd_4xlarge = "m7gd.4xlarge"
    m7gd_8xlarge = "m7gd.8xlarge"
    m7gd_12xlarge = "m7gd.12xlarge"
    m7gd_16xlarge = "m7gd.16xlarge"
    m7gd_metal = "m7gd.metal"
    m7i_large = "m7i.large"
    m7i_xlarge = "m7i.xlarge"
    m7i_2xlarge = "m7i.2xlarge"
    m7i_4xlarge = "m7i.4xlarge"
    m7i_8xlarge = "m7i.8xlarge"
    m7i_12xlarge = "m7i.12xlarge"
    m7i_16xlarge = "m7i.16xlarge"
    m7i_24xlarge = "m7i.24xlarge"
    m7i_48xlarge = "m7i.48xlarge"
    m7i_metal_24xl = "m7i.metal-24xl"
    m7i_metal_48xl = "m7i.metal-48xl"
    m7i_flex_large = "m7i-flex.large"
    m7i_flex_xlarge = "m7i-flex.xlarge"
    m7i_flex_2xlarge = "m7i-flex.2xlarge"
    m7i_flex_4xlarge = "m7i-flex.4xlarge"
    m7i_flex_8xlarge = "m7i-flex.8xlarge"
    m7a_medium = "m7a.medium"
    m7a_large = "m7a.large"
    m7a_xlarge = "m7a.xlarge"
    m7a_2xlarge = "m7a.2xlarge"
    m7a_4xlarge = "m7a.4xlarge"
    m7a_8xlarge = "m7a.8xlarge"
    m7a_12xlarge = "m7a.12xlarge"
    m7a_16xlarge = "m7a.16xlarge"
    m7a_24xlarge = "m7a.24xlarge"
    m7a_32xlarge = "m7a.32xlarge"
    m7a_48xlarge = "m7a.48xlarge"
    m7a_metal_48xl = "m7a.metal-48xl"
    m8g_medium = "m8g.medium"
    m8g_large = "m8g.large"
    m8g_xlarge = "m8g.xlarge"
    m8g_2xlarge = "m8g.2xlarge"
    m8g_4xlarge = "m8g.4xlarge"
    m8g_8xlarge = "m8g.8xlarge"
    m8g_12xlarge = "m8g.12xlarge"
    m8g_16xlarge = "m8g.16xlarge"
    m8g_24xlarge = "m8g.24xlarge"
    m8g_48xlarge = "m8g.48xlarge"
    m8g_metal_24xl = "m8g.metal-24xl"
    m8g_metal_48xl = "m8g.metal-48xl"

    # X series
    x8g_medium = "x8g.medium"
    x8g_large = "x8g.large"
    x8g_xlarge = "x8g.xlarge"
    x8g_2xlarge = "x8g.2xlarge"
    x8g_4xlarge = "x8g.4xlarge"
    x8g_8xlarge = "x8g.8xlarge"
    x8g_12xlarge = "x8g.12xlarge"
    x8g_16xlarge = "x8g.16xlarge"
    x8g_24xlarge = "x8g.24xlarge"
    x8g_48xlarge = "x8g.48xlarge"
    x8g_metal_24xl = "x8g.metal-24xl"
    x8g_metal_48xl = "x8g.metal-48xl"


type
  LaunchTemplate* = object
    LaunchTemplateId*: Option[string]
    LaunchTemplateName*: Option[string]
    Version*: string = "$Latest"

  CpuCredits* = enum
    Unlimited = "unlimited"
    Standard = "standard"

  CpuOptions* = object
    CoreCount*: int
    ThreadsPerCore*: int = 2
    AmdSevSnp*: string = "disabled"

  MetadataOptions* = object
    State*: Option[string]
    HttpTokens*: Option[string]
    HttpPutResponseHopLimit*: Option[int]
    HttpEndpoint*: Option[string]
    HttpProtocolIpv6*: Option[string]
    InstanceMetadataTags*: Option[string]

  LicenseSpecifications* = seq[LicenseSpecification]

  LicenseSpecification* = object
    LicenseConfigurationArn*: string

  CapacityReservationPreference* = enum
    CAPACITY_RESERVATIONS_ONLY = "capacity-reservations-only"
    OPEN = "open"
    NONE = "none"

  CapacityReservationTarget* = object
    CapacityReservationId*: string
    CapacityReservationResourceGroupArn*: string

  CapacityReservationSpecification* = object
    CapacityReservationPreference*: CapacityReservationPreference
    CapacityReservationTarget*: Option[CapacityReservationTarget]

  HibernationOptions* = object
    Configured*: bool = false

  CreditSpecification* = object
    CpuCredits*: CpuCredits

  SpotMarketOptions* = object
    MaxPrice*: string
    SpotInstanceType*: string
    BlockDurationMinutes*: Option[int]
    ValidUntil*: Option[string]
    InstanceInterruptionBehavior*: Option[string]

  InstanceMarketOptions* = object
    MarketType*: string
    SpotOptions*: Option[SpotMarketOptions]

  ElasticInferenceAcceleratorType* = enum
    eia1_medium = "eia1.medium"
    eia1_large = "eia1.large"
    eia1_xlarge = "eia1.xlarge"
    eia2_medium = "eia2.medium"
    eia2_large = "eia2.large"
    eia2_xlarge = "eia2.xlarge"

  ElasticGpuSpecification* = object
    Type*: string
  ElasticInferenceAccelerator* = object
    Type*: ElasticInferenceAcceleratorType
    Count*: int = 1

  Tag* = object
    Key*: string
    Value*: string

  TagSpecification* = object
    ResourceType*: string
    Tags*: seq[Tag]


  IPv6Address* = object
    Ipv6Address*: string
    IsPrimaryIpv6*: bool
  
  IPv6Addresses* = seq[IPv6Address]

  NetworkPerformanceOptions* = object
    BandwidthWeighting*: string


  VolumeType* = enum
    vtStandard = "standard"
    vtIo1      = "io1"
    vtIo2      = "io2"
    vtGp2      = "gp2"
    vtSc1      = "sc1"
    vtSt1      = "st1"
    vtGp3      = "gp3"

  Ebs* = object
    DeleteOnTermination*: Option[bool]
    Iops*: Option[int]
    SnapshotId*: Option[string]
    VolumeSize*: Option[int]
    VolumeType*: Option[VolumeType]
    KmsKeyId*: Option[string]
    Throughput*: Option[int]
    OutpostArn*: Option[string]
    Encrypted*: Option[bool]

  BlockDeviceMappings* = object
    Ebs*: Ebs
    NoDevice*: Option[string]
    DeviceName*: Option[string]
    VirtualName*: Option[string]

  Architecture = enum
    x86_64 = "x86_64"
    i386   = "i386"

  NetworkInterfaceAttachment* = object
    AttachTime*: string
    AttachmentId*: string
    DeleteOnTermination*: bool
    DeviceIndex*: int
    Status*: string
    NetworkCardIndex*: int
  
  SecurityGroup* = object
    GroupId*: string
    GroupName*: string

  PrivateIPAddress* = object
    Primary*: bool
    PrivateDnsName*: string
    PrivateIpAddress*: string

  InstanceInitiatedShutdownBehavior* = enum
    Stop = "stop"
    Terminate = "terminate"

  Operator* = object
    Managed*: bool

  InterfaceType* = enum
    Interface = "interface"
    Efa = "efa"
    EfaOnly = "efa-only"

  Ipv4Prefix* = object
    Ipv4Prefix*: string

  Ipv6Prefix* = object
    Ipv6Prefix*: string

  EnaSrdUdpSpecification* = object
    EnaSrdUdpEnabled*: bool

  EnaSrdSpecification* = object
    EnaSrdEnabled*: bool
    EnaSrdUdpSpecification*: Option[EnaSrdUdpSpecification]

  ConnectionTrackingSpecification* = object
    TcpEstablishedTimeout*: Option[int]
    UdpStreamTimeout*: Option[int]
    UdpTimeout*: Option[int]

  OptionNetworkInterface* = object
    AssociatePublicIpAddress*: Option[bool]
    DeleteOnTermination*: Option[bool]
    Description*: Option[string]
    DeviceIndex*: Option[int]
    Groups*: Option[seq[string]]
    Ipv6AddressCount*: Option[int]
    Ipv6Addresses*: Option[IPv6Addresses]
    NetworkInterfaceId*: Option[string]
    PrivateIpAddress*: Option[string]
    PrivateIpAddresses*: Option[seq[PrivateIPAddress]]
    SecondaryPrivateIpAddressCount*: Option[int]
    SubnetId*: Option[string]
    AssociateCarrierIpAddress*: Option[bool]
    InterfaceType*: Option[InterfaceType]
    NetworkCardIndex*: Option[int]
    Ipv4Prefixes*: Option[seq[Ipv4Prefix]]
    Ipv4PrefixCount*: Option[int]
    Ipv6Prefixes*: Option[seq[Ipv6Prefix]]
    Ipv6PrefixCount*: Option[int]
    PrimaryIpv6*: Option[bool]
    EnaSrdSpecification*: Option[EnaSrdSpecification]
    ConnectionTrackingSpecification*: Option[ConnectionTrackingSpecification]

  IamInstanceProfile* = object
    Arn*: string
    Name*: string

  OptionNetworkInterfaces* = seq[OptionNetworkInterface]

  NetworkInterface* = object
    Attachment*: NetworkInterfaceAttachment
    Description: string
    Groups*: seq[SecurityGroup]
    Ipv6Addresses*: seq[string]
    MacAddress*: string
    NetworkInterfaceId*: string
    OwnerId*: string
    PrivateDnsName*: string
    PrivateIpAddress*: string
    PrivateIpAddresses*: seq[PrivateIPAddress]
    SourceDestCheck*: bool
    Status*: string
    SubnetId*: string
    VpcId*: string
    InterfaceType*: string
    Operator*: Operator

  State* = object
    Code*: int
    Name*: string

  StateReason* = object
    Code*: string
    Message*: string

  EnclaveOptions* = object
    Enabled*: bool
  
  PrivateDNSNameOptions* = object
    HostnameType*: string
    EnableResourceNameDnsARecord*: bool
    EnableResourceNameDnsAAAARecord*: bool

  MaintenanceOptions* = object
    AutoRecovery*: string
  
  Placement* = object
    GroupName*: string
    Tenancy*: string
    AvailabilityZone*: string

  Monitoring* = object
    State*: string
  
  MonitoringEnabled* = object
    Enabled*: bool

  EC2Instance* = object
    Architecture*: Architecture
    BlockDeviceMappings*: seq[BlockDeviceMappings] #
    ClientToken*: string
    EbsOptimized*: bool
    EnaSupport*: bool
    Hypervisor*: string
    NetworkInterfaces*: seq[NetworkInterface]
    RootDeviceName*: string
    RootDeviceType*: string
    SecurityGroups*: seq[SecurityGroup]
    SourceDestCheck*: bool
    StateReason*: StateReason
    Tags*: seq[Tag]
    VirtualizationType*: string
    CpuOptions*: CpuOptions
    CapacityReservationSpecification*: CapacityReservationSpecification
    MetadataOptions*: MetadataOptions
    EnclaveOptions*: EnclaveOptions
    BootMode*: string
    PrivateDnsNameOptions*: PrivateDNSNameOptions
    MaintenanceOptions*: MaintenanceOptions
    CurrentInstanceBootMode*: string
    Operator*: Operator
    InstanceId*: string
    ImageId*: string
    State*: State
    PrivateDnsName*: string
    PublicDnsName*: string
    StateTransitionReason*: string
    KeyName*: string
    AmiLaunchIndex*: int
    ProductCodes*: seq[string]
    InstanceType*: string
    LaunchTime*: string
    Placement*: Placement
    Monitoring*: Monitoring
    SubnetId*: string
    VpcId*: string
    PrivateIpAddress*: string

  Instances* = seq[EC2Instance]

  Reservations* = object
    ReservationId*: string
    OwnerId*: string
    Groups*: seq[string]
    Instances*: Instances
  
  RunInstancesResponse* = Reservations

allowSerialization Architecture
allowSerialization NetworkInterfaceAttachment
allowSerialization SecurityGroup
allowSerialization PrivateIPAddress
allowSerialization Operator
allowSerialization NetworkInterface
allowSerialization StateReason
allowSerialization Tag
allowSerialization CPUOptions
allowSerialization CapacityReservationSpecification
allowSerialization MetadataOptions
allowSerialization EnclaveOptions
allowSerialization PrivateDNSNameOptions
allowSerialization MaintenanceOptions
allowSerialization Placement
allowSerialization Monitoring
allowSerialization EC2Instance
allowSerialization Instances
allowSerialization Reservations
allowSerialization RunInstancesResponse

allowSerialization Ebs
allowSerialization BlockDeviceMappings

# ec2/terminate-instances
type
  TerminatingInstance* = object
    InstanceId*: string
    CurrentState*: State
    PreviousState*: State

  TerminateInstancesResponse* = object
    TerminatingInstances*: seq[TerminatingInstance]

allowSerialization State
allowSerialization TerminatingInstance
allowSerialization TerminateInstancesResponse


# ec2/describe-instances
type
  DescribeInstancesResponse* = object
    NextToken*: string
    Reservations*: seq[Reservations]

allowSerialization DescribeInstancesResponse


# ec2/describe-launch-templates

