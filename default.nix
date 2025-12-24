lib:
let
  util = import ./util.nix lib;

  parseDesktopFile = content:
    let
      lines = lib.strings.splitString "\n" content;
      elements = builtins.filter
        (element: element != null)
        (builtins.map
          (line:
            if util.isSectionHeading line then
              util.trimSectionHeading line
            else if util.isEmptyLine line then
              null
            else if util.isContentLine line then
              util.parseContentLine line
            else
              throw "Unknown line type ${line}")
          lines);
    in
      (builtins.foldl'
        (state: element:
          if builtins.isAttrs element then
            { acc = state.acc // { ${state.key} =
                (state.acc.${state.key} or []) ++ [element]; };
              key = state.key; }
          else
            { acc = state.acc; key = element; })
        { acc = {}; key = null; }
        elements).acc;

in {
  parseDesktopFileString = content: parseDesktopFile content;
  parseDesktopFilePath = path: parseDesktopFile (builtins.readFile path);
}
