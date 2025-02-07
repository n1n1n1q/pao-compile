# paoCompile
Docker image and a NixOS flake meant for compiling C++ projects.

### Prerequisites
Latest docker version from your package manager

*OR*

Nix package manager

#### For M-series Macbook users who want to use Docker
In Docker Desktop app you need to check if Apple Virtualisation Framework and Rosetta 2 is enabled. 
To do so follow the next steps:
1. Go to Settings->General->Virtual Machine Options
2. Select Apple Virtualisation Framework
3. Enable Rosetta 2
4. Select VirtioFS as your file system for containers

### How to run
1. **Docker**  
    Put the project.Dockerfile into your main
    > *via CLI*
    > ```
    > sudo docker -f Ubuntu.Dockerfile . -t ubuntu-cxx
    > ```
    > *wait for build to finish*
    > ```
    > docker run --platform linux/amd64 -d -p 2222:22 ubuntu-cxx
    > ssh root@localhost
    > # default password is root
    > ```

    > *VSCode*
    > 1. Install Dev Containers extension in VS Code
    > 2. Open the project in VS Code and click Reopen in container in the right bottom corner

    > *CLion*  
    > TBD
2. **NixOS**
    ```
    curl -O https://raw.githubusercontent.com/n1n1n1q/paoCompile/blob/main/flake.nix
    curl -O https://raw.githubusercontent.com/n1n1n1q/paoCompile/blob/main/flake.lock
    nix develop
    ```
### Packages included
The enviroments include the following packages: 
* gcc
* clang
* cmake
* make
* autotools
* boost
* eigen 
* gdb
* gcc-multilib
* valgrind
* libarchive
* tbb
* gsl

### License
[MIT License](./LICENSE)
