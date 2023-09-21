--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]

--[[ Roll Die Button Parameters --]]
rollButtonParameters = {}
rollButtonParameters.click_function = 'rollButtonClicked'
rollButtonParameters.function_owner = self
rollButtonParameters.label = 'Roll Die'
rollButtonParameters.position = {-5,.6,5}
rollButtonParameters.rotation = {0,0,0}
rollButtonParameters.width = 1000
rollButtonParameters.height = 1000
rollButtonParameters.font_size = 200

--[[ Color Class --]]
Color = {}

function Color.new()
    local instance = {}
    setmetatable(instance, {__index = Color })

    instance.hasPiece = false
    instance.color = ' '
    instance.piece = true
    instance.orderRoll = 0
    instance.properties = {}
    instance.locationIndex = 1
    instance.money = 1500
    instance.inJail = false
    instance.counter = 0
    instance.snapPoint = 0

    return instance
end

--[[ Set Methods --]]
function Color:setHasPiece(bool)
    self.hasPiece = bool
end

function Color:setColor(newColor)
    self.color = newColor
end

function Color:setPiece(piece)
    self.piece = piece
end

function Color:setOrderRoll(roll)
    self.orderRoll = roll
end

function Color:setLocationIndex(index)
    self.locationIndex = index
end

function Color:setInJail(jail)
    self.inJail = jail
end

function Color:setCounter(counter)
    self.counter = counter
end

function Color:setSnapPoint(snapPoint)
    self.snapPoint = snapPoint
end

--[[ Get Methods --]]

function Color:getColor()
    return self.color 
end

function Color:getHasPiece()
    return self.hasPiece
end

function Color:getPiece()
    return self.piece
end

function Color:getOrderRoll()
    return self.orderRoll
end

function Color:getProperties()
    return self.properties
end

function Color:getLocationIndex()
    return self.locationIndex
end

function Color:getInJail()
    return self.inJail
end

function Color:getCounter()
    return self.counter
end

function Color:getSnapPoint()
    return self.snapPoint
end

--[[ Other Methods --]]

function Color:addMoney(amount)
    self.money = self.money + amount
    self.counter.setValue(self.money)
end

function Color:removeMoney(amount)
    self.money = self.money - amount
    self.counter.setValue(self.money)
end

function Color:addProperty(property)
    table.insert(self.properties, property)
end

function Color:removeProperty(property)
    for i, v in ipairs(self.properties) do
        if v == property then
            table.remove(self.properties, i)
        end
    end
end

--[[ Normal Property Class --]]
NormalProperty = {}

function NormalProperty.new(rent, oneHouse, twoHouse, threeHouse, fourHouse, hotel, mortgage, housePrice, houses, price, monopoly, name, owned, owner)
    local instance = {}
    setmetatable(instance, { __index = NormalProperty })

    instance.rent = rent
    instance.oneHouse = oneHouse
    instance.twoHouse = twoHouse
    instance.threeHouse = threeHouse
    instance.fourHouse = fourHouse
    instance.hotel = hotel
    instance.mortgage = mortgage
    instance.housePrice = housePrice
    instance.houses = houses
    instance.price = price
    instance.monopoly = monopoly
    instance.name = name
    instance.owned = owned
    instance.owner = owner
    instance.card = 0

    return instance
end

--[[ Railroad Property Class --]]
RailroadProperty = {}

function RailroadProperty.new()
    local instance = {}
    setmetatable(instance, { __index = RailroadProperty })

    instance.rent = 25
    instance.twoRailroad = 50
    instance.threeRailroad = 100
    instance.fourRailroad = 200
    instance.mortgage = 100
    instance.price = 200
    instance.owned = false
    instance.owner = 0
    instance.card = 0

    return instance
end

--[[ Utility Property Class --]]
UtilityProperty = {}

function UtilityProperty.new()
    local instance = {}
    setmetatable(instance, { __index = UtilityProperty })

    instance.oneUtilityMult = 4
    instance.twoUtilityMult = 10
    instance.mortgage = 75
    instance.price = 150
    instance.owned = false
    instance.owner = 0
    instance.name = ' '
    instance.card = 0

    return instance
end

--[[ Board Pieces Snap Points --]]
SnapPoint = {}

function SnapPoint.new()
    local instance = {}
    setmetatable(instance, { __index = SnapPoint })

    instance.index = 0
    instance.snapPoint = {}
    instance.name = ' '

    return instance
end

--[[ Set Methods --]]
function SnapPoint:setIndex(index) 
    self.index = index
end

function SnapPoint:setSnapPoint(snapPoint) 
    self.snapPoint = snapPoint 
end

--[[ Get Methods --]]
function SnapPoint:getIndex() 
    return self.index
end

function SnapPoint:getSnapPoint() 
    return self.snapPoint
end


