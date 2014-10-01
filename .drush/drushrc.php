<?php
// ~/.drush/drushrc.php
// This script tells drush to include any alias files it can find in git repositories that have a .drush or drush folder.
// See: http://www.astonishdesign.com/blog/drush-aliases-what-why-and-how

if (exec('git rev-parse --show-toplevel 2> /dev/null', $git)):
  $r = array_shift($git);
  $options['config'] = "$r/.drush/drushrc.php:$r/drush/drushrc.php";
  $options['include'] = "$r/.drush/commands:$r/drush/commands";
  $options['alias-path'] = "$r/.drush:$r/drush";
endif;
