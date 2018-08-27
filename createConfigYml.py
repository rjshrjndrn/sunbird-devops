import yaml
import os

fname = "data.yaml"

for a in os.environ:
    newdct[a] = os.getenv(a)
    with open(fname, "w") as f:
    yaml.dump(newdct, f)
print("all done")