## ARM Assembly Notes

This one has a README because I wanted to document how to get set up for the next time I come across this itch to try ARM Assembly.

## Building hello.s

### Assembler

We first need to use the assembler `as`, but for this section, .tool-versions has `asdf` installing `arm-none-eabi-as`.

`arm-none-eabi-as hello.s -o hello.o`

### Linker

Once you have successfully used the assembler, you will need to create an ELF executable with the linker, `arm-none-eabi-ld`.

`arm-none-eabi-ld hello.o -o hello.elf`

**NOTE** If you did not give an output name, it will be called `a.out`.

### Running

You can simply run `./hello.elf` to run the executable.
