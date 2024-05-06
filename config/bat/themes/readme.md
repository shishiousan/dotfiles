
To add an extra highlighting theme to `bat` command 

Get a `tmTheme` file from the source page of your favorite color scheme 
and save it to here. 

And do 
```sh 
 bat cache --build 
```

After that, please check by 
```sh 
 bat --list-themes | grep "color_scheme_name" 
```

You can set the color scheme as default one by 
```sh 
 echo '--theme="color_scheme_name"' >> (bat --config-file)
```