--[[ The onLoad event is called after the game save finishes loading. --]]
function onLoad()

    --[[ Variable Inializations --]]
    roll = 0
    
    --[[ Chance Pile Snap Point Initialize --]]
    chancePileSnapPoint = {"Chance"}
    chancePileDiscardSnapPoint = {"Chance Discard"}

    --[[ Community Chest Pile Snap Point Initialize --]]
    communityChestPileSnapPoint = {"Community"}
    communityChestPileDiscardSnapPoint = {"Community Discard"}

    --[[ Dice Snap Point Initialize --]]
    dice1SnapPoint = {'dice1'}
    dice2SnapPoint = {'dice2'}

    --[[ Property Objects --]]
    --[[ Brown --]]
    brown2 = getObjectFromGUID('4cde51')
    brown1 = getObjectFromGUID('cb9676')
    --[[ Light Blue --]]
    lightBlue3 = getObjectFromGUID('943bfa')
    lightBlue2 = getObjectFromGUID('ac2ea7')
    lightBlue1 = getObjectFromGUID('dd63c4')
    --[[ Pink --]]
    pink1 = getObjectFromGUID('46d39f')
    pink2 = getObjectFromGUID('525257')
    pink3 = getObjectFromGUID('8a23cd')
    --[[ Orange --]]
    orange3 = getObjectFromGUID('c4c2a3')
    orange2 = getObjectFromGUID('32d885')
    orange1 = getObjectFromGUID('52fbfe')
    --[[ Red --]]
    red3 = getObjectFromGUID('bc2820')
    red2 = getObjectFromGUID('dada8e')
    red1 = getObjectFromGUID('6696d3')
    --[[ Yellow --]]
    yellow3 = getObjectFromGUID('494cdb')
    yellow2 = getObjectFromGUID('02e25a')
    yellow1 = getObjectFromGUID('e7922d')
    --[[ Green --]]
    green3 = getObjectFromGUID('52407f')
    green2 = getObjectFromGUID('a16b0a')
    green1 = getObjectFromGUID('03744d')
    --[[ Dark Blue --]]
    darkBlue2 = getObjectFromGUID('39a2e4')
    darkBlue1 = getObjectFromGUID('5b0995')
    --[[ RailRoads --]]
    railroad1 = getObjectFromGUID('c7bc37')
    railroad2 = getObjectFromGUID('a60f28')
    railroad3 = getObjectFromGUID('b7a1fa')
    railroad4 = getObjectFromGUID('1f3711')
    --[[ Utility --]]
    utility1 = getObjectFromGUID('559b5f')
    utility2 = getObjectFromGUID('f96c0d')

    --[[ Piece Objects --]]
    objectBoat = getObjectFromGUID('ac8264')
    objectHat = getObjectFromGUID('21ce4e')
    objectWheelbarrow = getObjectFromGUID('28b844')
    objectBoot = getObjectFromGUID('f009fe')
    objectIron = getObjectFromGUID('ab17c4')
    objectCar = getObjectFromGUID('4e2a35')
    objectThimble = getObjectFromGUID('0dac7d')
    objectArtillery = getObjectFromGUID('335f39')

    pieces = {objectBoat, objectHat, objectWheelbarrow, objectBoot, objectIron, objectCar, objectThimble, objectArtillery}

    objectBoat.setName('Boat')
    objectHat.setName('Hat')
    objectWheelbarrow.setName('Wheelbarrow')
    objectBoot.setName('Boot')
    objectIron.setName('Iron')
    objectCar.setName('Car')
    objectThimble.setName('Thimble')
    objectArtillery.setName('Artillery')

    --[[ Dice Objects --]]
    dice1 = getObjectFromGUID('4349f0')
    dice2 = getObjectFromGUID('05d55a')

    --[[ Chance Card Pile --]]
    chancePile = getObjectFromGUID('32c130')
    numChanceDiscard = 0
    chancePile.shuffle()


    --[[Community Chest Pile --]]
    communityChestPile = getObjectFromGUID('2f6aa4')
    numCommunityChestDiscard = 0
    communityChestPile.shuffle()

   
    --[[ Board Object --]]
    board = getObjectFromGUID('d52685')

    --[[ Counter Objects --]]
    counterWhite = getObjectFromGUID('a0b05d')
    counterRed = getObjectFromGUID('21722e')
    counterOrange = getObjectFromGUID('31d15f')
    counterYellow = getObjectFromGUID('520c81')
    counterGreen = getObjectFromGUID('a34c1a')
    counterBlue = getObjectFromGUID('44e6b2')
    counterPurple = getObjectFromGUID('de5fd3')
    counterPink = getObjectFromGUID('16aa98')


    properties = {}

    --[[ Baltic Ave --]]
    properties[brown2] = NormalProperty.new(brown2.getTable('data').rent, brown2.getTable('data').oneHouse, brown2.getTable('data').twoHouse, brown2.getTable('data').threeHouse, brown2.getTable('data').fourHouse, brown2.getTable('data').hotel, brown2.getTable('data').mortgage, brown2.getTable('data').housePrice, brown2.getTable('data').houses, brown2.getTable('data').price, brown2.getTable('data').monopoly, brown2.getTable('data').name, brown2.getTable('data').owned, brown2.getTable('data').owner)
    properties[brown2].card = brown2

    --[[ Mediterannian Ave --]]
    properties[brown1] = NormalProperty.new(brown1.getTable('data').rent, brown1.getTable('data').oneHouse, brown1.getTable('data').twoHouse, brown1.getTable('data').threeHouse, brown1.getTable('data').fourHouse, brown1.getTable('data').hotel, brown1.getTable('data').mortgage, brown1.getTable('data').housePrice, brown1.getTable('data').houses, brown1.getTable('data').price, brown1.getTable('data').monopoly, brown1.getTable('data').name, brown1.getTable('data').owned, brown1.getTable('data').owner)
    properties[brown1].card = brown1

    --[[ Connecticut Ave --]]
    properties[lightBlue3] = NormalProperty.new(lightBlue3.getTable('data').rent, lightBlue3.getTable('data').oneHouse, lightBlue3.getTable('data').twoHouse, lightBlue3.getTable('data').threeHouse, lightBlue3.getTable('data').fourHouse, lightBlue3.getTable('data').hotel, lightBlue3.getTable('data').mortgage, lightBlue3.getTable('data').housePrice, lightBlue3.getTable('data').houses, lightBlue3.getTable('data').price, lightBlue3.getTable('data').monopoly, lightBlue3.getTable('data').name, lightBlue3.getTable('data').owned, lightBlue3.getTable('data').owner)
    properties[lightBlue3].card = lightBlue3

    --[[ Vermont Ave --]]
    properties[lightBlue2] = NormalProperty.new(lightBlue2.getTable('data').rent, lightBlue2.getTable('data').oneHouse, lightBlue2.getTable('data').twoHouse, lightBlue2.getTable('data').threeHouse, lightBlue2.getTable('data').fourHouse, lightBlue2.getTable('data').hotel, lightBlue2.getTable('data').mortgage, lightBlue2.getTable('data').housePrice, lightBlue2.getTable('data').houses, lightBlue2.getTable('data').price, lightBlue2.getTable('data').monopoly, lightBlue2.getTable('data').name, lightBlue2.getTable('data').owned, lightBlue2.getTable('data').owner)
    properties[lightBlue2].card = lightBlue2

    --[[ Oriental Ave --]]
    properties[lightBlue1] = NormalProperty.new(lightBlue1.getTable('data').rent, lightBlue1.getTable('data').oneHouse, lightBlue1.getTable('data').twoHouse, lightBlue1.getTable('data').threeHouse, lightBlue1.getTable('data').fourHouse, lightBlue1.getTable('data').hotel, lightBlue1.getTable('data').mortgage, lightBlue1.getTable('data').housePrice, lightBlue1.getTable('data').houses, lightBlue1.getTable('data').price, lightBlue1.getTable('data').monopoly, lightBlue1.getTable('data').name, lightBlue1.getTable('data').owned, lightBlue1.getTable('data').owner)
    properties[lightBlue1].card = lightBlue1

    --[[ Virginia Ave --]]
    properties[pink3] = NormalProperty.new(pink3.getTable('data').rent, pink3.getTable('data').oneHouse, pink3.getTable('data').twoHouse, pink3.getTable('data').threeHouse, pink3.getTable('data').fourHouse, pink3.getTable('data').hotel, pink3.getTable('data').mortgage, pink3.getTable('data').housePrice, pink3.getTable('data').houses, pink3.getTable('data').price, pink3.getTable('data').monopoly, pink3.getTable('data').name, pink3.getTable('data').owned, pink3.getTable('data').owner)
    properties[pink3].card = pink3

    --[[ States Ave --]]
    properties[pink2] = NormalProperty.new(pink2.getTable('data').rent, pink2.getTable('data').oneHouse, pink2.getTable('data').twoHouse, pink2.getTable('data').threeHouse, pink2.getTable('data').fourHouse, pink2.getTable('data').hotel, pink2.getTable('data').mortgage, pink2.getTable('data').housePrice, pink2.getTable('data').houses, pink2.getTable('data').price, pink2.getTable('data').monopoly, pink2.getTable('data').name, pink2.getTable('data').owned, pink2.getTable('data').owner)
    properties[pink2].card = pink2

    --[[ St. Charles Place --]]
    properties[pink1] = NormalProperty.new(pink1.getTable('data').rent, pink1.getTable('data').oneHouse, pink1.getTable('data').twoHouse, pink1.getTable('data').threeHouse, pink1.getTable('data').fourHouse, pink1.getTable('data').hotel, pink1.getTable('data').mortgage, pink1.getTable('data').housePrice, pink1.getTable('data').houses, pink1.getTable('data').price, pink1.getTable('data').monopoly, pink1.getTable('data').name, pink1.getTable('data').owned, pink1.getTable('data').owner)
    properties[pink1].card = pink1

    --[[ New York Ave --]]
    properties[orange3] = NormalProperty.new(orange3.getTable('data').rent, orange3.getTable('data').oneHouse, orange3.getTable('data').twoHouse, orange3.getTable('data').threeHouse, orange3.getTable('data').fourHouse, orange3.getTable('data').hotel, orange3.getTable('data').mortgage, orange3.getTable('data').housePrice, orange3.getTable('data').houses, orange3.getTable('data').price, orange3.getTable('data').monopoly, orange3.getTable('data').name, orange3.getTable('data').owned, orange3.getTable('data').owner)
    properties[orange3].card = orange3

    --[[ Tennesse Ave --]]
    properties[orange2] = NormalProperty.new(orange2.getTable('data').rent, orange2.getTable('data').oneHouse, orange2.getTable('data').twoHouse, orange2.getTable('data').threeHouse, orange2.getTable('data').fourHouse, orange2.getTable('data').hotel, orange2.getTable('data').mortgage, orange2.getTable('data').housePrice, orange2.getTable('data').houses, orange2.getTable('data').price, orange2.getTable('data').monopoly, orange2.getTable('data').name, orange2.getTable('data').owned, orange2.getTable('data').owner)
    properties[orange2].card = orange2

    --[[ St. James Place --]]
    properties[orange1] = NormalProperty.new(orange1.getTable('data').rent, orange1.getTable('data').oneHouse, orange1.getTable('data').twoHouse, orange1.getTable('data').threeHouse, orange1.getTable('data').fourHouse, orange1.getTable('data').hotel, orange1.getTable('data').mortgage, orange1.getTable('data').housePrice, orange1.getTable('data').houses, orange1.getTable('data').price, orange1.getTable('data').monopoly, orange1.getTable('data').name, orange1.getTable('data').owned, orange1.getTable('data').owner)
    properties[orange1].card = orange1

    --[[ Illinois Ave --]]
    properties[red3] = NormalProperty.new(red3.getTable('data').rent, red3.getTable('data').oneHouse, red3.getTable('data').twoHouse, red3.getTable('data').threeHouse, red3.getTable('data').fourHouse, red3.getTable('data').hotel, red3.getTable('data').mortgage, red3.getTable('data').housePrice, red3.getTable('data').houses, red3.getTable('data').price, red3.getTable('data').monopoly, red3.getTable('data').name, red3.getTable('data').owned, red3.getTable('data').owner)
    properties[red3].card = red3

    --[[ Indiana Ave --]]
    properties[red2] = NormalProperty.new(red2.getTable('data').rent, red2.getTable('data').oneHouse, red2.getTable('data').twoHouse, red2.getTable('data').threeHouse, red2.getTable('data').fourHouse, red2.getTable('data').hotel, red2.getTable('data').mortgage, red2.getTable('data').housePrice, red2.getTable('data').houses, red2.getTable('data').price, red2.getTable('data').monopoly, red2.getTable('data').name, red2.getTable('data').owned, red2.getTable('data').owner)
    properties[red2].card = red2

    --[[ Kentucky Ave --]]
    properties[red1] = NormalProperty.new(red1.getTable('data').rent, red1.getTable('data').oneHouse, red1.getTable('data').twoHouse, red1.getTable('data').threeHouse, red1.getTable('data').fourHouse, red1.getTable('data').hotel, red1.getTable('data').mortgage, red1.getTable('data').housePrice, red1.getTable('data').houses, red1.getTable('data').price, red1.getTable('data').monopoly, red1.getTable('data').name, red1.getTable('data').owned, red1.getTable('data').owner)
    properties[red1].card = red1

    --[[ Marvin Gardens --]]
    properties[yellow3] = NormalProperty.new(yellow3.getTable('data').rent, yellow3.getTable('data').oneHouse, yellow3.getTable('data').twoHouse, yellow3.getTable('data').threeHouse, yellow3.getTable('data').fourHouse, yellow3.getTable('data').hotel, yellow3.getTable('data').mortgage, yellow3.getTable('data').housePrice, yellow3.getTable('data').houses, yellow3.getTable('data').price, yellow3.getTable('data').monopoly, yellow3.getTable('data').name, yellow3.getTable('data').owned, yellow3.getTable('data').owner)
    properties[yellow3].card = yellow3

    --[[ Ventnor Ave --]]
    properties[yellow2] = NormalProperty.new(yellow2.getTable('data').rent, yellow2.getTable('data').oneHouse, yellow2.getTable('data').twoHouse, yellow2.getTable('data').threeHouse, yellow2.getTable('data').fourHouse, yellow2.getTable('data').hotel, yellow2.getTable('data').mortgage, yellow2.getTable('data').housePrice, yellow2.getTable('data').houses, yellow2.getTable('data').price, yellow2.getTable('data').monopoly, yellow2.getTable('data').name, yellow2.getTable('data').owned, yellow2.getTable('data').owner)
    properties[yellow2].card = yellow2

    --[[ Atlantic Ave --]]
    properties[yellow1] = NormalProperty.new(yellow1.getTable('data').rent, yellow1.getTable('data').oneHouse, yellow1.getTable('data').twoHouse, yellow1.getTable('data').threeHouse, yellow1.getTable('data').fourHouse, yellow1.getTable('data').hotel, yellow1.getTable('data').mortgage, yellow1.getTable('data').housePrice, yellow1.getTable('data').houses, yellow1.getTable('data').price, yellow1.getTable('data').monopoly, yellow1.getTable('data').name, yellow1.getTable('data').owned, yellow1.getTable('data').owner)
    properties[yellow1].card = yellow1

    --[[ Pennsylvania Ave --]]
    properties[green3] = NormalProperty.new(green3.getTable('data').rent, green3.getTable('data').oneHouse, green3.getTable('data').twoHouse, green3.getTable('data').threeHouse, green3.getTable('data').fourHouse, green3.getTable('data').hotel, green3.getTable('data').mortgage, green3.getTable('data').housePrice, green3.getTable('data').houses, green3.getTable('data').price, green3.getTable('data').monopoly, green3.getTable('data').name, green3.getTable('data').owned, green3.getTable('data').owner)
    properties[green3].card = green3

    --[[ North Carolina Ave --]]
    properties[green2] = NormalProperty.new(green2.getTable('data').rent, green2.getTable('data').oneHouse, green2.getTable('data').twoHouse, green2.getTable('data').threeHouse, green2.getTable('data').fourHouse, green2.getTable('data').hotel, green2.getTable('data').mortgage, green2.getTable('data').housePrice, green2.getTable('data').houses, green2.getTable('data').price, green2.getTable('data').monopoly, green2.getTable('data').name, green2.getTable('data').owned, green2.getTable('data').owner)
    properties[green2].card = green2

    --[[ Pacific Ave --]]
    properties[green1] = NormalProperty.new(green1.getTable('data').rent, green1.getTable('data').oneHouse, green1.getTable('data').twoHouse, green1.getTable('data').threeHouse, green1.getTable('data').fourHouse, green1.getTable('data').hotel, green1.getTable('data').mortgage, green1.getTable('data').housePrice, green1.getTable('data').houses, green1.getTable('data').price, green1.getTable('data').monopoly, green1.getTable('data').name, green1.getTable('data').owned, green1.getTable('data').owner)
    properties[green1].card = green1

    --[[ Boardwalk --]]
    properties[darkBlue2] = NormalProperty.new(darkBlue2.getTable('data').rent, darkBlue2.getTable('data').oneHouse, darkBlue2.getTable('data').twoHouse, darkBlue2.getTable('data').threeHouse, darkBlue2.getTable('data').fourHouse, darkBlue2.getTable('data').hotel, darkBlue2.getTable('data').mortgage, darkBlue2.getTable('data').housePrice, darkBlue2.getTable('data').houses, darkBlue2.getTable('data').price, darkBlue2.getTable('data').monopoly, darkBlue2.getTable('data').name, darkBlue2.getTable('data').owned, darkBlue2.getTable('data').owner)
    properties[darkBlue2].card = darkBlue2

    --[[ Park Place --]]
    properties[darkBlue1] = NormalProperty.new(darkBlue1.getTable('data').rent, darkBlue1.getTable('data').oneHouse, darkBlue1.getTable('data').twoHouse, darkBlue1.getTable('data').threeHouse, darkBlue1.getTable('data').fourHouse, darkBlue1.getTable('data').hotel, darkBlue1.getTable('data').mortgage, darkBlue1.getTable('data').housePrice, darkBlue1.getTable('data').houses, darkBlue1.getTable('data').price, darkBlue1.getTable('data').monopoly, darkBlue1.getTable('data').name, darkBlue1.getTable('data').owned, darkBlue1.getTable('data').owner)
    properties[darkBlue1].card = darkBlue1

    --[[ Railroad Properies --]]
    properties[railroad1] = RailroadProperty.new()
    properties[railroad1].name = 'Reading Railroad'
    properties[railroad1].card = railroad1

    properties[railroad2] = RailroadProperty.new()
    properties[railroad2].name = 'Pennsylvania Railroad'
    properties[railroad2].card = railroad2

    properties[railroad3] = RailroadProperty.new()
    properties[railroad3].name = 'B & O Railroad'
    properties[railroad3].card = railroad3

    properties[railroad4] = RailroadProperty.new()
    properties[railroad4].name = 'Short Line'
    properties[railroad4].card = railroad4

    --[[ Utility Properties --]]
    properties[utility1] = UtilityProperty.new()
    properties[utility1].name ='Electric Company'
    properties[utility1].card = utility1

    properties[utility2] = UtilityProperty.new()
    properties[utility2].name = 'Water Works'
    properties[utility2].card = utility2

    --[[ Color Objects --]]
    playerWhite = Color.new()
    playerWhite:setColor("White")
    playerWhite:setCounter(counterWhite)

    playerRed = Color.new()
    playerRed:setColor('Red')
    playerRed:setCounter(counterRed)

    playerBlue = Color.new()
    playerBlue:setColor('Blue')
    playerBlue:setCounter(counterBlue)

    playerGreen = Color.new()
    playerGreen:setColor('Green')
    playerGreen:setCounter(counterGreen)

    playerPurple = Color.new()
    playerPurple:setColor('Purple')
    playerPurple:setCounter(counterPurple)

    playerPink = Color.new()
    playerPink:setColor('Pink')
    playerPink:setCounter(counterPink)

    playerOrange = Color.new()
    playerOrange:setColor('Orange')
    playerOrange:setCounter(counterOrange)

    playerYellow = Color.new()
    playerYellow:setColor('Yellow')
    playerYellow:setCounter(counterYellow)

    playerColors = {playerWhite, playerRed, playerBlue, playerGreen, playerPurple, playerPink, playerOrange, playerYellow}

    --[[ Board Snap Points Tables --]]
    mediterannianAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    communityChest1SnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    balticAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   incomeTaxSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   readingRailroadSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   orientalAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    chance1SnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    vermontAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   connecticutAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    visitingJailSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    inJailSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   stCharlesPlaceSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   electricCompanySnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   statesAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   virginiaAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   pennsylvaniaRailroadSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   stJamesPlaceSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    communityChest2SnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

   tennesseeAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    newYorkAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    freeParkingSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    kentuckyAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    chance2SnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    indianaAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    illinoisAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    BORailroadSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    atlanticAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    ventnorAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    waterWorksSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    marvinGardensSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    goToJailSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    pacificAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    northCarolinaAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    communityChest3SnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    pennsylvaniaAveSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    shortLineSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    chance3SnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    parkPlaceSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    luxuryTaxSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    boardwalkSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }

    goSnapPoints = {
        snapPoint1 = SnapPoint.new(),
        snapPoint2 = SnapPoint.new(),
        snapPoint3 = SnapPoint.new()
    }


    --[[ Board Order Snap Points Table --]]
    boardOrder = {goSnapPoints, mediterannianAveSnapPoints, communityChest1SnapPoints, balticAveSnapPoints, incomeTaxSnapPoints, readingRailroadSnapPoints, orientalAveSnapPoints, chance1SnapPoints, vermontAveSnapPoints, connecticutAveSnapPoints, visitingJailSnapPoints,
    stCharlesPlaceSnapPoints, electricCompanySnapPoints, statesAveSnapPoints, virginiaAveSnapPoints, pennsylvaniaRailroadSnapPoints, stJamesPlaceSnapPoints, communityChest2SnapPoints, tennesseeAveSnapPoints, newYorkAveSnapPoints, freeParkingSnapPoints,
    kentuckyAveSnapPoints, chance2SnapPoints, indianaAveSnapPoints, illinoisAveSnapPoints, BORailroadSnapPoints, atlanticAveSnapPoints, ventnorAveSnapPoints, waterWorksSnapPoints, marvinGardensSnapPoints, goToJailSnapPoints, pacificAveSnapPoints, northCarolinaAveSnapPoints,
    communityChest3SnapPoints, pennsylvaniaAveSnapPoints, shortLineSnapPoints, chance3SnapPoints, parkPlaceSnapPoints, luxuryTaxSnapPoints, boardwalkSnapPoints}

    --[[ Board Order Table --]]
    boardOrderNames = {'Go', 'Mediterannian Ave', 'Community Chest 1', 'Baltic Ave', 'Income Tax', 'Reading Railroad', 'Oriental Ave', 'Chance 1', 'Vermont Ave', 'Connecticut Ave', 'Just Visiting', 'St. Charles Place', 'Electric Company', 'States Ave', 'Virginia Ave',
    'Pennsylvania Railroad', 'St. James Place', 'Community Chest 2', 'Tennessee Ave', 'New York Ave', 'Free Parking', 'Kentucky Ave', 'Chance 2', 'Indiana Ave', 'Illinois Ave', 'B & O Railroad', 'Atlantic Ave', 'Ventnor Ave', 'Water Works', 'Marvin Gardens',
    'Go To Jail', 'Pacific Ave', 'North Carolina Ave', 'Community Chest 3', 'Pennsylvania Ave', 'Short Line', 'Chance 3', 'Park Place', 'Luxury Tax', 'Boardwalk'}
    
    boardSnapPoints = board.getSnapPoints()

    for i, v in ipairs(boardSnapPoints) do

        --[[ In Jail --]]
        if v.tags[1] == 'inJail' then
            if inJailSnapPoints.snapPoint1:getIndex() == 0 then
                inJailSnapPoints.snapPoint1:setIndex(i)
                inJailSnapPoints.snapPoint1:setSnapPoint(v)
            elseif inJailSnapPoints.snapPoint2:getIndex() == 0 then
                inJailSnapPoints.snapPoint2:setIndex(i)
                inJailSnapPoints.snapPoint2:setSnapPoint(v)
            elseif inJailSnapPoints.snapPoint3:getIndex() == 0 then
                inJailSnapPoints.snapPoint3:setIndex(i)
                inJailSnapPoints.snapPoint3:setSnapPoint(v)
            end
        end
        
        --[[ Go Tile --]]
        if v.tags[1] == 'Go' then
            if boardOrder[1].snapPoint1:getIndex() == 0 then
                boardOrder[1].snapPoint1:setIndex(i)
                boardOrder[1].snapPoint1:setSnapPoint(v)
            elseif boardOrder[1].snapPoint2:getIndex() == 0 then
                boardOrder[1].snapPoint2:setIndex(i)
                boardOrder[1].snapPoint2:setSnapPoint(v)
            elseif boardOrder[1].snapPoint3:getIndex() == 0 then
                boardOrder[1].snapPoint3:setIndex(i)
                boardOrder[1].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Mediterannian Ave --]]
        if v.tags[1] == 'MedAve' then
            if boardOrder[2].snapPoint1:getIndex() == 0 then
                boardOrder[2].snapPoint1:setIndex(i)
                boardOrder[2].snapPoint1:setSnapPoint(v)
            elseif boardOrder[2].snapPoint2:getIndex() == 0 then
                boardOrder[2].snapPoint2:setIndex(i)
                boardOrder[2].snapPoint2:setSnapPoint(v)
            elseif boardOrder[2].snapPoint3:getIndex() == 0 then
                boardOrder[2].snapPoint3:setIndex(i)
                boardOrder[2].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Community Chest 1 --]]
        if v.tags[1] == 'Com1' then
            if boardOrder[3].snapPoint1:getIndex() == 0 then
                boardOrder[3].snapPoint1:setIndex(i)
                boardOrder[3].snapPoint1:setSnapPoint(v)
            elseif boardOrder[3].snapPoint2:getIndex() == 0 then
                boardOrder[3].snapPoint2:setIndex(i)
                boardOrder[3].snapPoint2:setSnapPoint(v)
            elseif boardOrder[3].snapPoint3:getIndex() == 0 then
                boardOrder[3].snapPoint3:setIndex(i)
                boardOrder[3].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Baltic Ave --]]
        if v.tags[1] == 'BalAve' then
            if boardOrder[4].snapPoint1:getIndex() == 0 then
                boardOrder[4].snapPoint1:setIndex(i)
                boardOrder[4].snapPoint1:setSnapPoint(v)
            elseif boardOrder[4].snapPoint2:getIndex() == 0 then
                boardOrder[4].snapPoint2:setIndex(i)
                boardOrder[4].snapPoint2:setSnapPoint(v)
            elseif boardOrder[4].snapPoint3:getIndex() == 0 then
                boardOrder[4].snapPoint3:setIndex(i)
                boardOrder[4].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Income Tax --]]
        if v.tags[1] == 'IncomeTax' then
            if boardOrder[5].snapPoint1:getIndex() == 0 then
                boardOrder[5].snapPoint1:setIndex(i)
                boardOrder[5].snapPoint1:setSnapPoint(v)
            elseif boardOrder[5].snapPoint2:getIndex() == 0 then
                boardOrder[5].snapPoint2:setIndex(i)
                boardOrder[5].snapPoint2:setSnapPoint(v)
            elseif boardOrder[5].snapPoint3:getIndex() == 0 then
                boardOrder[5].snapPoint3:setIndex(i)
                boardOrder[5].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Reading Railroad --]]
        if v.tags[1] == 'ReadingRailroad' then
            if boardOrder[6].snapPoint1:getIndex() == 0 then
                boardOrder[6].snapPoint1:setIndex(i)
                boardOrder[6].snapPoint1:setSnapPoint(v)
            elseif boardOrder[6].snapPoint2:getIndex() == 0 then
                boardOrder[6].snapPoint2:setIndex(i)
                boardOrder[6].snapPoint2:setSnapPoint(v)
            elseif boardOrder[6].snapPoint3:getIndex() == 0 then
                boardOrder[6].snapPoint3:setIndex(i)
                boardOrder[6].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Oriental Ave --]]
        if v.tags[1] == 'OrientalAve' then
            if boardOrder[7].snapPoint1:getIndex() == 0 then
                boardOrder[7].snapPoint1:setIndex(i)
                boardOrder[7].snapPoint1:setSnapPoint(v)
            elseif boardOrder[7].snapPoint2:getIndex() == 0 then
                boardOrder[7].snapPoint2:setIndex(i)
                boardOrder[7].snapPoint2:setSnapPoint(v)
            elseif boardOrder[7].snapPoint3:getIndex() == 0 then
                boardOrder[7].snapPoint3:setIndex(i)
                boardOrder[7].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Chance 1 --]]
        if v.tags[1] == 'Chance1' then
            if boardOrder[8].snapPoint1:getIndex() == 0 then
                boardOrder[8].snapPoint1:setIndex(i)
                boardOrder[8].snapPoint1:setSnapPoint(v)
            elseif boardOrder[8].snapPoint2:getIndex() == 0 then
                boardOrder[8].snapPoint2:setIndex(i)
                boardOrder[8].snapPoint2:setSnapPoint(v)
            elseif boardOrder[8].snapPoint3:getIndex() == 0 then
                boardOrder[8].snapPoint3:setIndex(i)
                boardOrder[8].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Vermont Ave --]]
        if v.tags[1] == 'VermontAve' then
            if boardOrder[9].snapPoint1:getIndex() == 0 then
                boardOrder[9].snapPoint1:setIndex(i)
                boardOrder[9].snapPoint1:setSnapPoint(v)
            elseif boardOrder[9].snapPoint2:getIndex() == 0 then
                boardOrder[9].snapPoint2:setIndex(i)
                boardOrder[9].snapPoint2:setSnapPoint(v)
            elseif boardOrder[9].snapPoint3:getIndex() == 0 then
                boardOrder[9].snapPoint3:setIndex(i)
                boardOrder[9].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Connecticut Ave --]]
        if v.tags[1] == 'ConnecticutAve' then
            if boardOrder[10].snapPoint1:getIndex() == 0 then
                boardOrder[10].snapPoint1:setIndex(i)
                boardOrder[10].snapPoint1:setSnapPoint(v)
            elseif boardOrder[10].snapPoint2:getIndex() == 0 then
                boardOrder[10].snapPoint2:setIndex(i)
                boardOrder[10].snapPoint2:setSnapPoint(v)
            elseif boardOrder[10].snapPoint3:getIndex() == 0 then
                boardOrder[10].snapPoint3:setIndex(i)
                boardOrder[10].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Just Visiting --]]
        if v.tags[1] == 'VisitingJail' then
            if boardOrder[11].snapPoint1:getIndex() == 0 then
                boardOrder[11].snapPoint1:setIndex(i)
                boardOrder[11].snapPoint1:setSnapPoint(v)
            elseif boardOrder[11].snapPoint2:getIndex() == 0 then
                boardOrder[11].snapPoint2:setIndex(i)
                boardOrder[11].snapPoint2:setSnapPoint(v)
            elseif boardOrder[11].snapPoint3:getIndex() == 0 then
                boardOrder[11].snapPoint3:setIndex(i)
                boardOrder[11].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ St. Charles Place --]]
        if v.tags[1] == 'StCharlesPlace' then
            if boardOrder[12].snapPoint1:getIndex() == 0 then
                boardOrder[12].snapPoint1:setIndex(i)
                boardOrder[12].snapPoint1:setSnapPoint(v)
            elseif boardOrder[12].snapPoint2:getIndex() == 0 then
                boardOrder[12].snapPoint2:setIndex(i)
                boardOrder[12].snapPoint2:setSnapPoint(v)
            elseif boardOrder[12].snapPoint3:getIndex() == 0 then
                boardOrder[12].snapPoint3:setIndex(i)
                boardOrder[12].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Electric Company --]]
        if v.tags[1] == 'ElecticCompany' then
            if boardOrder[13].snapPoint1:getIndex() == 0 then
                boardOrder[13].snapPoint1:setIndex(i)
                boardOrder[13].snapPoint1:setSnapPoint(v)
            elseif boardOrder[13].snapPoint2:getIndex() == 0 then
                boardOrder[13].snapPoint2:setIndex(i)
                boardOrder[13].snapPoint2:setSnapPoint(v)
            elseif boardOrder[13].snapPoint3:getIndex() == 0 then
                boardOrder[13].snapPoint3:setIndex(i)
                boardOrder[13].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ States Ave --]]
        if v.tags[1] == 'StatesAve' then
            if boardOrder[14].snapPoint1:getIndex() == 0 then
                boardOrder[14].snapPoint1:setIndex(i)
                boardOrder[14].snapPoint1:setSnapPoint(v)
            elseif boardOrder[14].snapPoint2:getIndex() == 0 then
                boardOrder[14].snapPoint2:setIndex(i)
                boardOrder[14].snapPoint2:setSnapPoint(v)
            elseif boardOrder[14].snapPoint3:getIndex() == 0 then
                boardOrder[14].snapPoint3:setIndex(i)
                boardOrder[14].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Virginia Ave --]]
        if v.tags[1] == 'VirginiaAve' then
            if boardOrder[15].snapPoint1:getIndex() == 0 then
                boardOrder[15].snapPoint1:setIndex(i)
                boardOrder[15].snapPoint1:setSnapPoint(v)
            elseif boardOrder[15].snapPoint2:getIndex() == 0 then
                boardOrder[15].snapPoint2:setIndex(i)
                boardOrder[15].snapPoint2:setSnapPoint(v)
            elseif boardOrder[15].snapPoint3:getIndex() == 0 then
                boardOrder[15].snapPoint3:setIndex(i)
                boardOrder[15].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Pennsylvania Railroad --]]
        if v.tags[1] == 'PennsylvaniaRailroad' then
            if boardOrder[16].snapPoint1:getIndex() == 0 then
                boardOrder[16].snapPoint1:setIndex(i)
                boardOrder[16].snapPoint1:setSnapPoint(v)
            elseif boardOrder[16].snapPoint2:getIndex() == 0 then
                boardOrder[16].snapPoint2:setIndex(i)
                boardOrder[16].snapPoint2:setSnapPoint(v)
            elseif boardOrder[16].snapPoint3:getIndex() == 0 then
                boardOrder[16].snapPoint3:setIndex(i)
                boardOrder[16].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ St. James Place --]]
        if v.tags[1] == 'StJamesPlace' then
            if boardOrder[17].snapPoint1:getIndex() == 0 then
                boardOrder[17].snapPoint1:setIndex(i)
                boardOrder[17].snapPoint1:setSnapPoint(v)
            elseif boardOrder[17].snapPoint2:getIndex() == 0 then
                boardOrder[17].snapPoint2:setIndex(i)
                boardOrder[17].snapPoint2:setSnapPoint(v)
            elseif boardOrder[17].snapPoint3:getIndex() == 0 then
                boardOrder[17].snapPoint3:setIndex(i)
                boardOrder[17].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Community Chest 2 --]]
        if v.tags[1] == 'Com2' then
            if boardOrder[18].snapPoint1:getIndex() == 0 then
                boardOrder[18].snapPoint1:setIndex(i)
                boardOrder[18].snapPoint1:setSnapPoint(v)
            elseif boardOrder[18].snapPoint2:getIndex() == 0 then
                boardOrder[18].snapPoint2:setIndex(i)
                boardOrder[18].snapPoint2:setSnapPoint(v)
            elseif boardOrder[18].snapPoint3:getIndex() == 0 then
                boardOrder[18].snapPoint3:setIndex(i)
                boardOrder[18].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Tennessee Ave --]]
        if v.tags[1] == 'TennesseeAve' then
            if boardOrder[19].snapPoint1:getIndex() == 0 then
                boardOrder[19].snapPoint1:setIndex(i)
                boardOrder[19].snapPoint1:setSnapPoint(v)
            elseif boardOrder[19].snapPoint2:getIndex() == 0 then
                boardOrder[19].snapPoint2:setIndex(i)
                boardOrder[19].snapPoint2:setSnapPoint(v)
            elseif boardOrder[19].snapPoint3:getIndex() == 0 then
                boardOrder[19].snapPoint3:setIndex(i)
                boardOrder[19].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ New York Ave --]]
        if v.tags[1] == 'NewYorkAve' then
            if boardOrder[20].snapPoint1:getIndex() == 0 then
                boardOrder[20].snapPoint1:setIndex(i)
                boardOrder[20].snapPoint1:setSnapPoint(v)
            elseif boardOrder[20].snapPoint2:getIndex() == 0 then
                boardOrder[20].snapPoint2:setIndex(i)
                boardOrder[20].snapPoint2:setSnapPoint(v)
            elseif boardOrder[20].snapPoint3:getIndex() == 0 then
                boardOrder[20].snapPoint3:setIndex(i)
                boardOrder[20].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Free Parking --]]
        if v.tags[1] == 'FreeParking' then
            if boardOrder[21].snapPoint1:getIndex() == 0 then
                boardOrder[21].snapPoint1:setIndex(i)
                boardOrder[21].snapPoint1:setSnapPoint(v)
            elseif boardOrder[21].snapPoint2:getIndex() == 0 then
                boardOrder[21].snapPoint2:setIndex(i)
                boardOrder[21].snapPoint2:setSnapPoint(v)
            elseif boardOrder[21].snapPoint3:getIndex() == 0 then
                boardOrder[21].snapPoint3:setIndex(i)
                boardOrder[21].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Kentucky Ave --]]
        if v.tags[1] == 'KentuckyAve' then
            if boardOrder[22].snapPoint1:getIndex() == 0 then
                boardOrder[22].snapPoint1:setIndex(i)
                boardOrder[22].snapPoint1:setSnapPoint(v)
            elseif boardOrder[22].snapPoint2:getIndex() == 0 then
                boardOrder[22].snapPoint2:setIndex(i)
                boardOrder[22].snapPoint2:setSnapPoint(v)
            elseif boardOrder[22].snapPoint3:getIndex() == 0 then
                boardOrder[22].snapPoint3:setIndex(i)
                boardOrder[22].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Chance 2 --]]
        if v.tags[1] == 'Chance2' then
            if boardOrder[23].snapPoint1:getIndex() == 0 then
                boardOrder[23].snapPoint1:setIndex(i)
                boardOrder[23].snapPoint1:setSnapPoint(v)
            elseif boardOrder[23].snapPoint2:getIndex() == 0 then
                boardOrder[23].snapPoint2:setIndex(i)
                boardOrder[23].snapPoint2:setSnapPoint(v)
            elseif boardOrder[23].snapPoint3:getIndex() == 0 then
                boardOrder[23].snapPoint3:setIndex(i)
                boardOrder[23].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Indiana Ave --]]
        if v.tags[1] == 'IndianaAve' then
            if boardOrder[24].snapPoint1:getIndex() == 0 then
                boardOrder[24].snapPoint1:setIndex(i)
                boardOrder[24].snapPoint1:setSnapPoint(v)
            elseif boardOrder[24].snapPoint2:getIndex() == 0 then
                boardOrder[24].snapPoint2:setIndex(i)
                boardOrder[24].snapPoint2:setSnapPoint(v)
            elseif boardOrder[24].snapPoint3:getIndex() == 0 then
                boardOrder[24].snapPoint3:setIndex(i)
                boardOrder[24].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Illinois Ave --]]
        if v.tags[1] == 'IllinoisAve' then
            if boardOrder[25].snapPoint1:getIndex() == 0 then
                boardOrder[25].snapPoint1:setIndex(i)
                boardOrder[25].snapPoint1:setSnapPoint(v)
            elseif boardOrder[25].snapPoint2:getIndex() == 0 then
                boardOrder[25].snapPoint2:setIndex(i)
                boardOrder[25].snapPoint2:setSnapPoint(v)
            elseif boardOrder[25].snapPoint3:getIndex() == 0 then
                boardOrder[25].snapPoint3:setIndex(i)
                boardOrder[25].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ B & O Railroad --]]
        if v.tags[1] == 'BORailroad' then
            if boardOrder[26].snapPoint1:getIndex() == 0 then
                boardOrder[26].snapPoint1:setIndex(i)
                boardOrder[26].snapPoint1:setSnapPoint(v)
            elseif boardOrder[26].snapPoint2:getIndex() == 0 then
                boardOrder[26].snapPoint2:setIndex(i)
                boardOrder[26].snapPoint2:setSnapPoint(v)
            elseif boardOrder[26].snapPoint3:getIndex() == 0 then
                boardOrder[26].snapPoint3:setIndex(i)
                boardOrder[26].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Atlantic Ave --]]
        if v.tags[1] == 'AtlanticAve' then
            if boardOrder[27].snapPoint1:getIndex() == 0 then
                boardOrder[27].snapPoint1:setIndex(i)
                boardOrder[27].snapPoint1:setSnapPoint(v)
            elseif boardOrder[27].snapPoint2:getIndex() == 0 then
                boardOrder[27].snapPoint2:setIndex(i)
                boardOrder[27].snapPoint2:setSnapPoint(v)
            elseif boardOrder[27].snapPoint3:getIndex() == 0 then
                boardOrder[27].snapPoint3:setIndex(i)
                boardOrder[27].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Ventnor Ave --]]
        if v.tags[1] == 'VentnorAve' then
            if boardOrder[28].snapPoint1:getIndex() == 0 then
                boardOrder[28].snapPoint1:setIndex(i)
                boardOrder[28].snapPoint1:setSnapPoint(v)
            elseif boardOrder[28].snapPoint2:getIndex() == 0 then
                boardOrder[28].snapPoint2:setIndex(i)
                boardOrder[28].snapPoint2:setSnapPoint(v)
            elseif boardOrder[28].snapPoint3:getIndex() == 0 then
                boardOrder[28].snapPoint3:setIndex(i)
                boardOrder[28].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Water Works --]]
        if v.tags[1] == 'WaterWorks' then
            if boardOrder[29].snapPoint1:getIndex() == 0 then
                boardOrder[29].snapPoint1:setIndex(i)
                boardOrder[29].snapPoint1:setSnapPoint(v)
            elseif boardOrder[29].snapPoint2:getIndex() == 0 then
                boardOrder[29].snapPoint2:setIndex(i)
                boardOrder[29].snapPoint2:setSnapPoint(v)
            elseif boardOrder[29].snapPoint3:getIndex() == 0 then
                boardOrder[29].snapPoint3:setIndex(i)
                boardOrder[29].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Marvin Gardens --]]
        if v.tags[1] == 'MarvinGardens' then
            if boardOrder[30].snapPoint1:getIndex() == 0 then
                boardOrder[30].snapPoint1:setIndex(i)
                boardOrder[30].snapPoint1:setSnapPoint(v)
            elseif boardOrder[30].snapPoint2:getIndex() == 0 then
                boardOrder[30].snapPoint2:setIndex(i)
                boardOrder[30].snapPoint2:setSnapPoint(v)
            elseif boardOrder[30].snapPoint3:getIndex() == 0 then
                boardOrder[30].snapPoint3:setIndex(i)
                boardOrder[30].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Go To Jail --]]
        if v.tags[1] == 'GoToJail' then
            if boardOrder[31].snapPoint1:getIndex() == 0 then
                boardOrder[31].snapPoint1:setIndex(i)
                boardOrder[31].snapPoint1:setSnapPoint(v)
            elseif boardOrder[31].snapPoint2:getIndex() == 0 then
                boardOrder[31].snapPoint2:setIndex(i)
                boardOrder[31].snapPoint2:setSnapPoint(v)
            elseif boardOrder[31].snapPoint3:getIndex() == 0 then
                boardOrder[31].snapPoint3:setIndex(i)
                boardOrder[31].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Pacific Ave --]]
        if v.tags[1] == 'PacificAve' then
            if boardOrder[32].snapPoint1:getIndex() == 0 then
                boardOrder[32].snapPoint1:setIndex(i)
                boardOrder[32].snapPoint1:setSnapPoint(v)
            elseif boardOrder[32].snapPoint2:getIndex() == 0 then
                boardOrder[32].snapPoint2:setIndex(i)
                boardOrder[32].snapPoint2:setSnapPoint(v)
            elseif boardOrder[32].snapPoint3:getIndex() == 0 then
                boardOrder[32].snapPoint3:setIndex(i)
                boardOrder[32].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ North Carolina Ave --]]
        if v.tags[1] == 'NorthCarolinaAve' then
            if boardOrder[33].snapPoint1:getIndex() == 0 then
                boardOrder[33].snapPoint1:setIndex(i)
                boardOrder[33].snapPoint1:setSnapPoint(v)
            elseif boardOrder[33].snapPoint2:getIndex() == 0 then
                boardOrder[33].snapPoint2:setIndex(i)
                boardOrder[33].snapPoint2:setSnapPoint(v)
            elseif boardOrder[33].snapPoint3:getIndex() == 0 then
                boardOrder[33].snapPoint3:setIndex(i)
                boardOrder[33].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Community Chest 3 --]]
        if v.tags[1] == 'Com3' then
            if boardOrder[34].snapPoint1:getIndex() == 0 then
                boardOrder[34].snapPoint1:setIndex(i)
                boardOrder[34].snapPoint1:setSnapPoint(v)
            elseif boardOrder[34].snapPoint2:getIndex() == 0 then
                boardOrder[34].snapPoint2:setIndex(i)
                boardOrder[34].snapPoint2:setSnapPoint(v)
            elseif boardOrder[34].snapPoint3:getIndex() == 0 then
                boardOrder[34].snapPoint3:setIndex(i)
                boardOrder[34].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Pennsylvania Ave --]]
        if v.tags[1] == 'PennsylvaniaAve' then
            if boardOrder[35].snapPoint1:getIndex() == 0 then
                boardOrder[35].snapPoint1:setIndex(i)
                boardOrder[35].snapPoint1:setSnapPoint(v)
            elseif boardOrder[35].snapPoint2:getIndex() == 0 then
                boardOrder[35].snapPoint2:setIndex(i)
                boardOrder[35].snapPoint2:setSnapPoint(v)
            elseif boardOrder[35].snapPoint3:getIndex() == 0 then
                boardOrder[35].snapPoint3:setIndex(i)
                boardOrder[35].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Short Line --]]
        if v.tags[1] == 'ShortLine' then
            if boardOrder[36].snapPoint1:getIndex() == 0 then
                boardOrder[36].snapPoint1:setIndex(i)
                boardOrder[36].snapPoint1:setSnapPoint(v)
            elseif boardOrder[36].snapPoint2:getIndex() == 0 then
                boardOrder[36].snapPoint2:setIndex(i)
                boardOrder[36].snapPoint2:setSnapPoint(v)
            elseif boardOrder[36].snapPoint3:getIndex() == 0 then
                boardOrder[36].snapPoint3:setIndex(i)
                boardOrder[36].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Chance 3 --]]
        if v.tags[1] == 'Chance3' then
            if boardOrder[37].snapPoint1:getIndex() == 0 then
                boardOrder[37].snapPoint1:setIndex(i)
                boardOrder[37].snapPoint1:setSnapPoint(v)
            elseif boardOrder[37].snapPoint2:getIndex() == 0 then
                boardOrder[37].snapPoint2:setIndex(i)
                boardOrder[37].snapPoint2:setSnapPoint(v)
            elseif boardOrder[37].snapPoint3:getIndex() == 0 then
                boardOrder[37].snapPoint3:setIndex(i)
                boardOrder[37].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Park Place --]]
        if v.tags[1] == 'ParkPlace' then
            if boardOrder[38].snapPoint1:getIndex() == 0 then
                boardOrder[38].snapPoint1:setIndex(i)
                boardOrder[38].snapPoint1:setSnapPoint(v)
            elseif boardOrder[38].snapPoint2:getIndex() == 0 then
                boardOrder[38].snapPoint2:setIndex(i)
                boardOrder[38].snapPoint2:setSnapPoint(v)
            elseif boardOrder[38].snapPoint3:getIndex() == 0 then
                boardOrder[38].snapPoint3:setIndex(i)
                boardOrder[38].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Luxury Tax --]]
        if v.tags[1] == 'LuxuryTax' then
            if boardOrder[39].snapPoint1:getIndex() == 0 then
                boardOrder[39].snapPoint1:setIndex(i)
                boardOrder[39].snapPoint1:setSnapPoint(v)
            elseif boardOrder[39].snapPoint2:getIndex() == 0 then
                boardOrder[39].snapPoint2:setIndex(i)
                boardOrder[39].snapPoint2:setSnapPoint(v)
            elseif boardOrder[39].snapPoint3:getIndex() == 0 then
                boardOrder[39].snapPoint3:setIndex(i)
                boardOrder[39].snapPoint3:setSnapPoint(v)
            end
        end

        --[[ Boardwalk --]]
        if v.tags[1] == 'Boardwalk' then
            if boardOrder[40].snapPoint1:getIndex() == 0 then
                boardOrder[40].snapPoint1:setIndex(i)
                boardOrder[40].snapPoint1:setSnapPoint(v)
            elseif boardOrder[40].snapPoint2:getIndex() == 0 then
                boardOrder[40].snapPoint2:setIndex(i)
                boardOrder[40].snapPoint2:setSnapPoint(v)
            elseif boardOrder[40].snapPoint3:getIndex() == 0 then
                boardOrder[40].snapPoint3:setIndex(i)
                boardOrder[40].snapPoint3:setSnapPoint(v)
            end
        end

        
        --[[ Chance Pile Snap Point --]]
        if v.tags[1] == 'ChancePile' then
            chancePileSnapPoint = v
        end

        if v.tags[1] == 'ChanceDiscard' then
            chancePileDiscardSnapPoint = v
        end

        --[[ Community Chest Pile Snap Point --]]
        if v.tags[1] == 'CommunityPile' then
            communityChestPileSnapPoint = v
        end

        if v.tags[1] == 'CommunityDiscard' then
            communityChestPileDiscardSnapPoint = v
        end

        --[[ Dice Snap Points --]]
        if v.tags[1] == 'Dice1' then 
            dice1SnapPoint = v
        end

        if v.tags[1] == 'Dice2' then 
            dice2SnapPoint = v
        end

    end

    for i, v in ipairs(Global.getSnapPoints()) do
        --[[ Property Drop Off Snap Points --]]
        if v.tags[1] == 'BlueProperty' then
            playerBlue:setSnapPoint(v)
        end

        if v.tags[1] == 'GreenProperty' then
            playerGreen:setSnapPoint(v)
        end

        if v.tags[1] == 'WhiteProperty' then
            playerWhite:setSnapPoint(v)
        end

        if v.tags[1] == 'YellowProperty' then
            playerYellow:setSnapPoint(v)   
        end

        if v.tags[1] == 'RedProperty' then
            playerRed:setSnapPoint(v)  
        end

        if v.tags[1] == 'OrangeProperty' then
            playerOrange:setSnapPoint(v) 
        end

        if v.tags[1] == 'PinkProperty' then
            playerPink:setSnapPoint(v)
        end

        if v.tags[1] == 'PurpleProperty' then
            playerPurple:setSnapPoint(v)
        end

    end

