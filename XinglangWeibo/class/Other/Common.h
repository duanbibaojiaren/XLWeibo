/** 昵称的字体 */
#define IWStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define IWRetweetStatusNameFont IWStatusNameFont

/** 时间的字体 */
#define IWStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define IWStatusSourceFont IWStatusTimeFont

/** 正文的字体 */
#define IWStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define IWRetweetStatusContentFont IWStatusContentFont

/** cell的边框宽度 */
#define IWStatusCellBorder 5

// photosView
#define IWPhotoW 70
#define IWPhotoH 70
#define IWPhotoMargin 10

// IWAccountTool
#define IWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"]