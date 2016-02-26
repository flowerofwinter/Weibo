
//账号相关
#define AppKey @"944083771"
#define AppSecret @"588d0a822123a9b13c5f7482eea335ed"
#define RedirectURI @"http://www.baidu.com"

#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0)


//自定义log
#ifdef DEBUG
#define IWLog(...)NSLog(__VA_ARGS__)
#else
#define IWLog(...)
#endif

//微博cell其中的一些属性
#define CellBorder 5
#define StatusNameFont @{NSFontAttributeName:[UIFont systemFontOfSize:14]}
#define StatusTimeFont @{NSFontAttributeName:[UIFont systemFontOfSize:12]}
#define StatusTextFont @{NSFontAttributeName:[UIFont systemFontOfSize:13]}
//cell的缩进
#define CellWidth 5

//图片浏览器
#define ImageCellH 70
#define ImageMargin 5