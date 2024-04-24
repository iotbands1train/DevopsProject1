# java.sh
vi java.sh

#!/bin/bash
sudo yum update -y
sudo yum install java-1.8.0-openjdk -y
sudo yum install git -y
java -version

# chmod a+x java.sh
# ./java.sh

chmod a+x java.sh
./java.sh