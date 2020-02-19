# change-brightness-xrandr

##### Change the brightness for use in keyboard shortcuts or aliases.

## How to use
```
./change-brightness-xrandr.sh [Monitor-Name] [up | down]
```

### To get name of you monitors:
Runs:
```
xrandr -q | grep ' connected'
```

The output similar to:

```
eDP-1 connected primary 1366x768+0+0 (normal left inverted right x axis y axis) 344mm x 194mm
HDMI-1 connected 1600x900+1366+0 (normal left inverted right x axis y axis) 434mm x 236mm
```

The name of these monitors are **HDMI-1** and **eDP-1** respectively. And use:
```
./change-brightness-xrandr.sh HDMI-1 up
```


### Sugest use:
- Set a keyboard shurtcut in you system
- Set alias in ``~/.bashrc`` like:

```
alias mon1-down='/path-to-script/change-brightness-xrandr.sh HDMI-1 down'
alias mon1-up='/path-to-script/change-brightness-xrandr.sh HDMI-1 up'
```
