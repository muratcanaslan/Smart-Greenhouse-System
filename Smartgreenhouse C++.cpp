// This #include statement was automatically added by the Particle IDE.
#include <PietteTech_DHT.h>



/*
DHT11 sensörü ile sıcaklık ve nem ölçülür. +
Toprak nem sensörü ile topraktaki nemin kontrolü yapılır.(Eğer nem az ise su motoru çalışır. Kullanıcıya sulama yapıldığına dair mesaj gider.) +
Su seviyesi sensörü ile depodaki suyun kontrolu yapılır. +
Metan gazı sensörü kontrolü yapılır.. (Ters bir durum varsa buzzer çalışır ve uygulamadan kullanıcıya mesaj gider. ) +
Gece sensöründen aydınlık veya karanlık kontrolü yapılır. (Gece ise (uygulama dark mode) RGB'ler yanar. Aydınlık ise hiç bir şey yapılmaz.) +
Yağmur sensöründen hava durumu kontrol edilir. (Yağmur yağdığı zamanlarda servo motor ile çatılar açılır.) ?
Alev algılayıcı sensör kontrolü yapılır. (Alev algılanmışsa buzzer öter ve itfaiyeyi aranması için kullanıcıya bildirim gönderir.) ? 
Buzzer**
RGB**
Su motoru**
2 adet servomotor**
*/

//Tek eksik LDR SENSOR-DHT11.!!-ALEV ALGILAYICI? METANGAZI?
//D0-D1-D2-D3-A4-A5 PWM pins
//Pins 

#define DHTPIN D4
#define DHTTYPE DHT11
PietteTech_DHT DHT(DHTPIN, DHTTYPE);
Servo leftRoofServo;
Servo rightRoofServo;


#define soilMoistureSensor A0
#define rainSensor  A1
#define gasSensor  A2
#define waterLevelSensor A3
#define ldrSensor A4
#define flameSensor A5
#define lightingR D0
#define lightingG D1
#define lightingB D2
#define buzzerPin  D3
#define waterPump  D5
#define leftServoMotor  D6
#define rightServoMotor  D7

//Particle Variables

int gasRate = 0;  //METANGAS VARIABLE
int leftServoPosition = 0; //SERVOPOSITION ON(0) - OFF(180)
int rightServoPosition = 0; //SERVOPOSITION ON(0) - OFF(180)
int tempCelcius = 0; //TEMPERATURE VARIABLE
int humidity = 0; //HUMIDITY VARIABLE
int flameRate = 0; // FLAME VARIABLE
int rainRate = 0; // RAIN VARIABLE
int waterLevelRate = 0; // WATER LEVEL VARIABLE
int soilMoistureRate = 0; // SOIL MOISTURE VARIABLE
int ldrRate = 0; //LDR SENSOR VARIABLE
int n;   //Counter to DHT11 code.





//Functions
int mapOperation4096To100(int value);
int getMetanGasRate(); // metan gaz oranını yüzdeye çevir !
int getSoilMoistureRate();  // toprak nem sensörünü yüzdeye çevir !
int getWaterLevelRate(); // su seviyesini yüzdeye çevir !
int getRainRate();
int getFlameRate();
int getLdrSensorRate();


//Particle Functions
int rightRoofState(String input);
int leftRoofState(String input);  // Çatının açılıp kapanılır olması için
int openCloseBuzzer(String input); //Buzzerı manuel kapatmak için
int openCloseWaterPump(String input); //Su motorunu mauel kontrol etmek için
int systemLightingRed(String input);
int systemLightingGreen(String input);
int systemLightingBlue(String input);
int systemLightingYellow(String input);
int systemLightingSilver(String input);
int systemLightingCyan(String input);
int systemLightingMagenta(String input);
int systemLightingWhite(String input);




