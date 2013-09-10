node default {
	
	# Packages to install
	$packages = ['vim','freetds-dev','freetds-bin','freetds-common','git']

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
		ensure               => installed,
	}

	user{'ruby':
	password                 => '$6$FTbM8NfG$1pu4gQ0i6t6jvNMYYIS8k9RVFhEejQP.qzmBloao5wuNcYy3PN1NBVYUawlWJqFDbzx4ljTdHgPw4k1OniXRO0',
	comment                  => 'ruby dev user',
	ensure                   => 'present',
	shell                    => '/bin/bash',
	managehome               => true,
	}
	ssh_authorized_key {
	"arne@Macbook-root":
    ensure                   => present,
    user                     => root,
    type                     => "ssh-dss",
    key                      => "AAAAB3NzaC1kc3MAAACBAIfFPFQ5DN2ueGncpeIB63RLSfSN+GpVVeE//Ydjed+NvxmffAmzXqA9CVgnFont+xHjaDVo9lv9NTiDj9QPnWlWx9qsK5tmmksOMJYn+SFCoimJzKTVJ8XBDcifzdyUV3lOgdxJV5PVI+3LgEJcQPJT4pXa6nQwp0T89L+mi63PAAAAFQCLDrN4Zwf6ZF+o3lHA5mtblHYxEwAAAIA5vwfKJSYfs2WAMhH4IcsckdR47ia/ENgKLsW61I2c/uf6HFsnFHiP7jEvjEc2gG6I0bl6MIOqSBHQp3OEMq7H60UZoVHfvc66rAPbfPXr+ve6bgGB/UHiM9I4ZLGi1SiDKZ5KDtCqGDBQ1T5Zms7EN04ixXJTvVhE3NEkQB3Q4AAAAIA5Mp9vF2CG3U/PxIwtd9XEHOmV4GR4JFBf//4P3C4DiHf7Z9ynC4sggwejgsmMmGVKrttKNgFqa7Pt/in71cp0o+VEvTOdP1sb5kW+MYTTQFRwRAICouW96JHw0nMSfQxtWOy8HiTdfELYLlTmwGjUaGDlZfOnU/LXTRa8oZG0Yw==";
    "arne@Macbook-ruby":
    ensure                   => present,
    user                     => ruby,
    type                     => "ssh-dss",
    key                      => "AAAAB3NzaC1kc3MAAACBAIfFPFQ5DN2ueGncpeIB63RLSfSN+GpVVeE//Ydjed+NvxmffAmzXqA9CVgnFont+xHjaDVo9lv9NTiDj9QPnWlWx9qsK5tmmksOMJYn+SFCoimJzKTVJ8XBDcifzdyUV3lOgdxJV5PVI+3LgEJcQPJT4pXa6nQwp0T89L+mi63PAAAAFQCLDrN4Zwf6ZF+o3lHA5mtblHYxEwAAAIA5vwfKJSYfs2WAMhH4IcsckdR47ia/ENgKLsW61I2c/uf6HFsnFHiP7jEvjEc2gG6I0bl6MIOqSBHQp3OEMq7H60UZoVHfvc66rAPbfPXr+ve6bgGB/UHiM9I4ZLGi1SiDKZ5KDtCqGDBQ1T5Zms7EN04ixXJTvVhE3NEkQB3Q4AAAAIA5Mp9vF2CG3U/PxIwtd9XEHOmV4GR4JFBf//4P3C4DiHf7Z9ynC4sggwejgsmMmGVKrttKNgFqa7Pt/in71cp0o+VEvTOdP1sb5kW+MYTTQFRwRAICouW96JHw0nMSfQxtWOy8HiTdfELYLlTmwGjUaGDlZfOnU/LXTRa8oZG0Yw==";
	}
	rbenv::install { "ruby":
	group => 'ruby',
	home  => '/home/ruby';
	}
    rbenv::compile { "2.0.0-p247":
    user => 'ruby',
    home => '/home/ruby',
    global => true;
    }

}
