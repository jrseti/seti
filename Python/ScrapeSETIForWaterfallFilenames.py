
from urllib import urlopen
from re import compile


directoryURL = "http://184.73.240.15/analysis/2010-11-06-dorothy_tauceti_1420_1/images/chan+0000/"

directoryStream = urlopen(directoryURL)

directoryHTML = directoryStream.read()


# testString = '<a href="chan+0000-1-1419.999201-1419.999467.png">'

filenameRegExpString = '<a href="(.*?\.png)">'
filenameRegExp = compile(filenameRegExpString)

foundSome = filenameRegExp.findall(directoryHTML)

print foundSome





