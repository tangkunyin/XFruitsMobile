
import Foundation
import HandyJSON

// 收藏列表返回模型
//struct XFCollectionListResult:HandyJSON {
//    var page: Int  = 0
//    var size: Int = 0
//    var content:Array<XFCollectionContent>?
//    var totalElements: Int = 0
//    var totalPages: Int = 0
//}

struct XFCollectionContent: HandyJSON {
    var id: String = ""
    var userId:String = ""
    var productId:String = ""
    var createAt: Int = 0
    var prodName:String = ""
    var prodCover: String = ""
    var prodSpecification:String = ""
    var prodPrimePrice: Float = 0
}

struct XFCollection: HandyJSON {
    var page: Int = 0
    var size: Int = 0
    var totalElements: Int = 0
    var totalPages: Int = 0
    var content: Array<XFCollectionContent>?
}
