# ERCF on RRF

WIP set of configuration and macros to enable running the ERCF on RRF

[![Youtube Thumbnail](http://img.youtube.com/vi/lP2_jpP7SuM/0.jpg)](http://www.youtube.com/watch?v=lP2_jpP7SuM "ERCF on RRF")

Errors occurring in the video are the result of a non-straight D shaft.
The project is basically on hold until replacements arrive.

## Usage

Add `M98 P"ercf/lib/init.g"` to the bottom of `config.g`

Edit `ercf/settings.g` to configure the drive assignments (`M584`).
Stepper motor configuration, `M569`, can be done in `config.g` or
`ercf/settings.g`

In order to run these macros, RRF 3.4b3 or newer *must* be used

### Configuration

Many variables can be configured in `ercf/settings.g`, reference
`ercf/lib/globals.g` to see what can be altered.
