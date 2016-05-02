#===============================================================
#########This is a  shell script created by Wei Zhao#########
#Filename:unixconfig.sh;
#Address:IBP, CAS, Beijing;
#Email:zhaoweicryoem AT gmail.com;
#Note:copy unixconfig files to current dir~~~
#===============================================================

#!bin/sh
unset filepath
# filepath=$(cat cp_files.txt)
filepath=(/.bashrc
/.vimrc
/.zshrc
/.zshrc.pre-oh-my-zsh
/.myzshrc
/.gvimrc)

filelenth=${#filepath[*]}
echo -e "$filelenth  files will be copied from \033[32m$HOME/\033[0m to current dir:\
\033[31m`pwd`/\033[0m\
 include: \n\033[46;31m${filepath[@]}\033[0m "

for  i in ${filepath[@]} ; do

  [ -e $HOME$i ] && echo "find file:$HOME$i" && cp -r $HOME$i ./ \
  && echo -e "copy success!"|| echo -e "file \033[42;31m $HOME$i \033[0m do not exit!"
  #statements

done
