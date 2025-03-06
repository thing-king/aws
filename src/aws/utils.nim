import options
import types

proc Filter*(kind: FilterName, args: varargs[string]): Filter =
  var values: seq[string] = @[]
  for arg in args:
    values.add arg
  result = Filter(
    Name: kind,
    Values: values
  )

proc LaunchTemplateName*(name: string, version: string = "$Latest"): LaunchTemplate =
  result = LaunchTemplate(
    LaunchTemplateName: some(name),
    Version: version
  )
proc LaunchTemplateId*(id: string, version: string = "$Latest"): LaunchTemplate =
  result = LaunchTemplate(
    LaunchTemplateId: some(id),
    Version: version
  )