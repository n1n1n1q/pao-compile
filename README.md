# paoCompile
Docker image and a NixOS flake meant for compiling C++ projects.

### Prerequisites
Latest docker version from your package manager

*OR*

Nix package manager

### How to run
1. **Docker**  
    Put the project.Dockerfile into your main
    > *via CLI*
    > ```
    > 
    > ```

    > *VSCode*
    > 1. Install Dev Containers extension in VS Code
    > 2. Open the project in VS Code and click Reopen in container in the right bottom corner

    > *CLion*  
    > TBD
2. **NixOS**

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