void setup() {

	Serial.begin(9600);
	Serial.println("Welcome to Smart Greenhouse System...");
	Serial.println("Initiliazing variables...");
	Serial.println("Tomate Mode has been activated");
	




	//Particle Variables

    Particle.variable("gas", gasRate);
	Particle.variable("temp", tempCelcius);
	Particle.variable("hum", humidity);
	Particle.variable("soilMo", soilMoistureRate);
	Particle.variable("fire", flameRate);
	Particle.variable("rain", rainRate);
    Particle.variable("ldr",ldrRate);
	Particle.variable("leftServoPos", leftServoPosition);
	Particle.variable("rightServoPos", rightServoPosition);
	Particle.variable("waterLevel", waterLevelRate);

	//ParticleFunctions
    Particle.function("rightRoofState", rightRoofState);
	Particle.function("leftRoofState", leftRoofState);
    Particle.function("systemLightingRed",systemLightingRed);
	Particle.function("systemLightingGreen",systemLightingGreen);
	Particle.function("systemLightingBlue",systemLightingBlue);
	Particle.function("systemLightingYellow",systemLightingYellow);
	Particle.function("systemLightingSilver",systemLightingSilver);
	Particle.function("systemLightingCyan",systemLightingCyan);
	Particle.function("systemLightingMagenta",systemLightingMagenta);
	Particle.function("systemLightingWhite",systemLightingWhite);
	Particle.function("openCloseBuzzer", openCloseBuzzer);
	Particle.function("openCloseWaterPump",openCloseWaterPump);

	DHT.begin();
	leftRoofServo.attach(leftServoMotor);
	leftRoofServo.write(leftServoPosition);
	rightRoofServo.attach(rightServoMotor);
	rightRoofServo.write(rightServoPosition);

	pinMode(lightingR,OUTPUT);  //D0
    pinMode(lightingG,OUTPUT);  //D1
    pinMode(lightingB,OUTPUT);  //D2
    pinMode(buzzerPin, OUTPUT);  //D3
    pinMode(waterPump,OUTPUT);  //D5
    pinMode(rainSensor,INPUT); //A1
    pinMode(flameSensor,INPUT); // A5
    pinMode(gasSensor, INPUT);  //A2
    pinMode(ldrSensor,INPUT);  //A4
    pinMode(waterLevelSensor,INPUT);  // A3
    pinMode(soilMoistureSensor,INPUT); //A0
    pinMode(leftServoMotor,OUTPUT);
    pinMode(rightServoMotor,OUTPUT);
    systemOff();
    
    Serial.println("System is starting now...");






}


