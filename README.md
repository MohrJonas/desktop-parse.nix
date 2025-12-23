# desktop-parser.nix

Pure nix desktop-file parser

## Example

```nix
nix-repl> def = import ./default.nix

nix-repl> parser = def lib

nix-repl> ret = parser.parseDesktopFileString "[Desktop Entry]\nActions=new-private-window;new-window;profile-manager-window\nCategories=Network;WebBrowser\nExec=floorp --name floorp %U\nGenericName=Web Browser\nIcon=floorp\nMimeType=text/html;text/xml;application"

nix-repl> :p ret
{
  "[Desktop Entry]" = [
    {
      key = "Actions";
      value = "new-private-window;new-window;profile-manager-window";
    }
    {
      key = "Categories";
      value = "Network;WebBrowser";
    }
    {
      key = "Exec";
      value = "floorp --name floorp %U";
    }
    {
      key = "GenericName";
      value = "Web Browser";
    }
    {
      key = "Icon";
      value = "floorp";
    }
    {
      key = "MimeType";
      value = "text/html;text/xml;application";
    }
  ];
}

```
