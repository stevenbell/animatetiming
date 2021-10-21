from vcdvcd import VCDVCD
import json
from lxml import etree
import re
import os

tmpdir = '.'
tmpsvg = 'temp.svg'

config = json.load(open('config_ripplecarry.json'))
timestep=10000 # In femptoseconds

# Load the VCD file
vcd = VCDVCD(config['vcdfile'])

# Load the SVG template and get the namespaces
doc = etree.fromstringlist(open(config['svgtemplate'])).getroottree()
ns = doc.getroot().nsmap

#endtime = vcd.endtime
endtime = timestep * 95

for t in range(0, endtime, timestep):
  for s in vcd.signals:
    # Look up the corresponding SVG group name
    if s not in config['mapping']:
      print("No mapping for signal '{}'; ignoring it.".format(s))
      continue
    sigId = config['mapping'][s]

    # Look up the color corresponding to the signal value
    sigValue = vcd[s][t]
    if sigValue is None:
      sigValue = 'u'
    colorCode = config['colors'][sigValue]

    # Get the SVG group corresponding to this signal
    groups = doc.findall('//svg:g[@id="{}"]'.format(sigId), namespaces=ns)
    if len(groups) != 1:
      print("Didn't find exactly 1 group with ID {}, skipping".format(sigId))
      continue

    # Find all of the SVG path elements in the group and change their stroke color
    paths = groups[0].findall('svg:path', namespaces=ns)
    for p in paths:
      style = p.attrib['style']
      p.attrib['style'] = re.sub("stroke:.*?;", "stroke:{};".format(colorCode), style)

    # Find all of the circles and change their fill color and stroke style (if they are filled/stroked)
    objs = groups[0].findall('svg:circle', namespaces=ns)
    for o in objs:
      style = o.attrib['style']
      o.attrib['style'] = re.sub("fill:.*?;", "fill:{};".format(colorCode), style)
      #o.attrib['style'] = re.sub("stroke:.*?;", "stroke:{};".format(colorCode), style)

  # Now that we've gone through all the signals,
  # Save the updated SVG file
  #doc.write("t_{:03d}.svg".format(int(t / timestep)))
  doc.write(tmpsvg)

  # Call Inkscape to render it
  # PNG
  outfile = tmpdir + os.path.sep + "frame-{:03d}.png".format(int(t / timestep))
  os.system("inkscape --export-png={path} --export-background-opacity=1.0 --export-dpi=144 --export-area-page {temp}".format(path=outfile, temp=tmpsvg))

  # PDF
  # pdf_name = tmpdir + os.path.sep + "frame-{:03d}.pdf".format(page_count)
  # print("Exporting '{id}' to {name}".format(id=label, name=pdf_name))
  # os.system("inkscape --export-pdf={path} --export-area-page {temp}".format(path=pdf_name, temp=tempsvg))


