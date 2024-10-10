#!/usr/bin/awk -f

BEGIN { FS = "" }

{
  sz = 0
  ch = 0
  for (i = 1; i <= NF; i++) {
    if ($i == "(")
      req[++sz] = ")"
    else if ($i == "[")
      req[++sz] = "]"
    else if ($i == "{")
      req[++sz] = "}"
    else if ($i == "<")
      req[++sz] = ">"
    else if ($i == req[sz])
      sz--
    else if ($i == ")")
      ch = 3
    else if ($i == "]")
      ch = 57
    else if ($i == "}")
      ch = 1197
    else if ($i == ">")
      ch = 25137
    if (ch) {
      result += ch
      break
    }
  }
}

END { print result }
