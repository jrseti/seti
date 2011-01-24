
from urllib import urlopen
from re import compile

targets = {'tauCeti': "2010-11-06-dorothy_tauceti_1420_1",
 				'epsilonEridani': "2010-11-06-dorothy_epsiloneridani_1420_1",
				'gliese581': "2010-11-05-dorothy_exo-gl581-1420_1"}



directoryURLFormat = "http://184.73.240.15/analysis/%s/images/chan%s/"



waterfallTileActionscriptFormat = '%sObservation.addWaterfallTile(new WaterfallTile(%s, %s, "%s"));\n'


outputFile = open("OutputFromSETIScraper.as", "w")

for target in targets:
	
	targetCode = targets[target]

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
		
			outputFile.write(waterfallTileActionscriptFormat % (target, minWavelengthString, maxWavelengthString, directoryURL + filename))

outputFile.close()






