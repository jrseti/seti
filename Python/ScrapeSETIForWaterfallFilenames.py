
from urllib import urlopen
from re import compile


targetCode = "2010-11-06-dorothy_tauceti_1420_1"


directoryURLFormat = "http://184.73.240.15/analysis/%s/images/chan%s/"




waterfallTileActionscriptFormat = 'observation.addWaterfallTile(new WaterfallTile(%s, %s, "%s"));\n'
waterfallTileActionScript = ""

for channel in range (-9, 9):
	
	print targetCode, channel;
	
	channelString = "%(channel)+05d" % {'channel':channel}
	directoryURL = directoryURLFormat % (targetCode, channelString)
	directoryStream = urlopen(directoryURL)

	directoryHTML = directoryStream.read()
	directoryStream.close()

	# testString = '<a href="chan+0000-1-1419.999201-1419.999467.png">'

	filenameRegExpString = '<a href="(.*?\.png)">'
	filenameRegExp = compile(filenameRegExpString)

	filenamesForChannel = filenameRegExp.findall(directoryHTML)

	for filename in filenamesForChannel:
		
		minWavelengthString = filename[12:23]
		maxWavelengthString = filename[24:35]
		
		waterfallTileActionScript += waterfallTileActionscriptFormat % (minWavelengthString, maxWavelengthString, directoryURL + filename)

print waterfallTileActionScript






