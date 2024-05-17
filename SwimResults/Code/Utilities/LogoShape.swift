//
//  LogoShape.swift
//  SwimResults
//
//  Created by Konrad Weiß on 15.05.24.
//

import Foundation
import SwiftUI

struct LogoShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.9708*width, y: 0.34006*height))
        path.addCurve(to: CGPoint(x: 0.98585*width, y: 0.34835*height), control1: CGPoint(x: 0.97606*width, y: 0.34127*height), control2: CGPoint(x: 0.98119*width, y: 0.3448*height))
        path.addCurve(to: CGPoint(x: 0.99415*width, y: 0.37519*height), control1: CGPoint(x: 0.99375*width, y: 0.3544*height), control2: CGPoint(x: 0.9962*width, y: 0.3638*height))
        path.addCurve(to: CGPoint(x: 0.9874*width, y: 0.41304*height), control1: CGPoint(x: 0.99188*width, y: 0.3878*height), control2: CGPoint(x: 0.98967*width, y: 0.40044*height))
        path.addCurve(to: CGPoint(x: 0.96743*width, y: 0.43216*height), control1: CGPoint(x: 0.98496*width, y: 0.42657*height), control2: CGPoint(x: 0.97833*width, y: 0.43293*height))
        path.addCurve(to: CGPoint(x: 0.85054*width, y: 0.42382*height), control1: CGPoint(x: 0.92846*width, y: 0.42939*height), control2: CGPoint(x: 0.8895*width, y: 0.42659*height))
        path.addCurve(to: CGPoint(x: 0.73255*width, y: 0.41499*height), control1: CGPoint(x: 0.8112*width, y: 0.42091*height), control2: CGPoint(x: 0.77188*width, y: 0.41807*height))
        path.addCurve(to: CGPoint(x: 0.72825*width, y: 0.42259*height), control1: CGPoint(x: 0.72715*width, y: 0.41456*height), control2: CGPoint(x: 0.72614*width, y: 0.4155*height))
        path.addCurve(to: CGPoint(x: 0.73682*width, y: 0.45827*height), control1: CGPoint(x: 0.73173*width, y: 0.43418*height), control2: CGPoint(x: 0.73374*width, y: 0.44647*height))
        path.addCurve(to: CGPoint(x: 0.74184*width, y: 0.46524*height), control1: CGPoint(x: 0.73756*width, y: 0.46108*height), control2: CGPoint(x: 0.73986*width, y: 0.46477*height))
        path.addCurve(to: CGPoint(x: 0.89248*width, y: 0.49975*height), control1: CGPoint(x: 0.79202*width, y: 0.47701*height), control2: CGPoint(x: 0.84219*width, y: 0.48883*height))
        path.addCurve(to: CGPoint(x: 0.99912*width, y: 0.63555*height), control1: CGPoint(x: 0.94931*width, y: 0.51208*height), control2: CGPoint(x: 0.99222*width, y: 0.5653*height))
        path.addCurve(to: CGPoint(x: 0.99853*width, y: 0.69473*height), control1: CGPoint(x: 1.00103*width, y: 0.65494*height), control2: CGPoint(x: 0.99934*width, y: 0.67501*height))
        path.addCurve(to: CGPoint(x: 0.99021*width, y: 0.88301*height), control1: CGPoint(x: 0.99596*width, y: 0.75751*height), control2: CGPoint(x: 0.99301*width, y: 0.82025*height))
        path.addCurve(to: CGPoint(x: 0.96067*width, y: 0.91877*height), control1: CGPoint(x: 0.98925*width, y: 0.90435*height), control2: CGPoint(x: 0.97634*width, y: 0.91997*height))
        path.addCurve(to: CGPoint(x: 0.93379*width, y: 0.87897*height), control1: CGPoint(x: 0.94433*width, y: 0.91751*height), control2: CGPoint(x: 0.93284*width, y: 0.90043*height))
        path.addCurve(to: CGPoint(x: 0.94362*width, y: 0.65469*height), control1: CGPoint(x: 0.93709*width, y: 0.80422*height), control2: CGPoint(x: 0.94038*width, y: 0.72945*height))
        path.addCurve(to: CGPoint(x: 0.90219*width, y: 0.57806*height), control1: CGPoint(x: 0.94497*width, y: 0.62376*height), control2: CGPoint(x: 0.92837*width, y: 0.59134*height))
        path.addCurve(to: CGPoint(x: 0.86145*width, y: 0.56552*height), control1: CGPoint(x: 0.88933*width, y: 0.57154*height), control2: CGPoint(x: 0.87519*width, y: 0.56873*height))
        path.addCurve(to: CGPoint(x: 0.73753*width, y: 0.53755*height), control1: CGPoint(x: 0.82018*width, y: 0.55591*height), control2: CGPoint(x: 0.77881*width, y: 0.54706*height))
        path.addCurve(to: CGPoint(x: 0.73033*width, y: 0.54275*height), control1: CGPoint(x: 0.73324*width, y: 0.53656*height), control2: CGPoint(x: 0.73215*width, y: 0.53829*height))
        path.addCurve(to: CGPoint(x: 0.71132*width, y: 0.58542*height), control1: CGPoint(x: 0.72442*width, y: 0.55727*height), control2: CGPoint(x: 0.71901*width, y: 0.57249*height))
        path.addCurve(to: CGPoint(x: 0.47069*width, y: 0.98785*height), control1: CGPoint(x: 0.63132*width, y: 0.71977*height), control2: CGPoint(x: 0.55089*width, y: 0.85369*height))
        path.addCurve(to: CGPoint(x: 0.44929*width, y: 0.99997*height), control1: CGPoint(x: 0.46617*width, y: 0.99541*height), control2: CGPoint(x: 0.45701*width, y: 0.99996*height))
        path.addCurve(to: CGPoint(x: 0.07051*width, y: 0.99997*height), control1: CGPoint(x: 0.32121*width, y: height), control2: CGPoint(x: 0.19886*width, y: height))
        path.addCurve(to: CGPoint(x: 0.04998*width, y: 0.99953*height), control1: CGPoint(x: 0.06366*width, y: height), control2: CGPoint(x: 0.05682*width, y: 0.99986*height))
        path.addCurve(to: CGPoint(x: 0.03974*width, y: 0.97606*height), control1: CGPoint(x: 0.03896*width, y: 0.99901*height), control2: CGPoint(x: 0.03417*width, y: 0.98819*height))
        path.addCurve(to: CGPoint(x: 0.04811*width, y: 0.96113*height), control1: CGPoint(x: 0.04216*width, y: 0.97081*height), control2: CGPoint(x: 0.04519*width, y: 0.96598*height))
        path.addCurve(to: CGPoint(x: 0.26363*width, y: 0.60272*height), control1: CGPoint(x: 0.11993*width, y: 0.84164*height), control2: CGPoint(x: 0.19177*width, y: 0.72218*height))
        path.addCurve(to: CGPoint(x: 0.27766*width, y: 0.57994*height), control1: CGPoint(x: 0.26823*width, y: 0.59505*height), control2: CGPoint(x: 0.27322*width, y: 0.58775*height))
        path.addCurve(to: CGPoint(x: 0.286*width, y: 0.53711*height), control1: CGPoint(x: 0.28493*width, y: 0.56717*height), control2: CGPoint(x: 0.28754*width, y: 0.55267*height))
        path.addCurve(to: CGPoint(x: 0.26296*width, y: 0.50139*height), control1: CGPoint(x: 0.28422*width, y: 0.51919*height), control2: CGPoint(x: 0.27582*width, y: 0.5077*height))
        path.addCurve(to: CGPoint(x: 0.01404*width, y: 0.37963*height), control1: CGPoint(x: 0.18002*width, y: 0.46074*height), control2: CGPoint(x: 0.09703*width, y: 0.42017*height))
        path.addCurve(to: CGPoint(x: 0.00046*width, y: 0.34961*height), control1: CGPoint(x: 0.00203*width, y: 0.37377*height), control2: CGPoint(x: -0.00132*width, y: 0.36582*height))
        path.addCurve(to: CGPoint(x: 0.01609*width, y: 0.2034*height), control1: CGPoint(x: 0.00583*width, y: 0.3009*height), control2: CGPoint(x: 0.01097*width, y: 0.25214*height))
        path.addCurve(to: CGPoint(x: 0.0386*width, y: 0.18235*height), control1: CGPoint(x: 0.01777*width, y: 0.18737*height), control2: CGPoint(x: 0.02608*width, y: 0.17939*height))
        path.addCurve(to: CGPoint(x: 0.0522*width, y: 0.18575*height), control1: CGPoint(x: 0.04314*width, y: 0.18342*height), control2: CGPoint(x: 0.04774*width, y: 0.18427*height))
        path.addCurve(to: CGPoint(x: 0.05973*width, y: 0.17947*height), control1: CGPoint(x: 0.0568*width, y: 0.18728*height), control2: CGPoint(x: 0.0592*width, y: 0.18621*height))
        path.addCurve(to: CGPoint(x: 0.06281*width, y: 0.15797*height), control1: CGPoint(x: 0.0603*width, y: 0.17225*height), control2: CGPoint(x: 0.06173*width, y: 0.16513*height))
        path.addCurve(to: CGPoint(x: 0.08671*width, y: 0.1371*height), control1: CGPoint(x: 0.06556*width, y: 0.13969*height), control2: CGPoint(x: 0.07215*width, y: 0.1339*height))
        path.addCurve(to: CGPoint(x: 0.11783*width, y: 0.14421*height), control1: CGPoint(x: 0.09709*width, y: 0.13938*height), control2: CGPoint(x: 0.10746*width, y: 0.14183*height))
        path.addCurve(to: CGPoint(x: 0.22479*width, y: 0.1689*height), control1: CGPoint(x: 0.15349*width, y: 0.15239*height), control2: CGPoint(x: 0.18916*width, y: 0.16048*height))
        path.addCurve(to: CGPoint(x: 0.22965*width, y: 0.16234*height), control1: CGPoint(x: 0.23002*width, y: 0.17013*height), control2: CGPoint(x: 0.23054*width, y: 0.16829*height))
        path.addCurve(to: CGPoint(x: 0.21093*width, y: 0.03535*height), control1: CGPoint(x: 0.22334*width, y: 0.12002*height), control2: CGPoint(x: 0.2176*width, y: 0.07758*height))
        path.addCurve(to: CGPoint(x: 0.22918*width, y: 0.001*height), control1: CGPoint(x: 0.20806*width, y: 0.01721*height), control2: CGPoint(x: 0.21859*width, y: 0.00577*height))
        path.addCurve(to: CGPoint(x: 0.2467*width, y: 0.00825*height), control1: CGPoint(x: 0.23592*width, y: -0.00204*height), control2: CGPoint(x: 0.24158*width, y: 0.00233*height))
        path.addCurve(to: CGPoint(x: 0.39966*width, y: 0.18475*height), control1: CGPoint(x: 0.29765*width, y: 0.06712*height), control2: CGPoint(x: 0.34873*width, y: 0.12583*height))
        path.addCurve(to: CGPoint(x: 0.42177*width, y: 0.21229*height), control1: CGPoint(x: 0.40729*width, y: 0.19357*height), control2: CGPoint(x: 0.41426*width, y: 0.20329*height))
        path.addCurve(to: CGPoint(x: 0.42773*width, y: 0.21517*height), control1: CGPoint(x: 0.42321*width, y: 0.21402*height), control2: CGPoint(x: 0.42565*width, y: 0.21469*height))
        return path
    }
}
