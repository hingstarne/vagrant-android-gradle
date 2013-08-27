node default {
	
	# Packages to install
	$packages = ['tomcat6','tomcat6-extras','tomcat6-admin','libtomcat6-java']

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

	# Install Java
	class {'java':
		distribution         => 'jre',
		version              => 'present',
		require              => Apt::Source['debian_wheezy'];
	}
	package { $packages:
		ensure => installed,
	}

	

}
