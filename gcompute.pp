gauth_credential { 'mgohcred':
  provider => serviceaccount,
  path     => '/Users/mgoh/gcompute-keys/mgoh-gce-01-2ec0c3029d9b.json',
  scopes   => ['https://www.googleapis.com/auth/compute'],
}

gcompute_zone { 'us-west1-b':
  project    => 'mgoh-gcp-01',
  credential => 'mgohcred',
}

gcompute_machine_type { 'n1-standard-1':
  zone       => 'us-west1-b',
  project    => 'mgoh-gcp-01',
  credential => 'mgohcred',
}

gcompute_disk { 'data-disk-1':
  ensure              => present,
  size_gb             => 50,
  zone                => 'us-west1-b',
  project             => 'mgoh-gcp-01',
  credential          => 'mgohcred',
}

gcompute_region { 'USbaywest':
  name       => 'us-west1-b',
  project    => 'mgoh-gcp-01',
  credential => 'mgohcred',
}

gcompute_network { "testnetwork-mgoh":
  auto_create_subnetworks => true,
  project                 => 'mgoh-gcp-01',
  credential              => 'mgohcred',
}


#
# BUILD THE INSTANCE
#
gcompute_instance { 'mgohinstance-test':
  ensure             => present,
  machine_type       => 'n1-standard-1',
  disks              => [
    {
      auto_delete => true,
      boot        => true,
      source      => 'data-disk-1',
    }
  ],
	network_interfaces => [
			{
				network        => 'testnetwork-mgoh',}
		],
  zone					 		 => 'us-west1-b',
  project            => 'mgoh-gcp-01',
  credential         => 'mgohcred',
}
