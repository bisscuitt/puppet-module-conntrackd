# Just install and manage the conntrackd service
#
# This will not manage the configuraiton file, useful if you want to manage configurations seperately.

class  { "conntrackd":
	ensure	=> 'present',
}