void loop() {

	delay(100);
	Serial.print("Time : ");
	Serial.println(Time.timeStr());  //Time metodunu calıstırıyoruz.

	//DHT11 Sensörünün Okunması
	
	int result = DHT.acquireAndWait(1000);
	switch (result) {
    case DHTLIB_OK:
      Serial.println("OK");
      break;
    case DHTLIB_ERROR_CHECKSUM:
      Serial.println("Error\n\r\tChecksum error");
      break;
    case DHTLIB_ERROR_ISR_TIMEOUT:
      Serial.println("Error\n\r\tISR time out error");
      break;
    case DHTLIB_ERROR_RESPONSE_TIMEOUT:
      Serial.println("Error\n\r\tResponse time out error");
      break;
    case DHTLIB_ERROR_DATA_TIMEOUT:
      Serial.println("Error\n\r\tData time out error");
      break;
    case DHTLIB_ERROR_ACQUIRING:
      Serial.println("Error\n\r\tAcquiring");
      break;
    case DHTLIB_ERROR_DELTA:
      Serial.println("Error\n\r\tDelta time to small");
      break;
    case DHTLIB_ERROR_NOTSTARTED:
      Serial.println("Error\n\r\tNot started");
      break;
    default:
      Serial.println("Unknown error");
      break;
  }

	humidity = DHT.getHumidity();
	tempCelcius = DHT.getCelsius();
	if(isnan(humidity) || isnan(tempCelcius)) {
		Serial.println("Uyarı ! -> Sıcaklık ve nem sensörü okunmuyor !");
	} else {
	    delay(100);
		Serial.print("Humid: "); 
	    Serial.print(humidity);
	    Serial.print("% - ");
	    Serial.print("Temp: "); 
	    Serial.print(tempCelcius);
	    Serial.println("*C");
	}
	
	delay(100);
    
    //LDR Sensörünün map ve okunması
    ldrRate = getLdrSensorRate();
    
    if(ldrRate > 50) {
        delay(100);
        Serial.print("Ldr Rate :");
        Serial.println(ldrRate);
       
    }else{
        delay(100);
        Serial.print("LdrRate: ");
        Serial.println(ldrRate);
        
    }
    delay(200);
    
    //MQ-4 Gaz sensörünün map ve okunması.

	gasRate = getMetanGasRate();
	
    if (gasRate > 35) {
            delay(100);
	        Serial.print("Gas Rate: ");
	        Serial.println(gasRate);
		    digitalWrite(buzzerPin, LOW);
    }else {
            delay(100);
	        Serial.print("Gas Rate: ");
	        Serial.println(gasRate);
	        digitalWrite(buzzerPin, LOW);
	    }
	
	
	delay(200);
    
    //Su seviyesi sensörünün map ve okunması

	waterLevelRate = getWaterLevelRate();

    if(waterLevelRate > 40) {
            delay(100);
            Serial.print("Water Level Rate : ");
		    Serial.println(waterLevelRate);
		    Serial.println("Su seviyesi yarısından fazladır.");
	    }else{
	        delay(100);
	        Serial.print("Water Level Rate : ");
	     	Serial.println(waterLevelRate);
	    	Serial.println("Uyarı ! -> Su seviyesi yarısından azdır ! ");
	    	Serial.println("Uyarı ! ->Depoya su ilave ediniz ! ");
	    }
	
	delay(200);
    
    //Alev algılayıcı sensörün okunması

	flameRate = getFlameRate();
    
	if(flameRate > 85) {
	    	delay(100);
		    Serial.print("Flame rate : ");
	 	    Serial.println(flameRate);
			Serial.println("İtfaiyeyi arayınız !");
			digitalWrite(buzzerPin,HIGH);
	}else {
	    	delay(100);
	        Serial.print("Flame rate : ");
		    Serial.println(flameRate);
		    digitalWrite(buzzerPin,LOW);
		}
	delay(200);
		
	
    //Toprak nem sensörünün map ve okunması
    
    soilMoistureRate = getSoilMoistureRate();

		
	if (soilMoistureRate > 30){
		    Serial.print("Soil Moisture Rate : ");
		    Serial.println(soilMoistureRate);
         	digitalWrite(waterPump,HIGH);
         	delay(2000);
	}else{
	    	delay(100);
		    Serial.print("Soil Moisture Rate : ");
	     	Serial.println(soilMoistureRate);
	     	digitalWrite(waterPump,LOW);
		}
	delay(200);

    //Yağmur sensörünün map edilmesi ve okunması
	rainRate = getRainRate();

    if(rainRate >= 81){
        
		delay(100);
        Serial.print("Rain rate: ");
		Serial.println(rainRate);
		Serial.println("Yağmur yok");
        delay(50);
	}else if( rainRate > 40 && rainRate < 81 ){
        leftServoPosition = 180;
        delay(50);
        rightServoPosition = 180;
        delay(50);
        leftRoofServo.write(leftServoPosition);
        rightRoofServo.write(rightServoPosition);
        delay(50);
        digitalWrite(waterPump,LOW);
		delay(100);
        Serial.print("Rain rate : ");
        Serial.println(rainRate);
		Serial.println("Yağmur yağıyor");
	}else{
        leftServoPosition = 180;
        delay(50);
        rightServoPosition = 180;
        delay(50);
        leftRoofServo.write(leftServoPosition);
        rightRoofServo.write(rightServoPosition);
        delay(50);
        digitalWrite(waterPump,LOW);
        Serial.print("Rain rate : ");
	    Serial.println(rainRate);
		Serial.println("Sağanak yağış !");
	}
    delay(200);
}

//System off function
void systemOff(){
    delay(50);
	digitalWrite(lightingR, LOW);
    digitalWrite(lightingG, LOW);
    digitalWrite(lightingB, LOW);
    digitalWrite(waterPump, LOW);
    digitalWrite(buzzerPin, LOW);
    digitalWrite(leftServoMotor,LOW);
    digitalWrite(rightServoMotor,LOW);
    delay(50);
}	

//Red Light Control
int systemLightingRed(String input){
    delay(50);
    Serial.println(input);
    String state = input.substring(0,2);
    
    if(state == "0"){
        Serial.println("Kapalı");
        digitalWrite(lightingR,LOW);
        digitalWrite(lightingG,LOW);
        digitalWrite(lightingB,LOW);
        return 0;
        
    }else if(state == "1"){
        digitalWrite(lightingR,255);
        digitalWrite(lightingG,0);
        digitalWrite(lightingB,0);
        delay(50);
        return 1;
    }else{
        Serial.println("Set Light Error: Wrong parameter!!!");
        Serial.print("Parameter: ");
        Serial.println(input);
        delay(50);
        return -1;
    }
    delay(50);
}

