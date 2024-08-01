<?php
function extractChars($input) {
    if (preg_match('/(\S)\s*(\S)/', $input, $matches)) {
        return [$matches[1], $matches[2]];
    } else {
        return [null, null];
    }
}

$input = "A B";
list($char1, $char2) = extractChars($input);
//echo "First character: '{$char1}', Second character: '{$char2}'"
print((2+2) % 3);
?>