end



--[[ Start Game --]]
function startGame(player, value, id)
    self.UI.setAttribute("Game Start", "active", false)

    table.sort(playerColors, compareColors)
    order = {playerColors[1]:getColor(), playerColors[2]:getColor(), playerColors[3]:getColor(), playerColors[4]:getColor(),
    playerColors[5]:getColor(), playerColors[6]:getColor(), playerColors[7]:getColor(), playerColors[8]:getColor()
    }
    Turns.order = order
    Turns.enable = true

    testButtonParameters = {}
    testButtonParameters.click_function = 'testButtonClicked'
    testButtonParameters.function_owner = self
    testButtonParameters.label = 'Test'
    testButtonParameters.position = {-3.5,.6,5}
    testButtonParameters.rotation = {0,0,0}
    testButtonParameters.width = 1000
    testButtonParameters.height = 1000
    testButtonParameters.font_size = 200
    --[[ Test Button --]]
    board.createButton(testButtonParameters)

    --[[ Move Die and Card Piles --]]
    moveOnBoard(dice1, dice1SnapPoint.position)
    moveOnBoard(dice2, dice2SnapPoint.position)
    moveOnBoard(chancePile, chancePileSnapPoint.position)
    chancePile.setRotationSmooth({180,135,0})
    moveOnBoard(communityChestPile, communityChestPileSnapPoint.position)
    communityChestPile.setRotationSmooth({180,315,0})

    for i, v in ipairs(pieces) do
        if v.getColorTint().b <= 0.095 and v.getColorTint().b >= .09 then
            pieces[i].destruct()
        end
    end
    
    
