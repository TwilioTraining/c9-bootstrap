# Script to be run during C9 initialization
date > /tmp/c9_init.log
home=/home/ec2-user
ssh_dir=$home/.ssh
REGION=$1
FS_ID=$2

# add public key
if [ ! -d $ssh_dir ]; then
  mkdir $ssh_dir
fi
chmod 700 $ssh_dir
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqVrhdUVXBc36dtSDsi7N3STDN1oScx+BPH4alFrleLA+04fo4LAqULqQf1m4WB2tqPsaRQ0NJmiLb3zKs8Mx63tIeJcutuZDokSNs/AOOEINV3kG9y52vdqSqZb9rwulLiS1JqMAi74O/8/hG73uGWkzGZjeviSVM5scwoBT9QBjpzCamaUGJbI4dCWuM26sbXEFavbuen3gC154ssBIAa/0OX9SAYbZoZ/xP3I0rR7o1U925lOHZORxmf8cpnCDShSeyVqmD/ln8j2KaS5uK4Muu8S9cSUE0jJQQ2pxa9CEhWHeRNHTFuZMw6jyhx8Fx5t6anPK3xobpobafNPY1 trainer@twilio" >> $ssh_dir/authorized_keys
chmod 600 $ssh_dir/authorized_keys

sudo -i -u ec2-user nvm install 8.15.0
sudo -i -u ec2-user nvm alias default 8.15.0

sudo -i -u ec2-user npm install -g create-flex-plugin
sudo -i -u ec2-user npm install -g ngrok

echo 'alias publicip="curl http://169.254.169.254/latest/meta-data/public-ipv4; echo"' >> /home/ec2-user/.bashrc

awk -v ip=`curl http://169.254.169.254/latest/meta-data/public-ipv4; echo` '/Welcome to Twilio/ { print; print "\nYour public IP address: "ip; next }1' ~/bootstrap/README.md > $home/environment/README.md

# mount shared storage
if [[ "$FS_ID" != "None" && ! -z "$FS_ID" && ! -z "$REGION" ]]; then
  yum install -y amazon-efs-utils > /dev/null
  echo "Mounting shared storage..."
  mkdir $home/environment/shared
  chmod a=rwx,o+t $home/environment/shared
  echo "$FS_ID:/ /home/ec2-user/environment/shared efs defaults,_netdev 0 0" >> /etc/fstab
  mount $home/environment/shared
fi