//Green Light Control
int systemLightingGreen(String input){
    delay(50);
    Serial.println(input);
    String state = input.substring(0,2);
    
    if(state == "0"){
        Serial.println("Kapalı");
        digitalWrite(lightingR,LOW);
        digitalWrite(lightingG,LOW);
        digitalWrite(lightingB,LOW);
        delay(50);
        return 0;
        
    }else if(state == "1"){
        digitalWrite(lightingR,0);
        digitalWrite(lightingG,255);
        digitalWrite(lightingB,0);
        delay(50);
        return 1;
    }else{
        Serial.println("Set Light Error: Wrong parameter!!!");
        Serial.print("Parameter: ");
        Serial.println(input);
        delay(50);
        return -1;
    }
    delay(50);
}

//Blue Light Control
int systemLightingBlue(String input){
    delay(50);
    Serial.println(input);
    String state = input.substring(0,2);
    
    if(state == "0"){
        Serial.println("Kapalı");
        digitalWrite(lightingR,LOW);
        digitalWrite(lightingG,LOW);
        digitalWrite(lightingB,LOW);
        delay(50);
        return 0;
    }else if(state == "1"){
        digitalWrite(lightingR,0);
        digitalWrite(lightingG,0);
        digitalWrite(lightingB,255);
        delay(50);
        return 1;
    }else{
        Serial.println("Set Light Error: Wrong parameter!!!");
        Serial.print("Parameter: ");
        Serial.println(input);
        delay(50);
        return -1;
    }
    delay(50);
}

//Yellow Light Control
int systemLightingYellow(String input){
    delay(50);
    Serial.println(input);
    String state = input.substring(0,2);
    
    if(state == "0"){
        Serial.println("Kapalı");
        digitalWrite(lightingR,LOW);
        digitalWrite(lightingG,LOW);
        digitalWrite(lightingB,LOW);
        delay(50);
        return 0;
    }else if(state == "1"){
        digitalWrite(lightingR,255);
        digitalWrite(lightingG,255);
        digitalWrite(lightingB,0);
        delay(50);
        return 1;
    }else{
        Serial.println("Set Light Error: Wrong parameter!!!");
        Serial.print("Parameter: ");
        Serial.println(input);
        delay(50);
        return -1;
    }
    delay(50);
}

//Cyan Light Control
int systemLightingCyan(String input){
    delay(50);
    Serial.println(input);
    String state = input.substring(0,2);
    
    if(state == "0"){
        Serial.println("Kapalı");
        digitalWrite(lightingR,LOW);
        digitalWrite(lightingG,LOW);
        digitalWrite(lightingB,LOW);
        delay(50);
        return 0;
    }else if(state == "1"){
        digitalWrite(lightingR,0);
        digitalWrite(lightingG,255);
        digitalWrite(lightingB,255);
        delay(50);
        return 1;
    }else{
        Serial.println("Set Light Error: Wrong parameter!!!");
        Serial.print("Parameter: ");
        Serial.println(input);
        delay(50);
        return -1;
    }
    delay(50);
}

//White Light Control
int systemLightingWhite(String input){
    delay(50);
    Serial.println(input);
    String state = input.substring(0,2);
    
    if(state == "0"){
        digitalWrite(lightingR,LOW);
        digitalWrite(lightingG,LOW);
        digitalWrite(lightingB,LOW);
        delay(50);
        return 0;
        
    }else if(state == "1"){
        digitalWrite(lightingR,255);
        digitalWrite(lightingG,255);
        digitalWrite(lightingB,255);
        delay(50);
        return 1;
    }else{
        Serial.println("Set Light Error: Wrong parameter!!!");
        Serial.print("Parameter: ");
        Serial.println(input);
        delay(50);
        return -1;
    }
    delay(50);
}

//Magenta Light Control
int systemLightingMagenta(String input){
    delay(50);
    Serial.println(input);
    String state = input.substring(0,2);
    
    if(state == "0"){
        Serial.println("Kapalı");
        digitalWrite(lightingR,LOW);
        digitalWrite(lightingG,LOW);
        digitalWrite(lightingB,LOW);
        delay(50);
        return 0;
    }else if(state == "1"){
        digitalWrite(lightingR,255);
        digitalWrite(lightingG,0);
        digitalWrite(lightingB,255);
        delay(50);
        return 1;
    }else{
        Serial.println("Set Light Error: Wrong parameter!!!");
        Serial.print("Parameter: ");
        Serial.println(input);
        delay(50);
        return -1;
    }
    delay(50);
}

