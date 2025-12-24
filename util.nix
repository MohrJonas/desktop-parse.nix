lib:
{
    isSectionHeading = line: builtins.substring 0 1 line == "[";
    isEmptyLine = line: builtins.stringLength line == 0;
    isContentLine = line: builtins.match ".*=.*" line != null;
    parseContentLine = line:
        let
            parts = lib.strings.splitString "=" line;
        in
            { key = builtins.head parts; value = lib.last parts; };
    trimSectionHeading = line: builtins.substring 1 ((builtins.stringLength line )- 2) line;
}
