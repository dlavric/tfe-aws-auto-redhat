# tfe-aws-auto-redhat

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