end

--[[ Piece Select Function --]]
function selectPiece(player, value, id) 
    -- Initialize all variables
    local colorString = player.color
    local buttonToObjectMap = {
        ["Boat"] = objectBoat,
        ["Hat"] = objectHat,
        ["Car"] = objectCar,
        ["Thimble"] = objectThimble,
        ["Wheelbarrow"] = objectWheelbarrow,
        ["Boot"] = objectBoot,
        ["Iron"] = objectIron,
        ["Artillery"] = objectArtillery,
    }
    local objectToSet = buttonToObjectMap[id]
    local visibility = changeVisibility(colorString, self.UI.getAttribute(id, "visibility"))
    -- Set the button to inactive and remove the UI from the player who pressed the buttons screen
    self.UI.setAttribute(id, "active", false)
    self.UI.setAttribute("Game Setup", "visibility", visibility)

    -- Get the index of the playerColors for the color parameter
    local index = 0
    for x, y in ipairs(playerColors) do
        if colorString == y.color then
            index = x
        end
    end

    -- Set the piece selected to the correct player color
    playerColors[index]:setHasPiece(true)
    playerColors[index]:setPiece(objectToSet)
    objectToSet.setColorTint(colorString)

end

function testButtonClicked(obj,color,alt_click) 
    moveOnRoll(7,color)
