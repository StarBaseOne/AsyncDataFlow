
import uuid
import datetime
import time
from random import randint


def _globally_unique_id()-> str:
    """Return a hexadecimal UUID."""
    return ''.join(uuid.uuid4().hex)

def _temperature_f() -> float:
    """Return a random Fahrenheit temperature between 0.00 and 500.00."""
    return randint(0, 50000) / 100

def _time_of_measurement() -> str:
    """Return Current Datetime in ISO format"""

    epoch_sec = int(round(time.time()))
    dt = datetime.datetime.utcfromtimestamp(epoch_sec)
    return dt.isoformat()

def create_sensor_content() -> dict:
    """Create the sensor content"""
    return {
        'temperature_f': _temperature_f(),
        'time_of_measurement': _time_of_measurement()
    }

def create_single_payload() -> dict:
    """Create a fake, randomised transaction."""
    return {
        'id': _globally_unique_id(),
        'type': 'SENSOR',
        'content': create_sensor_content()
    }
