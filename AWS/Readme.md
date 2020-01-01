## RNS Public AMI:

This is the custom AMI from RNS. Use this AMI and launch the instance with below mentioned UserName and Password.

> #### Step 1:  Choose a region (N.Virginia)

> #### Step 2: Choose a service called as EC2 and then Click on AMI's and search AMI.

[RNS AMI Image](https://console.aws.amazon.com/ec2/home?region=us-east-1#Images:visibility=public-images;ownerAlias=978735513005;sort=name)

```bash
UserName: root

Password: Rnstech@123
```


===========================================================================================================================

## Time Synchronize Issue with AWS accounts in CLI:
----------------------------------------------------
```bash
$ sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"
```
