This project will be investigating the U.S. Education Datasets: Unification Project dataset. As a graduate assistant, teaching is one of my primary duties, and one I didn't expect to be as enjoyable as it is. Since teaching I've become more and more interested in the predicators of success for students, be it at home or in their school culture. Part of this project is to see if I can detect what these predicators may be. In addition I'm curious to look into the various sociological affects on student preformance.


Using the repository:
This repository is best used via Docker although you may be able to consult the Dockerfile to understand what requirements are appropriate to run the code.

Docker is a tool from software engineering (really, deployment) which is nevertheless of great use to the data scientist. Docker builds an environment (think of it as a light weight virtual computer) which contains all the software needed for the project. This allows any user with Docker (or a compatible system) to run the code without bothering with the often complex task of installing all the required libraries.

One Docker container is provided for both "production" and "development." To build it you will need to create a file called .password which contains the password you'd like to use for the rstudio user in the Docker container. Then you run:

docker build . --build-arg linux_user_pwd="$(cat .password)" -t 611-project
This will create a docker container. Users using a unix-flavor should be able to start an RStudio server by running:

docker run -v $(pwd):/home/rstudio/work\
           -p 8787:8787\
           -e PASSWORD="$(cat .password)"\
           -it 611-project
           
You then visit http://localhost:8787 via a browser on your machine to access the machine and development environment. 

