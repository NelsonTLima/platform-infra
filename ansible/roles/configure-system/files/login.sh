#!/bin/bash

if [ -n "$SSH_CONNECTION" ]; then
  remote_ip=$(echo $SSH_CONNECTION | awk '{print $1}')
  fmt_ip=$(echo $remote_ip | tr '.' ',')
  tty=$(echo $SSH_TTY | tr '/' '|')

  if command -v tmux > /dev/null && [ -z $TMUX ]; then
    session_name="$USER@$fmt_ip$tty"
    exec tmux new-session -As $session_name
  fi
fi

if [ -z $TMUX ]; then
  export TMOUT=600
fi
