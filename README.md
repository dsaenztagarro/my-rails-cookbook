# doventia-rb-cookbook

This cookbook configures the environment for doventia-rb project with:

Environment:
- git
- vim 

Database:
- PostgreSQL server
- MySQL server
- Sphinx search server

Backend:
- rvm 2.1.0

Actions:
- Create folder $HOME/Development/projects
- Clone doventia-rb repo to projects folder (master)
- Clone dotfiles repo to projects folder (master)
- Create symlinks for dotfiles
- Create `doventia_development` and `doventia_test` databases
- Create user `development` with password `development`
- Grant all privileges to `development` user on databases created

*ATENTION*:
- Actions marked with (X) are private actions so you are free to fork this 
project and change or remove that actions

*NOTES*:
- Verify your rvm version matches the .ruby-version specified in your project so
the gemset is created firt time you access your project

## Supported Platforms

Although this cookbook should be portable to other platforms, the only 
well-tested platform is Mac OS X Mavericks using RVM with ruby-2.1.1

## Usage

### Chef configuration

Pending

### Vagrant configuration

In first place you should comment the next two lines in Vagrantfile:

```
config.ssh.private_key_path = "~/.ssh/id_rsa"
config.ssh.forward_agent = true
```

Then you should apply "Previous steps" mentioned. Once applied previous steps
you should uncomment the two lines.

Everytime you comment/uncomment the lines mentioned, remember to do a 
`vagrant reload` to apply the new configuration.

### Vagrant access

You can access the vagrant vm using the command `vagrant ssh` from the folder of
the Vagrantfile. The recommended way is instead `ssh vagrant@<Vagrant vm ip>`
that let you access from anyplace in your developmenet machine.

Also remember you can add an entry in you /etc/hosts file to improve the
usability of your commands so you can use `ssh vagrant@project.dev`

## Contributing

1. Fork the repository on Bitbucket
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Redradix
