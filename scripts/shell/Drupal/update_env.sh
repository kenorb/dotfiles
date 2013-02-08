#!/bin/bash

# Update/install the current Drupal environment based on the Drupal profile file
#
# @author Rafal Wieczorek <kenorb>
#

# Environmental variables (please change)
PROFILE="drupal_profile"  # drupal_profile.make file to install
DOCROOT="docroot"         # directory name for installing the environment
MYSQL_USER="root"         # username for MySQL server
MYSQL_PASS="root"         # password for MySQL server
ADMIN_PASS="admin"        # default Drupal admin password to set
GITHUB_MAIN="main"        # main git user repository, where pull requests are sent (optional)

# auto variables
CWD=$(dirname `readlink -f $0 || realpath $0`)  # Linux || Mac support
APACHE_USER=$(ps axho user,comm|grep -E --color=auto "httpd|apache"|uniq|grep -v "root"|awk 'END {if ($1) print $1}')
GITHUB_USER="$1"          # github username for git forks (optional)

# commands
DRUSH="drush -v"
MAKE_ARGS="-y --working-copy --no-gitinfofile --no-cache --concurrency=8 --verbose"
MAKE_UP_ARGS="--no-core -y --working-copy --no-gitinfofile --concurrency=8 --verbose"

# constants
C="\033[0;36m" R="\033[0;31m" NC="\033[0m"

function update_forks {
  echo -e ${C}Updating git forks...${NC}
  set -o xtrace

  cd $CWD/..

  # Pull all git repositories...
  git pull origin master
  git submodule foreach "git pull&"
  sleep 2

  # Pull all local git forks on the top of that (if github user was passed into argument)...
  if [ -n "$GITHUB_USER" ]; then
    git submodule foreach "git pull \$(git config --get remote.origin.url | sed s#main#$GITHUB_USER#)&"
    echo $GITHUB_USER;
  fi
  sleep 2

  set -o xtrace -
}

function update_env {
  echo -e ${C}Checking the environment...${NC}
  echo

  set -o xtrace
  # Check for not committed changes
  (git submodule foreach git diff | grep -E --color=auto -C20 "(diff|\+.*|-.*)") &&
    echo -e ${R}WARNING: This will override all your not committed changes! Press Control-C to cancel...${NC} && sleep 10

  cd $CWD/../$DOCROOT && # Go to docroot directory
    (
     $DRUSH status &&    # Check status of Drupal installation
     (
      echo -e ${C}Updating the environment...${NC}
      $DRUSH make ../${PROFILE}.make $MAKE_UP_ARGS
      # Update the permissions
      echo -e "Updating directory permissions (sudo is required)..."
      sudo chown -R $APACHE_USER:$APACHE_USER $CWD/../$DOCROOT/sites/default/files
     )
   ) || install_env
  set -o xtrace -
}

function install_env {
  echo -e ${C}Installing the environment...${NC}
  set -o xtrace
  cd $CWD/.. && (
    $DRUSH -y -v make $PROFILE.make $DOCROOT $MAKE_ARGS &&                        # Build site from scratch
      cd $CWD/../$DOCROOT &&
        $DRUSH -y si ${PROFILE} --db-url=mysql://${MYSQL_USER}:${MYSQL_PASS}@localhost/${PROFILE} # Install site from scratch
        $DRUSH upwd admin --password=$ADMIN_PASS                                                  # Change Drupal admin password
  )
  set -o xtrace -
}

function update_dev {
  echo -e ${C}Configuring local development environment...${NC}
  set -o xtrace
  cd $CWD/../$DOCROOT && # Go to docroot directory
    (
     $DRUSH -y dl admin_menu
     $DRUSH -y en admin_menu
     $DRUSH -y updb           # Update database
    )
  set -o xtrace -
}

time (
  update_forks  # Update forks, especially make files
  update_env    # Update the existing environment
  update_forks  # Update forks, especially the local changes
  update_dev    # Update development environment
)

echo -e ${C}done.${NC}

