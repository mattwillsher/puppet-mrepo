# Class: mrepo::user
#
# Create user and group for mrepo use
#
class mrepo::user (
  $user   = $mrepo::params::user,
  $group  = $mrepo::params::group,
  $ensure = 'present',
) {
  case $ensure {
    present: {
      user { $user:
        ensure  => present,
        comment => 'mrepo user',
        home    => '/var/mrepo'
      }
      group { $user:
        ensure  => present,
      }
    }
    absent: {
      user { $user:
        ensure => absent
      }
      group { $user:
        ensure => present
      }
    }
    default: {
      fail { "Unknown user ensure value ${ensure}": }
    }
  }
}

