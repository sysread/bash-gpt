# NAME

gpt

# SYNOPSIS

```
# Generate a something useful, then format it using gum
gpt --prompt "redesign golang so it's not so goddamn awful" | gum format
```

# DESCRIPTION

Interact with OpenAI's conversation completion API from the shell.

# OPTIONS

  `--help`      | `-h`    show help information
  `--prompt`    | `-p`    add a prompt to the list; can be used multiple times
  `--option`    | `-o`    set an openai chat completions API option; can be used multiple times
  `--clear`     | `-c`    clear the cache for the current prompt
  `--clear-all`           clear the cache for all prompts
  `--no-cache`            do not use the cache

# ENV VARS

- `OPENAI_API_KEY` - your OpenAI API key (required; create one at https://beta.openai.com/account/api-keys)
- `OPENAI_MODEL` - the [model](https://platform.openai.com/docs/models) to use; defaults to gpt-3.5-turbo-16k
