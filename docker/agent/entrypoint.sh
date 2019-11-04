#!/bin/bash

if [ $# -eq 1 ]; then
    exec "$@"
else
    if [ -n "$JENKINS_URL" ]; then
        URL="-url $JENKINS_URL"
    fi

    # if java home is defined, use it
    JAVA_BIN="java"
    if [ "$JAVA_HOME" ]; then
        JAVA_BIN="$JAVA_HOME/bin/java"
    fi

    if [ -n "$JENKINS_SECRET" ]; then
        case "$@" in
          *"${JENKINS_SECRET}"*) echo "Warning: SECRET is defined twice in command-line arguments and the environment variable" ;;
          *)
          SECRET="${JENKINS_SECRET}" ;;
        esac
    fi

    if [ ! -z "$JENKINS_WORKDIR" ]; then
      	case "$@" in
      		*"-workDir"*) echo "Warning: Work directory is defined twice in command-line arguments and the environment variable" ;;
      		*)
      		WORKDIR="-workDir $JENKINS_WORKDIR" ;;
      	esac
    fi

    AGENT_NAME=""
  	if [ -n "$JENKINS_AGENT_NAME" ]; then
    		case "$@" in
    			*"${JENKINS_AGENT_NAME}"*) echo "Warning: AGENT_NAME is defined twice in command-line arguments and the environment variable" ;;
    			*)
    			AGENT_NAME="${JENKINS_AGENT_NAME}" ;;
    		esac
  	fi

    exec $JAVA_BIN $JAVA_OPTS -cp /usr/share/jenkins/agent.jar hudson.remoting.jnlp.Main -headless $WORKDIR $URL $SECRET $AGENT_NAME "$@"
fi
