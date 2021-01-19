from pdb import DefaultConfig

class Config(DefaultConfig):
    sticky_by_default = True

    def setup(self, pdb):
        # https://stackoverflow.com/a/35390866
        # Save history across sessions
        import readline
        history_filename = ".pdb_history"
        try:
            readline.read_history_file(history_filename)
        except IOError:
            pass
        import atexit
        atexit.register(readline.write_history_file, history_filename)
        readline.set_history_length(500)
