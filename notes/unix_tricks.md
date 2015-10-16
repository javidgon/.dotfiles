# Tricks

### Record and play a terminal session.
```
> script -t 2> timing.log output.session
...
...
> exit
> scriptreplay timing.log output.session
```

### Figure out which port is used by an app.
```
> cat /etc/services | grep "postgres"
```

### See folders size in linux
```
> du -sh *
```

### See free space left
```
> du
```

### See number of files in a folder
```
> ls | wc -l
```

### Check if a port is being used
```
> netstat -an | grep 8000
```

### Replace strings in linux file
```
# 'g' stands for global. Remove it if you want only the first one.
> sed -i -- 's/<old_string>/<new_string>/g' old_file.txt >new_file.txt
```

### Replace strings in linux file (after some context)
```
> sed -re 's/(<context>)[^<last_part_context>]*$/\1 <new_string>/' old_file.txt >new_file.txt

# Example:
> cat old_file.txt                                                                                  
    root ricardo
    ubuntu ricardo
    amparo papa
    jorge ricardo
> sed -re 's/(ubuntu)[^ubuntu]*$/\1 600/' example.txt                                              
    root ricardo
    ubuntu 600
    amparo papa
    jorge ricardo
```