end

--[[ On Player Turn Start --]]
function onPlayerTurn(player, previous_player)
    self.UI.setAttribute("rollDie", "active", true)
    self.UI.setAttribute("Player Turn", "visibility", player.color)
end

function changeVisibility(colorString, visibility)
    local colorTable = {}
    -- Split string by | and add each color to a new table 
    for color in string.gmatch(visibility, "[^|]+") do
        table.insert(colorTable, color)
    end

    --  Remove the color of the player that pressed the button 
    for i, color in ipairs(colorTable) do
        if color == colorString then
            table.remove(colorTable, i)
            break
        end
    end

    visibility = table.concat(colorTable, "|")
    -- Reform the string with all the colors and | in between each
    return visibility
end

--[[ Roll For Order Button when Clicked Function --]]
function rollForOrder(player,value,id)
    -- Initialize Variables
    local color = player.color

    visibility = changeVisibility(color, self.UI.getAttribute(id, "visibility"))
    -- Hide the button for player who rolled
    self.UI.setAttribute(id, "visibility", visibility)

    -- Roll the Dice
    dice1.randomize()
    dice2.randomize()

    -- Print out message to players
    printToAll(player.steam_name .. " is rolling...", color)

    -- Get both dice values once they are done rolling and set to playerColor
    Wait.condition(
    function() 
    print('Rolled: ', dice1.getValue() + dice2.getValue()) 
    roll = dice1.getValue() + dice2.getValue()
    for i, v in ipairs(playerColors) do
        if v:getColor() == color then
            playerColors[i]:setOrderRoll(roll)
        end
    end
    end, function() return dice1.resting and dice2.resting end)
