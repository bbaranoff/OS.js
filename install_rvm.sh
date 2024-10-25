function install_rvm {
  #Instructions : http://rvm.beginrescueend.com/rvm/install/
  echo "===> Installing RVM >>"
  bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

  #Reload shell
  . ~/.rvm/scripts/rvm

  result=`type rvm | head -1`
  echo "===> Result of testing RVM : '$result'"
  if [ "$result" == "rvm is a function" ]; then
    echo '===> RVM system install successful.'
  else
    echo '===> Error - Installation not successful, RVM should be a function not a binary - See http://rvm.beginrescueend.com/rvm/install/ for more info'
    return
  fi

  if ! grep -q 'rvm_archflags="-arch x86_64"' "$HOME/.rvmrc" ; then
    echo "===> Adding arch_flags for 64 bit on .RVMRC"
    echo  'rvm_archflags="-arch x86_64"' >> "$HOME/.rvmrc"
  fi

  . "$HOME/.rvmrc"
  . ~/.rvm/scripts/rvm

  echo '===> Installing Ruby 1.8.7'
  rvm install 1.8.7

  echo '===> Setting default to 1.8.7'
  rvm --default use 1.8.7


  current_user=`whoami`
  echo "===> Fixing permissions and ensuring $current_user has access"
  chown -R $current_user ~/.rvm

  profile_location=`bash_profile_location`

  #Add to bash_profile
  #TODO : Can only use this when this function (and related like bash_profile_location) is in a seperate script

  # if ! grep -q '### Load RVM into a shell session' "${profile_location}" ; then
  #   echo "Editing ${profile_location} to load RVM on Terminal launch"
  #   echo  '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  ### Load RVM into a shell session' >> "${profile_location}"
  # fi

  #Reload shell
  source $profile_location
}    