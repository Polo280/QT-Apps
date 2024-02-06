#include "serialhandler.h"

// Constructor
SerialHandler::SerialHandler(QObject *parent)
    : QObject{parent}
{
    connect(serialPort, &QSerialPort::errorOccurred, this, &SerialHandler::handleError);
    connect(serialPort, &QSerialPort::readyRead, this, &SerialHandler::newDataHandler);

    // Initialize buffer
    data = new QByteArray();
}

// Destructor
SerialHandler::~SerialHandler(void)
{
    delete(serialPort);
    delete(data);
}

// SLOTS
// Whenever QserialPort::errorOccurred event is raised, get the error and emit as a signal which contains the message
void SerialHandler::handleError(void){
    QString errorMessage = serialPort->errorString();
    emit errorOccurred(errorMessage);
}

// Handles incoming data and emits a signal containing it in QString format
void SerialHandler::newDataHandler(){
    if(this->readLine()){
        emit newDataReceived(QString::fromUtf8(*data));
        data->clear();
    }
}

// Configuring functions
void SerialHandler::configurePort(QString baudRate, const QString portName){
    serialPort->setBaudRate(baudRates[baudRate]);
    serialPort->setPortName(portName);
}

// Open port
void SerialHandler::openPort(int mode){
    serialPort->open(serialMode[mode]);
}

// Serial Read & store into buffer
bool SerialHandler::readLine(void){
    data->append(serialPort->readAll());
    return (data->contains("\n"))? true : false;
}

// View if serial communication is currently active
bool SerialHandler::isConnected(void){
    return serialPort->isOpen();
}

// Close port
void SerialHandler::closePort(void){
    if(serialPort->isOpen()){
        serialPort->close();
    }
}

