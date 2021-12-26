# Geo

[![CI](https://github.com/vocksel/geo/actions/workflows/ci.yml/badge.svg)](https://github.com/vocksel/geo/actions/workflows/ci.yml)
[![Docs](https://img.shields.io/badge/docs-website-brightgreen)](https://vocksel.github.io/geo)

A library for analyzing 2D points to determine the geometric shape they represent.

![A full shape recognition example](.moonwave/static/shape-recognition.gif)

## Usage

```lua
local points = { Vector2.new(x1, y1), Vector2.new(x2, y2), Vector2.new(x3, y3), ... }

if Geo.detectShape(points) == Geo.Shape.Line then
    print("The points represent a line")

    local orientation = Geo.detectOrientation(points)

    if orientation == Geo.Orientation.North then
        print("The line is pointing up")
    end
end
```

## Installation

### Wally

If you are using [Wally](https://github.com/UpliftGames/wally), add the following to your `wally.toml` and run `wally install` to get a copy of the package.

```
[dependencies]
Geo = "vocksel/geo@v1.0.1
```

### Model File

* Download a copy of the rbxm from the [releases page](https://github.com/vocksel/geo/releases/latest) under the Assets section.
* Drag and drop the file into Roblox Studio to add it to your experience.

## Documentation

You can find the Hue documentation [here](https://vocksel.github.io/geo).

## Contributing

See the [contributing guide](https://vocksel.github.io/geo/docs/contributing).

## License

[MIT License](LICENSE)