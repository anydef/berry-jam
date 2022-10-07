def read_config(filename='env.conf'):
    with open(filename, 'r') as f:
        d = {l.split("=")[0]: l.split("=")[1] for l in f if l}
    return d