end

--[[ Roll Button Click Function --]]
function rollDie(player, value, id)
    self.UI.setAttribute("rollDie", "active", false)
    local color = player.color
    dice1.randomize()
    dice2.randomize()
    
    printToAll(player.steam_name .. " is rolling...", color)
    Wait.condition(
    function()
    roll = dice1.getValue() + dice2.getValue() 
    printToAll("Rolled: " .. roll, color) 
    moveOnRoll(roll, color)
    end,
    function() return dice1.resting and dice2.resting end)
end

--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
end

--[[ Move On Roll Function --]]
function moveOnRoll(roll, color)
    local playerColor = getCurrentPlayerColor(color)
    --[[ Deal with player reaching go again --]]
    if playerColor:getLocationIndex() + roll < 41 then
        index = playerColor:getLocationIndex() + roll
    elseif playerColor:getLocationIndex() + roll > 40 then
        index = playerColor:getLocationIndex() + roll - 40
        playerColor:addMoney(200)
    end

    playerColor:setLocationIndex(index)
    moveOnBoard(playerColor:getPiece(), boardOrder[index].snapPoint1:getSnapPoint().position)


    local property = 0
    local tileName = boardOrderNames[index]

    --[[ Deal with landing on tiles --]]
    if tileName == 'Go To Jail' then
        moveOneBoard(playerColor:getPiece(), boardOrder[31].snapPoint1:getSnapPoint().position)
        playerColor:setInJail(true)
        return
    elseif tileName == 'Go' or tileName == 'Just Visiting' or tileName == 'Free Parking' then
        return
    elseif tileName == 'Income Tax' then
        playerColor:removeMoney(200)
        printToAll("Bad Luck! Pay 200 to the Bank", color)
        return
    elseif tileName == 'Community Chest 1' or tileName == 'Community Chest 2' or tileName =='Community Chest 3' then
        drawCommunityChestCard(playerColor)
        return
    elseif tileName == 'Chance 1' or tileName == 'Chance 2' or tileName =='Chance 3' then
        drawChanceCard(playerColor)
        return
    else
        for i, v in pairs(properties) do
            if v.name == tileName then
                property = v
            end
        end
        landOnProperty(playerColor, property, color)
    end