//Silver Light Control
int systemLightingSilver(String input){
    delay(50);
    Serial.println(input);
    String state = input.substring(0,2);
    
    if(state == "0"){
        Serial.println("Kapalı");
        digitalWrite(lightingR,LOW);
        digitalWrite(lightingG,LOW);
        digitalWrite(lightingB,LOW);
        delay(50);
        return 0;
    }else if(state == "1"){
        Serial.println("Açık");
        digitalWrite(lightingR,192);
        digitalWrite(lightingG,192);
        digitalWrite(lightingB,192);
        delay(50);
        return 1;
    }else{
        Serial.println("Set Light Error: Wrong parameter!!!");
        Serial.print("Parameter: ");
        Serial.println(input);
        delay(50);
        return -1;
    }
    delay(50);
}

//Right Roof Control
int rightRoofState(String input){
	delay(50);
	Serial.println(input);
	String state = input.substring(0,2);

	if(state == "0") {
		rightServoPosition = 0;
		delay(50);
		rightRoofServo.write(rightServoPosition);
		delay(50);
		return 0;  //Right Root is closed
	}else if(state == "1") {
		delay(50);
		rightServoPosition = 180;
		delay(50);
		rightRoofServo.write(rightServoPosition);
		delay(50);
		return 1; //Right Roof is opened
	}else{
		Serial.println("RightRoofState Error : Wrong Parameter");
		Serial.print("Parameter : ");
		Serial.println(input);
		delay(50);
		return -1;
	}
	delay(50);
}
//Left Roof Control
int leftRoofState(String input){
	delay(50);
	Serial.println(input);
	String state = input.substring(0,2);

	if(state == "0") {
		leftServoPosition = 0;
		delay(50);
		leftRoofServo.write(leftServoPosition);
		delay(50);
		return 0;  //Right Root is closed
	}else if(state == "1") {
		delay(50);
		leftServoPosition = 180;
		delay(50);
		leftRoofServo.write(leftServoPosition);
		delay(50);
		return 1; //Right Roof is opened
	}else{
		Serial.println("LeftRoofState Error : Wrong Parameter");
		Serial.print("Parameter : ");
		Serial.println(input);
		delay(50);
		return -1;
	}
	delay(50);
}

//Buzzer Control
int openCloseBuzzer(String input){
	delay(50);
	Serial.println(input);
	String state = input.substring(0,2);
    
	if(state == "0"){
		delay(50);
		digitalWrite(buzzerPin,LOW);
		delay(50);
		return 0;
	}else if(state == "1") {
		delay(50);
		digitalWrite(buzzerPin,HIGH);
		delay(50);
		return 1;	
	}else{
	    delay(50);
		Serial.println("BuzzerPin : Wrong Parameter");
		Serial.print("Parameter : ");
		Serial.println(input);
		delay(50);
		return -1;
	}
    delay(50);
}
//Water Pump Control
int openCloseWaterPump(String input){
	delay(50);
	Serial.println(input);
	String state = input.substring(0,2);
    
	if(state == "0"){
		delay(50);
		digitalWrite(waterPump,LOW);
		delay(50);
		return 0;
	}else if(state == "1") {
		delay(50);
		digitalWrite(waterPump,HIGH);
		delay(50);
		return 1;	
	}else{
	    delay(50);
		Serial.println("Water Pum : Wrong Parameter");
		Serial.print("Parameter : ");
		Serial.println(input);
		delay(50);
		return -1;
	}
    delay(50);
}
// Mapping Functions to percentage !

int getFlameRate(){
	int flameRateValue = analogRead(flameSensor);
	flameRateValue = mapOperation4096To100(flameRateValue);
	return flameRateValue;
}

int getMetanGasRate(){
	int metanGasValue = analogRead(gasSensor);
	metanGasValue = mapOperation4096To100(metanGasValue);
	return metanGasValue;
}

int getSoilMoistureRate(){
	int soilMoistureValue = analogRead(soilMoistureSensor);
	soilMoistureValue = mapOperation4096To100(soilMoistureValue);
	return soilMoistureValue;
}

int getWaterLevelRate(){
	int waterLevelRateValue = analogRead(waterLevelSensor);
	waterLevelRateValue = mapOperation4096To100(waterLevelRateValue);
	return waterLevelRateValue;
}

int getRainRate(){
	int rainRateValue = analogRead(rainSensor);
	rainRateValue = mapOperation4096To100(rainRateValue);
	return rainRateValue;
}

int getLdrSensorRate(){
    int ldrRateValue = analogRead(ldrSensor);
    ldrRateValue = mapOperation4096To100(ldrRateValue);
    return ldrRateValue;
}

int mapOperation4096To100(int value) {
	value = ((100 * value) / 4096);
	return value;
}
