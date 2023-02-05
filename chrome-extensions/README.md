# Chrome extensions

This contains the list of Chrome extensions I use (for both Chrome and Edge).

## Overview

Generally, the list is fairly small, but I still separate it into two parts:

- `essential`
- `additional`

### `essential`

These are the extensions I always use. I strongly recommend to install them no matter what.

### `additional`

These are the packages I would rather not use either browser without. While I also recommend you install them, their usefulness is more subjective.

## Usage

The extensions are presented as CSV files that contain the store ID, the name of the extension, as well as the URL:

```csv
id,name,url
```

Maybe sometimes in the future I will create an automated script to install them if I feel like it. You can simply either copy paste the URLs to your browser by hand, or run:

```bash
cut -d ',' -f3 'chrome-extensions/CSVFILE'
```

to get the 3rd (URL) column from some CSV represented by `CSVFILE`.