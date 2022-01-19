//
//  MapPresenter.swift
//  Seachers
//
//  Created by 近藤大伍 on 2022/01/10.
//

import Foundation
import GoogleMaps


protocol MapPresenterInput {
    
    func loadMap(gourmandSearchData:GourmandSearchDataModel)
    func reloadMap(gourmandSearchData:GourmandSearchDataModel,rangeCount:Int)
    func configureSubViews()
    func requestScrollViewDidEndDecelerating(x:Double,width:Double)
    func requestMapViewDidTap(marker:GMSMarker)
    var shopDataArray: [ShopDataDic]? {get set}
    var markers: [GMSMarker]? {get set}
    
}

protocol MapPresenterOutput {
    
    func setUpMap(idoValue:Double,keidoValue:Double)
    func setUpLocationManager()
    func setUpCollectionView()
    func setUpPickerView()
    func setUpSearchBar()
    func responseScrollViewDidEndDecelerating(marker: GMSMarker)
    func responseMapViewDidTap(marker: GMSMarker,index: Int)
    
}

class MapPresenter: MapPresenterInput{

    
    var markers: [GMSMarker]?
    var shopDataArray: [ShopDataDic]?
    
    private var view: MapPresenterOutput!
    private var gourmandAPIModel: GourmandAPIInput!
    private var travelAPIModel: TravelAPIInput!
    
    init(view: MapViewController) {
        self.view = view
        let gourmandAPIModel = GourmandAPIModel(presenter: self)
        self.gourmandAPIModel = gourmandAPIModel
        self.travelAPIModel = TravelAPIModel()
    }
    
    func requestScrollViewDidEndDecelerating(x:Double,width:Double) {
        let indexCount = x / width
        let marker = markers![Int(indexCount)]
        self.view.responseScrollViewDidEndDecelerating(marker: marker)
    }
    
    func requestMapViewDidTap(marker:GMSMarker) {
        let index = shopDataArray?.firstIndex(where: { $0.key == marker.title })
        self.view.responseMapViewDidTap(marker: marker,index: index!)
    }
    
    
    func loadMap(gourmandSearchData:GourmandSearchDataModel) {
        self.view.setUpLocationManager()
        gourmandAPIModel.setData(gourmandSearchData: gourmandSearchData, rangeCount: 3)
    }
    
    func reloadMap(gourmandSearchData:GourmandSearchDataModel,rangeCount:Int) {
        self.view.setUpLocationManager()
        gourmandAPIModel.setData(gourmandSearchData: gourmandSearchData, rangeCount: rangeCount)
    }
    
    func configureSubViews() {
        self.view.setUpPickerView()
        self.view.setUpSearchBar()
        self.view.setUpCollectionView()
    }
    
}

extension MapPresenter: GourmandAPIOutput{
    
    func resultAPIData(shopDataArray: [ShopDataDic], idoValue: Double, keidoValue: Double) {
        
        self.shopDataArray = shopDataArray
        self.view.setUpMap(idoValue:idoValue,keidoValue:keidoValue)
        for shopDataDic in shopDataArray{
            makeMarker(shopData: shopDataDic.value!)
        }
    }
    
    func makeMarker(shopData:ShopData) {
        let latitude = shopData.latitude!
        let longitude = shopData.longitude!
        let title = shopData.name!
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude,longitude)
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.title = "\(title)"
        marker.snippet = shopData.smallAreaName! + "/" + shopData.genreName!
        markers!.append(marker)
    }
    
}

extension MapPresenter: TravelAPIOutput{
    
    
    
}
