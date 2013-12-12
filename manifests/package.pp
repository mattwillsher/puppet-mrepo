# This class installs mrepo from source or from the system package repository
#
# == Parameters
#
# Optional parameters can be found in the mrepo::params class
#
# == Examples
#
# This class does not need to be directly included.
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2011 Puppet Labs, unless otherwise noted
#
class mrepo::package {

  include mrepo::params

  $user   = $mrepo::params::user
  $group  = $mrepo::params::group

  package { 'mrepo':
    ensure  => present,
  }

  file { '/etc/mrepo.conf':
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => template('mrepo/mrepo.conf.erb'),
  }

  File {
    require => Package['mrepo']
  }

  file {
    '/etc/mrepo.conf.d':
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0755';
    '/var/cache/mrepo':
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0755';
    $mrepo::params::src_root:
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0755';
    '/var/log/mrepo.log':
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0640';
    $mrepo::params::www_root:
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0755';
    }

  # Packages needed to mirror files and generate mirror metadata
  package { ['lftp', 'createrepo']:
    ensure  => present,
  }
}
