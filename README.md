# tfe-aws-auto-redhat



```shell
cd tf-code
```

```shell
terraform init

terraform apply
```

Connect to the EC2 instance:
```shell
ssh -i "daniela-redhat-key.pem" ec2-user@ec2-xx-xx-xx-xx.eu-west-2.compute.amazonaws.com
```

NOTE: On your MacOS, If the `key.pem` file has the following ACL `@` setup:
```shell
ls -al daniela-redhat-key.pem
-rw-------@ 1 daniela  staff  1678 Jul 26 13:16 daniela-redhat-key.pem
```

To remove it:
```shell
sudo xattr -c daniela-redhat-key.pem
```

Now verify it has been removed:
```shell
ls -al daniela-redhat-key.pem       
-rw-------  1 daniela  staff  1678 Jul 26 13:16 daniela-redhat-key.pem
```

For late reference, saving the [forum here](https://apple.stackexchange.com/questions/42177/what-does-signify-in-unix-file-permissions)

Note to myself

When the user-data script fails, check the `var/log/cloud-init.log` & `var/log/cloud-init-output.log`.

As a test, take the script, create a `script.sh` file manually and execute it from the CLI with the following command:
```shell
bash -x script.sh 2>&1  | tee -a run.log
```

