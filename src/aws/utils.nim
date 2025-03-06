import types

proc Filter*(kind: FilterName, args: varargs[string]): Filter =
  var values: seq[string] = @[]
  for arg in args:
    values.add arg
  result = Filter(
    Name: kind,
    Values: values
  )