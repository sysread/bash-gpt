# Command line GPT utils

# Utilities provided

## `gpt`

Sends a prompt or series of prompts to the OpenAI discussions API and outputs
the response as it arrives.

```bash
gpt -s 'You are a helpful assistant' \
    -p 'Rewrite the second act of Much Ado About Nothing in modern English'
```

## `chat`

Provides a command line interface to have conversational interactions similar
to ChatGPT from the command line, with a searchable conversation history.
Simply execute `chat` and follow the menu prompts to start a conversation.

## `cmd`

Generates a command that can be directly executed in your `$SHELL`.

```bash
cmd list files in the current directory with time stamps
```

## `code`

A little wrapper around `gpt` focused on producing code without texty
explanations.

```bash
stack_class=$(code -l python -p 'stack class')
unit_test=$(code -l python -c "$stack_class" -p 'unit test for this class')
```

## `utils`

Library of small utility functions and aliases:

  - `image <prompt> [<size>] > image.png` - generate an image
  - `re-image <source-file> <prompt> > new-image.png` - modify an image

# Dependencies

- [`curl`](https://curl.se/)
- [`jq`](https://github.com/jqlang/jq)
- [`gum`](https://github.com/charmbracelet/gum)

# Installation

## Directly

1. Ensure that `/usr/local/bin` is in your `PATH`
2. Ensure that you have write permissions to `/usr/local/bin`
3. Download to `/usr/local/bin`
```bash

for tool in gpt chat code cmd; do
  curl -sSL "https://raw.githubusercontent.com/sysread/bash-gpt/main/$tool" -o "/usr/local/bin/$tool" \
    && chmod +x "/usr/local/bin/$tool"
done
```

## From repo

1. Check out repository:
```bash
git clone https://github.com/sysread/bash-gpt
```
2. Add to your PATH
```bash
export PATH="$PATH:/path/to/bash-gpt"
```

## Utils

To use the utilities in `utils`, first download it:

```bash
curl -sSL https://raw.githubusercontent.com/sysread/bash-gpt/main/utils -o /usr/local/lib/bash-gpt-utils
```

Then add it to your `.bashrc` or `.bash_profile`:
```bash
echo 'source /usr/local/lib/bash-gpt-utils' >> ~/.bashrc
```

# Environment variables

- `OPENAI_API_KEY` - your OpenAI API key (required; create one at https://beta.openai.com/account/api-keys)
- `OPENAI_MODEL` - the [model](https://platform.openai.com/docs/models) to use; defaults to gpt-3.5-turbo-16k

# Support and compatibility

Tested on macOS. Ought to work on linux as well. Please file a ticket if you
find an issue on mac or linux. Better yet, send me a pull request :)
