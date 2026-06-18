# TODO: color module?
def color(color; text):
    "\u001b[\(color)m\(text)\u001b[39m";

def red(text):
    color(31; text);

def green(text):
    color(32; text);

def blue(text):
    color(34; text);

def cyan(text):
    color(36; text);

def gray(text):
    color(37; text);

def bold(text):
    "\u001b[1m\(text)\u001b[22m";

def dim(text):
    "\u001b[2m\(text)\u001b[22m";

def rev(text):
    "\u001b[7m\(text)\u001b[27m";

# Image/repository and tag pretty printed
def image_pp:
    "\(blue(.[0]))\(gray(":"))\(cyan(.[1]))";

# Pretty list images
def images:
    sort_by(.Repository)

  | [
        bold("IMAGE"),
        bold("ID"),
        bold("CREATED"),
        bold("SIZE"),
        bold("USE")
    ],
    (
        .[]
      | [
            ([.Repository, .Tag] | image_pp),
            .ID,
            .CreatedSince,
            .Size,
            if .Containers != "0" then rev(cyan(" U ")) else "" end
        ]
    )

  | @tsv;

# Pretty list containers
def containers:
    # pad text with spaces
    def pad(text; width; align):
        # remove all ANSI escape sequences
        (text | gsub("\\x{001b}\\[\\d+m"; ""))   as $raw_text
      | ($raw_text | length)                     as $tlen
      | (" " * (width - ([$tlen, width] | min))) as $spacepad

      | if align == "left" then
            "\(text)\($spacepad)"
        elif align == "right" then
            "\($spacepad)\(text)"
        else
            error("invalid alignment")
        end;

    # pretty print name based on health status
    def name_pp:
        if .HealthStatus == "healthy" then
            bold(green(.Names))
        elif .HealthStatus == "unhealthy" then
            bold(red(.Names))
        else
            .Names
        end;

    # format and align
    def port_fmt:
        .Ports
      | split(", ")
      | map(split("->"))

      | (max_by(.[0] | length) | .[0] | length) as $pmax

        # align
      | map("\(pad(.[0]; $pmax; "left")) \(gray("->")) \(.[1])")
      | join("\n          ");

    def vol_fmt:
        .Mounts
      | split(",")
      | join("\n          ");

    ([.[] | .Names] | max_by(length) | length) as $max_name_len
  | ($max_name_len + 12) as $w

  | .[]

  | ( "\(pad("\(gray("["))\(name_pp)\(gray("]:"))"; $w; "left"))\(.Status)\n"
    + "      ID\(gray(":")) \(.ID)\n"
    + "   Image\(gray(":")) \(.Image | split(":") | image_pp)\n"
    + "    Size\(gray(":")) \(.Size)\n"
    + if .Ports != "" then "   Ports\(gray(":")) \(port_fmt)\n" else "" end
    + if .Mounts != "" then "  Mounts\(gray(":")) \(vol_fmt)\n" else "" end
    ) as $entry

    # dim exited containers
  | if .State == "exited" then dim($entry) else $entry end;
