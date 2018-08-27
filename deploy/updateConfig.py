import yaml
import os

fname = "data.yaml"

for a in os.environ:
    newdct[a] = os.getenv(a)
    with open(fname, "w") as f:
    yaml.dump(newdct, f)
print("all done")

# fname = "data.yaml"
# print '----->'+ $env
# with open(fname, "w") as f:
#     yaml.dump(dct, f)

# with open(fname) as f:
#     newdct = yaml.load(f)

# #print newdct
# newdct['env'] = $env

# with open(fname, "w") as f:
#     yaml.dump(newdct, f)