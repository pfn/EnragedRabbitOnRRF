# ERCF on RRF

WIP set of configuration and macros to enable running the ERCF on RRF

[![Youtube Thumbnail](http://img.youtube.com/vi/N4DiK5DVftM/0.jpg)](http://www.youtube.com/watch?v=N4DiK5DVftM "ERCF on RRF")

## Usage

Add `M98 P"ercf/lib/init.g"` to the bottom of `config.g`

Edit `ercf/settings.g` to configure the drive assignments (`M584`).
Stepper motor configuration, `M569`, can be done in `config.g` or
`ercf/settings.g`

In order to run these macros, RRF 3.4b4 or newer *must* be used

### Configuration

Many variables can be configured in `ercf/settings.g`, reference
`ercf/lib/globals.g` to see what can be altered.
