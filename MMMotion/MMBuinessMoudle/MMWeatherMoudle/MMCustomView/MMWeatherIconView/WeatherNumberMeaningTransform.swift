//
//  WeatherNumberMeaningTransform.swift
//  YoCelsius
//
//  Created by 王伟奇 on 2017/8/18.
//  Copyright © 2017年 王伟奇. All rights reserved.
//

import UIKit
class WeatherNumberMeaningTransform {
    
    class func fontTextWeatherNumber(number: Int) -> String {
        // Clouds
        // 800	clear sky
        // 801	few clouds
        // 802	scattered clouds
        // 803	broken clouds
        // 804  overcast clouds
        
        /*
         Snow
         ID	Meaning	Icon
         600	light snow	[[file:13d.png]]
         601	snow	[[file:13d.png]]
         602	heavy snow	[[file:13d.png]]
         611	sleet	[[file:13d.png]]
         612	shower sleet	[[file:13d.png]]
         615	light rain and snow	[[file:13d.png]]
         616	rain and snow	[[file:13d.png]]
         620	light shower snow	[[file:13d.png]]
         621	shower snow	[[file:13d.png]]
         622	heavy shower snow	[[file:13d.png]]
         
         
         
         701	mist	[[file:50d.png]]
         711	smoke	[[file:50d.png]]
         721	haze	[[file:50d.png]]
         731	sand, dust whirls	[[file:50d.png]]
         741	fog	[[file:50d.png]]
         751	sand	[[file:50d.png]]
         761	dust	[[file:50d.png]]
         762	volcanic ash	[[file:50d.png]]
         771	squalls	[[file:50d.png]]
         781	tornado	[[file:50d.png]]
         
         
         Rain
         ID	Meaning	Icon
         500	light rain	[[file:10d.png]]
         501	moderate rain	[[file:10d.png]]
         502	heavy intensity rain	[[file:10d.png]]
         503	very heavy rain	[[file:10d.png]]
         504	extreme rain	[[file:10d.png]]
         511	freezing rain	[[file:13d.png]]
         520	light intensity shower rain	[[file:09d.png]]
         521	shower rain	[[file:09d.png]]
         522	heavy intensity shower rain	[[file:09d.png]]
         531	ragged shower rain	[[file:09d.png]]
         
         
         
         
         Drizzle
         ID	Meaning	Icon
         300	light intensity drizzle	[[file:09d.png]]
         301	drizzle	[[file:09d.png]]
         302	heavy intensity drizzle	[[file:09d.png]]
         310	light intensity drizzle rain	[[file:09d.png]]
         311	drizzle rain	[[file:09d.png]]
         312	heavy intensity drizzle rain	[[file:09d.png]]
         313	shower rain and drizzle	[[file:09d.png]]
         314	heavy shower rain and drizzle	[[file:09d.png]]
         321	shower drizzle	[[file:09d.png]]
         
         
         Thunderstorm
         ID	Meaning	Icon
         200	thunderstorm with light rain	[[file:11d.png]]
         201	thunderstorm with rain	[[file:11d.png]]
         202	thunderstorm with heavy rain	[[file:11d.png]]
         210	light thunderstorm	[[file:11d.png]]
         211	thunderstorm	[[file:11d.png]]
         212	heavy thunderstorm	[[file:11d.png]]
         221	ragged thunderstorm	[[file:11d.png]]
         230	thunderstorm with light drizzle	[[file:11d.png]]
         231	thunderstorm with drizzle	[[file:11d.png]]
         232	thunderstorm with heavy drizzle	[[file:11d.png]]
         
         
         Extreme
         
         900	tornado
         901	tropical storm
         902	hurricane
         903	cold
         904	hot
         905	windy
         906	hail
         
         Additional
         
         951	calm
         952	light breeze
         953	gentle breeze
         954	moderate breeze
         955	fresh breeze
         956	strong breeze
         957	high wind, near gale
         958	gale
         959	severe gale
         960	storm
         961	violent storm
         962	hurricane
         */
        
        var weatherText: String?
        
        
        switch number {
        // Extreme + Additional
        case 900:
            weatherText = "e"
            
        case 901,902:
            weatherText = "Y"
            
        case 903:
            weatherText = "o"
            
        case 904:
            weatherText = "h"
            
        case 905:
            weatherText = "a"
            
        case 906:
            weatherText = "W"
            
        case 951:
            weatherText = "B"
            
        case 952,953,954,955,956,957:
            weatherText = "Z"
            
        case 958,959,960,961,962:
            weatherText = "Y"
            
        // Thunderstorm
        case 210,211,212,221:
            weatherText = "T"
            
        case 200,201,202,230,231,232:
            weatherText = "V"
            
        // Drizzle
        case 300,301,302,311,312, 313,314,321:
            weatherText = "R"
            
        // Rain
        case 500:
            weatherText = "R"
            
        case 501,502,503,504:
            weatherText = "S"
            
        case 511,520,521,522,531:
            weatherText = "X"
            
        // Snow
        case 600,601,602, 611,612, 615,616,620,621,622:
            weatherText = "W"
            
            
        // Atmosphere
        case 701:
            weatherText = "N"
            
        case 711,721,731,741:
            weatherText = "G"
            
        case 751,761,762,771:
            weatherText = "O"
            
        case 781:
            weatherText = "e"

            
        // Clouds
        case 800:
            weatherText = "A"
            
        case 801:
            weatherText = "C"
            
        case 802,803,804:
            weatherText = "D"
            
          
        default:
            // 未知的情况
            weatherText = "p"
           

        }
        return weatherText!
    }
    
    class func iconColor(number: Int) -> UIColor {
        
        switch (number) {
            
        // Extreme + Additional
        case 900,901,902, 903,904,905,906,951,952,953,954,955,956,957, 958, 959,960,961,962:
            return UIColor.red
            
            
        // Thunderstorm
        case 210, 211,212,221, 200,201,202, 230, 231, 232:
            return UIColor.red
            
        // Drizzle
        case 300,301,302,311,312, 313,314,321:
            return UIColor.red
            
            
        // Rain
        case 500,501,502,03,504,511,520,521, 522,531:
            return UIColor.red
            
        // Snow
        case 600, 601,602, 611,612,615,616,620,621,622:
            return UIColor(hexString: "9000ff")
            
        // Atmosphere
        case 701, 711,721,731,741,751,761,762,771,781:
            return UIColor.red
            
            
        // Clouds
        case 800,801,802, 803,804:
            return UIColor.orange
            
        default:
            // 未知的情况
            return UIColor.black
        }
        
    }
    
    class func emitterTypeWithNumber(number: Int) -> EMitterType {
        
        var type: EMitterType  = .__NONE
        
        switch (number) {
            
        // Extreme + Additional
        case 900,901,902, 903,904,905, 906,951, 952,953,954,955,956,957, 958,959, 960,961,962:
            break
            
        // Thunderstorm
        case 210, 211,212,221,200,201,202, 230, 231,232:
            type = .__RAIN
            
            
        // Drizzle
        case 300,301,302,311,312,313,314,321:
            type = .__RAIN
            
        // Rain
        case 500, 501,502,503,504,511,520,521,522,531:
            type = .__RAIN
      
            
            
        // Snow
        case 600,601,602,611,612,615,616, 620,621,622:
            type = .__SNOW
            
            
            
        // Atmosphere
        case 701,711,721,731,741,751,761,762,771,781:
            break;
            
            
            
        // Clouds
        case 800,801,802,803,804:
            break;
            
            
            
        default:
            // 未知的情况
            break;
        }
        
        return type;
    }
    
}





























