import macros
import strutils, os, osproc, options
import jsony_plus

import pkg/colors

import aws/types
import aws/str

import aws/utils
export utils


type UnhandledAWSException* = object of Exception

proc aws*[T](command: string, subcommand: string, globalOptions: GlobalOptions = GlobalOptions(), parameters: string = ""): T =
  let options = $globalOptions
  
  var cmd = "aws " & options & " " & command & " " & subcommand & " " & parameters
  let output = execProcess(cmd.strip())

  try:
    result = parse[T](output)
  except:
    raise newException(UnhandledAWSException, ("Could not parse output of '" & command & " " & subcommand & "'").underline & "\n\nJSON Error: \n".red.bold & getCurrentExceptionMsg().yellow & "\n\n" & output.gray & "\n\n" & "CMD:".gray.underline & " " & cmd.strip().gray)

macro constructAWS*(name: untyped, command: typed, subcommand: typed, output: typed, body: untyped): typed =
  expectKind(name, nnkIdent)
  expectKind(command, nnkStrLit)
  expectKind(subcommand, nnkStrLit)
  expectKind(output, nnkSym)
  expectKind(body, nnkStmtList)

  let formalParams = nnkFormalParams.newTree(
    output,
    nnkIdentDefs.newTree(
      ident("globalOptions"),
      ident("GlobalOptions"),
      nnkCall.newTree(
        ident("GlobalOptions")
      )
    )
  )

  var paramNodes: seq[(NimNode, NimNode)] = @[]
  for node in body:
    expectKind(node, nnkCall)
    expectLen(node, 2)
    expectKind(node[0], nnkIdent)
    expectKind(node[1], nnkStmtList)
    expectLen(node[1], 1)

    let paramNode = node[0]
    let paramNodeKind = node[1][0]
    formalParams.add(
      nnkIdentDefs.newTree(
        paramNode,
        nnkBracketExpr.newTree(
          ident("Option"),
          paramNodeKind
        ),
        nnkCall.newTree(
          ident("none"),
          paramNodeKind
        )
      )
    )
    paramNodes.add((paramNode, paramNodeKind))
  
  let prcBody = nnkStmtList.newNimNode()
  let params = ident("params")
  prcBody.add quote do:
    var `params` = ""
  
  for (paramNode, paramNodeKind) in paramNodes:
    let formattedName = newStrLitNode(camelToKebab(paramNode.strVal))
    
    if paramNodeKind.kind == nnkBracketExpr and paramNodeKind[0].kind == nnkIdent and paramNodeKind[0].strVal == "seq":
      prcBody.add quote do:
        if `paramNode`.isSome:
          `params`.add(`formattedName` & "=" & multipleOptionValues(`paramNode`.get) & " ")
    else:
      prcBody.add quote do:
        if `paramNode`.isSome:
          `params`.add(`formattedName` & "=" & $`paramNode`.get & " ")

  prcBody.add quote do:
    aws[`output`](`command`, `subcommand`, globalOptions, `params`)

  let rawNameStr = "raw" & name.strVal.capitalizeAscii()
  let rawName = ident(rawNameStr)
  let prc = nnkProcDef.newTree(
    postfix(rawName, "*"),
    nnkEmpty.newNimNode(),
    nnkEmpty.newNimNode(),
    formalParams,
    nnkEmpty.newNimNode(),
    nnkEmpty.newNimNode(),
    prcBody
  )

  result = quote do:
    `prc`
    macro `name`*(args: varargs[untyped]): untyped =
      var newArgs: seq[NimNode] = @[]
      for arg in args:
        expectKind(arg, nnkExprEqExpr)
        if arg[0].strVal == "globalOptions":
          newArgs.add arg
        else:
          newArgs.add(
            nnkExprEqExpr.newTree(
              arg[0],
              nnkCall.newTree(
                ident("some"),
                arg[1]
              )
            )
          )
      result = nnkCall.newNimNode()
      result.add ident(`rawNameStr`)
      for newArg in newArgs:
        result.add newArg

constructAWS describeInstances, "ec2", "describe-instances", DescribeInstancesResponse:
  instanceIds: seq[string]
  filters: Filters

constructAWS runInstances, "ec2", "run-instances", RunInstancesResponse:
  blockDeviceMappings: BlockDeviceMappings
  imageId: string
  instanceType: InstanceType
  ipv6AddressCount: int
  ipv6Addresses: seq[string]
  kernelId: string
  keyName: string
  monitoring: MonitoringEnabled
  ramdiskId: string
  securityGroupIds: seq[string]
  securityGroups: seq[string]
  subnetId: string
  userData: string
  elasticGpuSpecification: seq[ElasticGpuSpecification]
  elasticInferenceAccelerators: seq[ElasticInferenceAccelerator]
  tagSpecifications: seq[TagSpecification]
  launchTemplate: LaunchTemplate
  instanceMarketOptions: InstanceMarketOptions
  creditSpecification: CreditSpecification
  cpuOptions: CpuOptions
  capacityReservationSpecification: CapacityReservationSpecification
  hibernationOptions: HibernationOptions
  licenseSpecifications: seq[LicenseSpecifications]
  metadataOptions: MetadataOptions
  enclaveOptions: EnclaveOptions
  privateDnsNameOptions: PrivateDNSNameOptions
  maintenanceOptions: MaintenanceOptions
  disableApiStop: bool
  enablePrimaryIpv6: bool
  networkPerformanceOptions: NetworkPerformanceOptions
  dryRun: bool
  disableApiTermination: bool
  instanceInitiatedShutdownBehavior: InstanceInitiatedShutdownBehavior
  privateIpAddress: string
  networkInterfaces: OptionNetworkInterfaces
  iamInstanceProfile: IamInstanceProfile
  ebsOptimized: bool
  count: int
  secondaryPrivateIpAddresses: string
  secondaryPrivateIpAddressCount: string
  associatePublicIpAddress: bool
