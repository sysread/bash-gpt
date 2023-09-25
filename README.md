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
curl -sSL https://raw.githubusercontent.com/sysread/bash-gpt/main/gpt -o /usr/local/bin/gpt && \
curl -sSL https://raw.githubusercontent.com/sysread/bash-gpt/main/chat -o /usr/local/bin/chat && \
chmod +x /usr/local/bin/gpt /usr/local/bin/chat
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

# Environment variables

- `OPENAI_API_KEY` - your OpenAI API key (required; create one at https://beta.openai.com/account/api-keys)
- `OPENAI_MODEL` - the [model](https://platform.openai.com/docs/models) to use; defaults to gpt-3.5-turbo-16k

# Support and compatibility

Tested on macOS. Ought to work on linux as well. Please file a ticket if you
find an issue on mac or linux. Better yet, send me a pull request :)