end

--[[ Move Property --]]
function moveProperty(property, move, rotation)
    corr = property.getBounds().size["y"]
    move["y"] = move["y"] + corr
    property.setPositionSmooth(move, false, false)
    property.setRotationSmooth(rotation, false, false)
    move["y"] = move["y"] - corr
end

--[[ Move On Board Function --]]
function moveOnBoard(object, move)
    move = board.positionToWorld(move)
    corr = object.getBounds().size["y"] + board.getBounds().size["y"]
    move["y"] = move["y"] + corr
    object.setPositionSmooth(move, false, false)
    move["y"] = move["y"] - corr
end

--[[ Compare Colors --]]
function compareColors(color1, color2)
    return color1:getOrderRoll() > color2:getOrderRoll()
end

function purchaseProperty(playerColor, property)
    playerColor:removeMoney(property.price)
    playerColor:addProperty(property)
    property.owned = true
    property.owner = playerColor
    moveProperty(property.card, playerColor:getSnapPoint().position, playerColor:getSnapPoint().rotation)
end

function landOnProperty(playerColor, property, color)
    local purchased = false
    local playerInfo = 0
    if property.owned then
        local owner = property.owner
        if property.owner:getColor() ~= color then
            if property.houses == 0 then
                playerColor:removeMoney(property.rent)
                owner:addMoney(property.rent)
            elseif property.houses == 1 then
                playerColor:removeMoney(property.oneHouse)
                owner:addMoney(property.oneHouse)
            elseif property.houses == 2 then
                playerColor:removeMoney(property.twoHouse)
                owner:addMoney(property.twoHouse)
            elseif property.houses == 3 then
                playerColor:removeMoney(property.threeHouse)
                owner:addMoney(property.threeHouse)
            elseif property.houses == 4 then
                playerColor:removeMoney(property.fourHouse)
                owner:addMoney(property.fourHouse)
            elseif property.houses == 5 then
                playerColor:removeMoney(property.hotel)
                owner:addMoney(property.hotel)
            end
        end
    elseif not property.owned then
        player = getCurrentPlayer(color)
        player:showOptionsDialog("Do you want to purchase the property: " .. property.name, {"Yes", "No"}, 
        function(selectedText, selectedIndex) 
            if selectedIndex == 1 then
                purchased = true
                purchaseProperty(playerColor, property) 
                printToAll(player.steam_name .. " landed on " .. property.name .. " and purchased it.", color)
            elseif selectedIndex == 2 then
                print("Auction Property") 
            end
        end)

    end
