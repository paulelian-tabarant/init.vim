# Installation notes

On MAC, I needed to use 

~~~sh
chmod +rwx /var/folders/pp/j30xnl217rz4nfwzxchbddvh0000gn/T/nvim.paul-elian.tabarant
~~~

to make `coc-tsserver` work properly. I don't know why it didn't have the rights on this folder before.

## Renaming files

To rename imports when renaming files, coc uses watchman. You need to have it on your system for it to function properly. See the corresponding installation instructions for your operating system.
