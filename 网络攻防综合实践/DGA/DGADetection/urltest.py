import re
def isValidURL(str):
    # 严格检查
	# regex = ("((http|https)://)(www.)?" +
	# 		"[a-zA-Z0-9@:%._\\+~#?&//=]" +
	# 		"{2,256}\\.[a-z]" +
	# 		"{2,6}\\b([-a-zA-Z0-9@:%" +
	# 		"._\\+~#?&//=]*)")
    #不严格
	regex = ("[a-zA-Z0-9@:%._\\+~#?&//=]" +
			"{2,256}\\.[a-z]" +
			"{2,6}\\b([-a-zA-Z0-9@:%" +
			"._\\+~#?&//=]*)")
	# Compile the ReGex
	p = re.compile(regex)
	if (str == None or str==''):
		return False
	if(re.search(p, str)):
		return True
	else:
		return False
	
if __name__=="__main__":
# Test Case 1:
    print(isValidURL("http://a70crgi.ckhfk7b8e.org"))