node default {
	
	# Packages to install
	$packages = ['vim','git','openjdk-7-jre','openjdk-7-jdk']

	# Cleanup APT Repositories for a nice clean start
	class { 'apt':
  		always_apt_update    => true,
  		purge_sources_list   => true,
  		purge_sources_list_d => true,
	}

	# Add ftp.de.debian.org as main mirror
	apt::source { 'debian_wheezy':
 		location             => 'http://ftp.de.debian.org/debian/',
 		release              => 'wheezy',
 		repos                => 'main contrib non-free',
 		include_src          => true;
	}
	apt::source { 'debian_wheezy_updates':
 		location             => 'http://ftp.de.debian.org/debian/',
 		release              => 'wheezy-updates',
 		repos                => 'main contrib non-free',
 		include_src          => true;
	}

	# Security Updates
	apt::source { 'debian_wheezy_security':
 		location             => 'http://security.debian.org/',
 		release              => 'wheezy/updates',
 		repos                => 'main contrib non-free',
 		include_src          => true;
	}

	# Install Debian Packages
	package { $packages:
		ensure               => installed;
	}

    # Setup Android User, workingdir and sdk
	user{'android':
	comment                  => 'android dev user',
	ensure                   => 'present',
	shell                    => '/bin/bash',
	managehome               => true;
    }

    class { 'android':
  }
}
