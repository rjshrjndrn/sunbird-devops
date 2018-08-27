import yaml
fname = "data.yaml"
print '----->'+ $env
with open(fname, "w") as f:
    yaml.dump(dct, f)

with open(fname) as f:
    newdct = yaml.load(f)

#print newdct
newdct['env'] = $env

with open(fname, "w") as f:
    yaml.dump(newdct, f)