# Script to be run during C9 initialization
date > /tmp/c9_init.log

ssh_dir=/home/ec2-user/.ssh
# add public key
if [ ! -d $ssh_dir ]; then
  mkdir $ssh_dir
fi
chmod 700 $ssh_dir
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqVrhdUVXBc36dtSDsi7N3STDN1oScx+BPH4alFrleLA+04fo4LAqULqQf1m4WB2tqPsaRQ0NJmiLb3zKs8Mx63tIeJcutuZDokSNs/AOOEINV3kG9y52vdqSqZb9rwulLiS1JqMAi74O/8/hG73uGWkzGZjeviSVM5scwoBT9QBjpzCamaUGJbI4dCWuM26sbXEFavbuen3gC154ssBIAa/0OX9SAYbZoZ/xP3I0rR7o1U925lOHZORxmf8cpnCDShSeyVqmD/ln8j2KaS5uK4Muu8S9cSUE0jJQQ2pxa9CEhWHeRNHTFuZMw6jyhx8Fx5t6anPK3xobpobafNPY1 trainer@twilio" >> $ssh_dir/authorized_keys
chmod 600 $ssh_dir/authorized_keys

sudo -i -u ec2-user nvm install 8.15.0
sudo -i -u ec2-user nvm alias default 8.15.0
