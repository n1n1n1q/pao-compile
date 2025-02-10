# How to use Docker containers when doing labs
### (This is a more detailed guide of one written in README.)

So there are 3 basic ways you can go about using docker containers for compiling your project:
1. You use SSH to connect to a running container and do all your work inside of it
2. You can use VSCode feature, that allows you to open your project inside of a dev-environment
3. You can use project.Dockerfile (Tutorial on this is not finished)

## Where do I get a container?
Let's start from the basics here. If you want yourself a container for the lab you have 3 ways to get one:
1. Build it yourself from Dockerfile
2. Pull image from Docker Registry
3. Use website to get one: [here](https://containers-manager.ucuserver.cc/)

### Build it yourself(Advanced)
To build this image yourself you will need to clone this repo and cd into it:
```bash
git clone https://github.com/n1n1n1q/pao-compile.git
cd pao-compile
```
Then you can make any changes to Dockerfile that you want, for example you need to install some additional libraries. You can use either Alpine or Ubuntu based image, however Ubuntu image is more supported.
After making changes that you want build the image:
```bash
docker build -f <filename depending on what base OS you want> . -t <image_name_that_you_want>
```
Then you will have to wait around 15-20 minutes for Ubuntu docker image to build(<10 minutes for Alpine). After the image is done building you can run it with
```bash
docker run --platform linux/amd64 -e SSH_PASSWORD=<here you can change ssh password> -d -p <ssh port>:22 <image name that you chose>
```
Important: you can remove --platform part, but without it the container will not start on M-series Macbooks. It is safer to just leave it be!

### Pull from container registry
You can pull image from GitHub container registry like so:
```bash
docker pull ghcr.io/n1n1n1q/pao-compile:latest --platform linux/amd64 # for Ubuntu base image
# or
docker pull ghcr.io/n1n1n1q/pao-compile:apline --platform linux/amd64 # for Alpine base image
```
You can run the container with command like above.

### Use our website
You can also go to our [website](https://containers-manager.ucuserver.cc/). While it can support some users, we really would like for you to use your own docker containers. But it being said you can still use them if you need them.
Some limitations are:
- One container per email
- Your container exists for 3 days
It can be sometimes unstable, so just keep it in mind.

So now that this is clear let's talk about usage
First way would be to SSH into a container.
If you used website to get a container, SSH command is included in email. But is you used any of the other 2 methods, your SSH command should look something like this:
```bash
ssh root@localhost -p <port you used when creating container>
```
The second way to use the container, is a VSCode dev-environment. To acsess it you need to:
1. Install extension Remote Explorer
2. In the left-bottom corner click the button, in the list that pops up choose "connect to host"
3. Enter the ssh command similar to above
4. Enter ssh password you chose, or was given to you.
After some time VSCode will install itself inside of Docker Container and you will be able to use it as normal VSCode. This is preferale way to use containers you get on our website.

### project.Dockerfile
TBD
