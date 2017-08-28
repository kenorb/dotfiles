<?php
// ~/.drush/drushrc.php
// This script tells drush to include any alias files it can find in git repositories that have a .drush or drush folder.
// See: http://www.astonishdesign.com/blog/drush-aliases-what-why-and-how

if (exec('git rev-parse --show-toplevel 2> /dev/null', $git)) {
  $path = array_shift($git);
  $options['config'] = array("$path/.drush/drushrc.php", "$path/drush/drushrc.php");
  $options['include'] = array("$path/.drush/commands", "$path/drush/commands");
  $options['alias-path'] = array("$path/.drush", "$path/drush");
}

// Load a drushrc.php configuration file from the current working directory.
$options['c'] = '.';