end

function getCurrentPlayerColor(color)
    local playerColor = 0
    for i, colors in ipairs(playerColors) do
        if colors:getColor() == color then
            playerColor = playerColors[i]
        end
    end
    return playerColor
end

function getCurrentPlayer(color)
    local player = 0
    for i, v in ipairs(Player.getPlayers()) do
        if v.color == color then
            player = v
        end
    end
    return player
end

function drawChanceCard(playerColor)
    cards = chancePile.getObjects()
    local cardName = cards[1].name
    chanceCardAction(cardName, playerColor)
    local discardPosition = chancePileDiscardSnapPoint.position
    discardPosition["y"] = discardPosition["y"]  + (0.028 * numChanceDiscard)
    local chanceDrawParameters = 
    {
        position = board.positionToWorld(discardPosition),
        rotation = chancePileDiscardSnapPoint.rotation,
        index = 0,
    }
    local cardDraw = chancePile.takeObject(chanceDrawParameters)
    discardPosition["y"] = discardPosition["y"] - (0.028 * numChanceDiscard)
    numChanceDiscard = numChanceDiscard + 1
end

function passGo(playerColor) 
    playerColor:addMoney(200)
    printToAll("Passed Go, Collected 200$", playerColor.getColor())
end

function chanceCardAction(cardName, playerColor)
    if cardName == "BankPaysDividend" then
        playerColor.addMoney(50)
        printToAll("Collect 50$", playerColor.getColor())
    elseif cardName == "AdvanveToIllinoisAve" then
        if playerColor:getLocationIndex() >= 25 then
            passGo(playerColor)
        end
        moveOnBoard(playerColor:getPiece(), boardOrder[25].snapPoint1:getSnapPoint().position)
        landOnProperty(playerColor,properties[red3],playerColor:getColor())
        playerColor:setLocationIndex(25)
    elseif cardName == "AdvanceToStCharles" then
        if playerColor:getLocationIndex() >= 12 then
            passGo(playerColor)
        end
        moveOnBoard(playerColor:getPiece(), boardOrder[12].snapPoint1:getSnapPoint().position)
        landOnProperty(playerColor,properties[pink1],playerColor:getColor())
        playerColor:setLocationIndex(12)
    elseif cardName == "AdvanceToGo" then
        moveOnBoard(playerColor:getPiece(), boardOrder[1].snapPoint1:getSnapPoint().position)
        playerColor:setLocationIndex(1)
    elseif cardName == "GoToReadingRailroad" then
        if playerColor:getLocationIndex() >= 5 then
            passGo(playerColor)
        end
        moveOnBoard(playerColor:getPiece(), boardOrder[6].snapPoint1:getSnapPoint().position)
        landOnProperty(playerColor,properties[railroad1],playerColor:getColor())
        playerColor:setLocationIndex(6)
    elseif cardName == "AdvanceToBoardwalk" then
        if playerColor:getLocationIndex() >= 40 then
            passGo(playerColor)
        end
        moveOnBoard(playerColor:getPiece(), boardOrder[40].snapPoint1:getSnapPoint().position)
        landOnProperty(playerColor,properties[darkBlue2],playerColor:getColor())
        playerColor:setLocationIndex(40)
    elseif cardName == "GoBackThree" then
        local locIndex = playerColor:getLocationIndex() - 3
        moveOnBoard(playerColor:getPiece(), boardOrder[locIndex].snapPoint1:getSnapPoint().position)
        landOnProperty(playerColor,properties[locIndex],playerColor:getColor())
        playerColor:setLocationIndex(locIndex)
    elseif cardName == "AdvanceToRailroad1" then
        local locIndex = playerColor:getLocationIndex()
        if locIndex >= 36 and locIndex < 6 then
            moveOnBoard(playerColor:getPiece(), boardOrder[6].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[railroad1],playerColor:getColor())
            playerColor:setLocationIndex(6)
        elseif locIndex >= 6 and locIndex < 16 then
            moveOnBoard(playerColor:getPiece(), boardOrder[16].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[railroad2],playerColor:getColor())
            playerColor:setLocationIndex(16)
        elseif locIndex >= 16 and locIndex < 26 then
            moveOnBoard(playerColor:getPiece(), boardOrder[26].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[railroad3],playerColor:getColor())
            playerColor:setLocationIndex(26)
        elseif locIndex >= 26 and locIndex < 36 then
            moveOnBoard(playerColor:getPiece(), boardOrder[36].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[railroad4],playerColor:getColor())
            playerColor:setLocationIndex(36)
        end
    elseif cardName == "AdvanceToRailroad2" then
        local locIndex = playerColor:getLocationIndex()
        if locIndex >= 36 and locIndex < 6 then
            moveOnBoard(playerColor:getPiece(), boardOrder[6].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[railroad1],playerColor:getColor())
            playerColor:setLocationIndex(6)
        elseif locIndex >= 6 and locIndex < 16 then
            moveOnBoard(playerColor:getPiece(), boardOrder[16].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[railroad2],playerColor:getColor())
            playerColor:setLocationIndex(16)
        elseif locIndex >= 16 and locIndex < 26 then
            moveOnBoard(playerColor:getPiece(), boardOrder[26].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[railroad3],playerColor:getColor())
            playerColor:setLocationIndex(26)
        elseif locIndex >= 26 and locIndex < 36 then
            moveOnBoard(playerColor:getPiece(), boardOrder[36].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[railroad4],playerColor:getColor())
            playerColor:setLocationIndex(36)
        end
    elseif cardName == "AdvanceToUtility" then
        local locIndex = playerColor:getLocationIndex()
        if locIndex >= 29 and locIndex < 13 then
            moveOnBoard(playerColor:getPiece(), boardOrder[13].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[utility1],playerColor:getColor())
            playerColor:setLocationIndex(13)
        elseif locIndex >= 13 and locIndex < 29 then
            moveOnBoard(playerColor:getPiece(), boardOrder[29].snapPoint1:getSnapPoint().position)
            landOnProperty(playerColor,properties[utility2],playerColor:getColor())
            playerColor:setLocationIndex(29)
        end
    elseif cardName == "ElectedChairman" then
        local currentColors = getCurrentColors()
        for i, otherColor in ipairs(currentColors) do
            local otherPlayerColor = getCurrentPlayerColor(otherColor)
            otherPlayerColor.addMoney(50)
            playerColor.removeMoney(50)
        end
    elseif cardName == "GoToJail" then
        moveOnBoard(playerColor:getPiece(), inJailSnapPoints.snapPoint1:getSnapPoint().position)
        playerColor.setInJail(true)
    elseif cardName == "PoorTax" then
        playerColor.removeMoney(15)
    elseif cardName == "AssessedForStreetRepairs" then
        print("Assessed for street repairs")
    elseif cardName == "GetOutOfJailFree" then
        print("You got a get out of jail free card!")
    elseif cardName == "BuildingLoanMatures" then
        playerColor.addMoney(150)
    end
end

function drawCommunityChestCard()
    cards = communityChestPile.getObjects()
    cardName = cards[1].name
    local discardPosition = board.positionToWorld(communityChestPileDiscardSnapPoint.position)
    discardPosition["y"] = discardPosition["y"] + (0.028 * numCommunityChestDiscard)
    local discardRotation = communityChestPileDiscardSnapPoint.rotation
    discardRotation["x"] = discardRotation["x"] + 180
    

    local communityChestDrawParameters = 
    {
        position = discardPosition,
        rotation = communityChestPileDiscardSnapPoint.rotation,
        index = 1
    }
    communityChestPile.takeObject(communityChestDrawParameters)
    discardPosition["y"] = discardPosition["y"] - (0.028 * numCommunityChestDiscard)
    discardRotation["x"] = discardRotation["x"] - 180
    communityChestCardAction(cardName)
    numCommunityChestDiscard = numCommunityChestDiscard + 1
end

function communityChestCardAction(cardName,playerColor)
    print("Card Action")
end

function getCurrentColors()
    local currentColors = {}
    for i, player in ipairs(Player.getPlayers()) do
        currentColors[i] = Player.color
    end
    return currentColors
end